import 'package:ecommerce_workshop/constants.dart';
import 'package:ecommerce_workshop/screens/category_screen/category_products_page.dart';
import 'package:ecommerce_workshop/screens/details_screen.dart';
import 'package:ecommerce_workshop/webservice/webservice.dart';
import 'package:ecommerce_workshop/widgets/categories.dart';
import 'package:ecommerce_workshop/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';

class homePage extends StatelessWidget {
  homePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'E-COMMERCE',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color(0xFFFF151E3D),
          elevation: 10,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Category',
                    style: TextStyle(
                        color: Color(0xFFFF151E3D),
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: FutureBuilder(
                      future: Webservice().fetchCategory(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.all(8),
                              child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              categoryProductsPage(
                                                  catname: snapshot
                                                      .data![index].category,
                                                  catid:
                                                      snapshot.data![index].id),
                                        ));
                                  },
                                  child: category(
                                      text: snapshot.data![index].category)),
                            ),
                          );
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      },
                    )),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Most Searched products',
                    style: TextStyle(
                        color: Color(0xFFFF151E3D),
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: FutureBuilder(
                    future: Webservice().fetchProduct(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return MasonryGridView.builder(
                          shrinkWrap: true,
                          gridDelegate:
                              SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            final procduct = snapshot.data![index];
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => detailsPage(
                                          id: procduct.id,
                                          image:
                                              'http://bootcamp.cyralearnings.com/products/' +
                                                  procduct.image,
                                          name: procduct.productname,
                                          price: procduct.price.toString(),
                                          descrption: procduct.description),
                                    ));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(9),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                        snapshot.data![index]
                                                            .image))),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Text(
                                              snapshot.data![index].productname,
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
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Row(
                                          children: [
                                            Text(
                                              'Rs',
                                              style: TextStyle(
                                                color: Colors.redAccent,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 2,
                                            ),
                                            Text(
                                              snapshot.data![index].price
                                                  .toString(),
                                              style: TextStyle(
                                                color: Colors.redAccent,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 2,
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
                )
              ]),
        ),
        drawer: drawer());
  }
}
