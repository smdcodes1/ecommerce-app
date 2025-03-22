import 'dart:developer';

import 'package:ecommerce_workshop/screens/details_screen.dart';
import 'package:ecommerce_workshop/webservice/webservice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class categoryProductsPage extends StatelessWidget {
  categoryProductsPage({super.key, required this.catname, required this.catid});

  String catname;

  int catid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text(
          catname,
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios_new)),
      ),
      body: FutureBuilder(
        future: Webservice().fetchCatProducts(catid),
        
        builder: (context, snapshot) {
        
          if (snapshot.hasData) {
            
            return MasonryGridView.count(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 2,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final procduct= snapshot.data![index];
                return InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => 
                      detailsPage(id: procduct.id,
                       image: 'http://bootcamp.cyralearnings.com/products/'+ procduct.image,
                        name: procduct.productname,
                         price: procduct.price.toString(),
                          descrption: procduct.description),));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                            ),
                            child: Container(
                                constraints: BoxConstraints(
                                    minHeight: 100, maxHeight: 250),
                                child: Image(
                                    image: NetworkImage(
                                        'http://bootcamp.cyralearnings.com/products/' +
                                            procduct.image))),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  procduct.productname,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              children: [
                                Text(
                                  'Rs ' +
                                      procduct.price.toString(),
                                  style: TextStyle(
                                    color: Colors.redAccent,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
