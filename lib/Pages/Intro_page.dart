import 'package:e_commerce/Pages/shopPage.dart';
import 'package:flutter/material.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_bag,
              color: Theme.of(context).colorScheme.inversePrimary,
              size: 160,
            ),

            SizedBox(height: 20),

            Text(
              'CharacterGoods',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w900,
                color: Colors.black,
                fontStyle: FontStyle.italic,
              ),
            ),

            Text(
              'Premium Quality Product',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.inversePrimary,
                fontStyle: FontStyle.italic,
              ),
            ),

            SizedBox(height: 35,),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: Theme.of(context).colorScheme.inversePrimary
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> ShopPage()));
              },
              child: Text('Start Shopping', style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary
              )),
            ),
          ],
        ),
      ),
    );
  }
}
