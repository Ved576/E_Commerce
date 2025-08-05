import 'package:e_commerce/components/MyDrawer.dart';
import 'package:e_commerce/models/products.dart';
import 'package:e_commerce/models/shopModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late Razorpay _razorpay;

  // IMPORTANT: Use the correct IP address for your setup.
  // For Android Emulator, use '10.0.2.2'.
  // For a physical device, use your computer's local IP address (e.g., '192.168.1.136').
  // Make sure your device and computer are on the same Wi-Fi network.
  //final String serverIp = '192.168.1.136';

  final String serverUrl = 'https://e-commerce-backhand.onrender.com';

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Verifying Payment...')),
    );

    print("--- Sending Data for Verification ---");
    print("Sending Order ID: ${response.orderId}");
    print("Sending Payment ID: ${response.paymentId}");
    print("Sending Signature: ${response.signature}");

    try {
      final uri = Uri.parse('$serverUrl/verify-signature');
      final serverResponse = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'order_id': response.orderId,
          'payment_id': response.paymentId,
          'razorpay_signature': response.signature,
        }),
      );

      if (serverResponse.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("PAYMENT SUCCESSFUL AND VERIFIED.")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("PAYMENT VERIFICATION FAILED! Please contact support.")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('An error occured during verification: ${e.toString()}')),
      );
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("PAYMENT FAILED: ${response.message}")),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("External Wallet: ${response.walletName}")),
    );
  }

  void removeItemFromCart(BuildContext context, Products product) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: const Text('Remove item from cart?'),
        actions: [
          MaterialButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          MaterialButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<shopModel>().removeFromCart(product);
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  void payButtonPressed(BuildContext context) async {
    final cart = context.read<shopModel>().cart;
    if (cart.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("YOUR CART IS EMPTY.")),
      );
      return;
    }

    double totalAmount = cart.fold(0, (sum, item) => sum + item.price);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      // FIX 1: ADDED THE "http://" SCHEME TO THE URI.
      // The error "no host specified" happens when the scheme (like http://) is missing.
      final response = await http.post(
        Uri.parse("https://e-commerce-backhand.onrender.com/create-order"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"amount": totalAmount}),
      );

      if (mounted) Navigator.pop(context);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // FIX 2: CORRECTED THE JSON KEY FROM 'orderID' TO 'orderId'.
        // Your Node.js server sends 'orderId' (lowercase 'd').
        final String orderId = data['orderId'];

        var options = {
          'key': 'rzp_test_ryW0AG51bDcWZc',
          'amount': (totalAmount * 100).toInt(),
          'name': 'CharacterGoods',
          'order_id': orderId,
          'description': 'Premium Quality Products',
          'prefill': {'contact': '8888888888', 'email': 'test.user@example.com'}
        };
        _razorpay.open(options);
      } else {
        throw Exception('Failed to create order on the server.');
      }
    } catch (e) {
      if (mounted) Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<shopModel>().cart;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'CART',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w900,
            color: Colors.grey[700],
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Expanded(
            child: cart.isEmpty
                ? Center(
                child: Text(
                  'Your Cart Is Empty....',
                  style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ))
                : ListView.builder(
              itemCount: cart.length,
              itemBuilder: (context, index) {
                final item = cart[index];

                return ListTile(
                  title: Text(item.name),
                  subtitle: Text(item.price.toStringAsFixed(2)),
                  trailing: IconButton(
                    onPressed: () => removeItemFromCart(context, item),
                    icon: const Icon(Icons.remove),
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              backgroundColor: Colors.grey[700],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () => payButtonPressed(context),
            child: const Text(
              'PAY NOW',
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
            ),
          ),
          const SizedBox(height: 50),
        ],
      ),
      drawer: MyDrawer(),
    );
  }
}
