import 'package:e_commerce/models/products.dart';
import 'package:e_commerce/models/shopModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductTile extends StatelessWidget {
  final Products products;

  const ProductTile({super.key, required this.products});

  void addToCart(BuildContext context) {
    showDialog(context: context,
        builder: (context) => AlertDialog(
          content: Text(
            'Add item to cart?'
          ),
          actions: [
            //cancel
            MaterialButton(onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),),

            //add yes
            MaterialButton(onPressed: () {
              Navigator.pop(context);

              //add to cart
              context.read<shopModel>().addToCart(products);

            }, child: Text('Yes'),)
          ],
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.all(30),
      width: 300,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //img
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Container(
                  padding: EdgeInsets.all(25),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Image.asset(products.imgPath),
                ),
              ),

              SizedBox(height: 20),

              //product name
              Text(
                products.name,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
              ),

              SizedBox(height: 5),

              //product description
              Text(
                products.description,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),

          //price + cart
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$' + products.price.toStringAsFixed(2),
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                ),
              ),

              Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: IconButton(
                  onPressed: () => addToCart(context),
                  icon: Icon(Icons.add, color: Colors.grey, size: 30),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
