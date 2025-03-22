import 'dart:developer';

import 'package:ecommerce_workshop/provider/cart_provider.dart';
import 'package:ecommerce_workshop/screens/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

class detailsPage extends StatelessWidget {
  detailsPage({
    super.key,
    required this.id,
    required this.image,
    required this.name,
    required this.price,
    required this.descrption,
  });

  String image, name, price, descrption;
  int id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
  
            Stack(
              children: [
                Image.network(
                  image.toString(),
                  height: 200,
                ),
                Positioned(
                    left: 15,
                    top: 20,
                    child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                            child: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.arrow_back_ios_new,
                                  color: Colors.black,
                                )))))
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: Color(0xffE8E8E8),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      name.toString(),
                      style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Rs " + price.toString(),
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      descrption.toString(),
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: InkWell(
        onTap: () {
          log('clicked');
          var existingItemCart = context
              .read<Cart>()
              .getItems
              .firstWhereOrNull((element) => element.id == id);

          if (existingItemCart != null) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                duration: Duration(seconds: 3),
                behavior: SnackBarBehavior.floating,
                padding: EdgeInsets.all(15),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(9)),
                    side: BorderSide.none),
                content: Text(
                  'This item is already in cart',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: Colors.white),
                )));
          } else {
            context
            .read<Cart>()
            .addItem(id, name, double.parse(price), 1, image);

            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            duration: Duration(seconds: 3),
            behavior: SnackBarBehavior.floating,
            padding: EdgeInsets.all(15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(9)),
              side: BorderSide.none
            ),
              content: Text('Added to cart!',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white,
                              fontSize: 18),)
                              ));
          }
        },
        child: Container(
          height: 60,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Color(0xFFFF151E3D),
                borderRadius: BorderRadius.circular(9),
              ),
              child: Center(
                child: Text(
                  'Add to Cart',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
