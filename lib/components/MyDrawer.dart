import 'package:e_commerce/Pages/Intro_page.dart';
import 'package:e_commerce/Pages/cartPage.dart';
import 'package:e_commerce/Pages/shopPage.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              DrawerHeader(
                child: Icon(
                  Icons.shopping_bag,
                  size: 90,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
              Divider(height: 10, color: Colors.grey),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: ListTile(
                  leading: Icon(
                    Icons.home,
                    color: Theme.of(context).colorScheme.inversePrimary,
                    size: 35,
                  ),
                  title: Text(
                    'SHOP',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ShopPage()));
                  },
                ),
              ),

              SizedBox(height: 15,),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: ListTile(
                  leading: Icon(
                    Icons.shopping_cart,
                    color: Theme.of(context).colorScheme.inversePrimary,
                    size: 35,
                  ),

                  title: Text(
                    'CART',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CartPage()));
                  },
                ),
              ),

            ],
          ),

          Padding(
            padding: const EdgeInsets.only(left: 15.0, bottom: 25),
            child: ListTile(
              leading: Icon(
                Icons.arrow_back,
                color: Theme.of(context).colorScheme.inversePrimary,
                size: 35,
              ),
              title: Text(
                'EXIT',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => IntroPage()));
              },
            ),
          ),

        ],
      ),
    );
  }
}




