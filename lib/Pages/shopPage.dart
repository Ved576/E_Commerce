import 'package:e_commerce/Pages/cartPage.dart';
import 'package:e_commerce/components/MyDrawer.dart';
import 'package:e_commerce/components/productTile.dart';
import 'package:e_commerce/models/shopModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    final products = context.watch<shopModel>().shop;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'SHOPPING',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w900,
            color: Colors.grey[700],
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: IconButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartPage()),
              ),
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.grey[700],
                size: 30,
              ),
            ),
          ),
        ],
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: ListView(
        children: [
          SizedBox(height: 20),
          Center(
            child: Text(
              'Select from the premium products',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: Colors.grey[700],
                fontStyle: FontStyle.italic,
              ),
            ),
          ),

          SizedBox(
            height: 650,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              padding: EdgeInsets.all(20),
              itemBuilder: (context, index) {
                final product = products[index];

                return ProductTile(products: product);
              },
            ),
          ),
        ],
      ),
      drawer: MyDrawer(),
    );
  }
}
