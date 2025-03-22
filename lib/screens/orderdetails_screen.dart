import 'dart:developer';
import 'package:date_format/date_format.dart';
import 'package:ecommerce_workshop/class_shared.dart';
import 'package:ecommerce_workshop/webservice/webservice.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class orderDetailsPage extends StatefulWidget {
  const orderDetailsPage({super.key});

  @override
  State<orderDetailsPage> createState() => _orderDetailsPageState();
}

class _orderDetailsPageState extends State<orderDetailsPage> {
  @override
  void initState() {
    _loadUsername();
    super.initState();
  }

  String? username;
  Future<void> _loadUsername() async {
    username = await Store.getUsername();
    log('username== ' + username.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffE8E8E8),
        appBar: AppBar(
          title: Text(
            'Order Details',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back_ios_new)),
          backgroundColor: Color(0xffE8E8E8),
          elevation: 0,
        ),
        body: FutureBuilder(
          future: Webservice().fetchOrderDetails(username.toString()),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: Card(
                      elevation: 0,
                      color: Color.fromARGB(15, 74, 20, 140),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          side: BorderSide.none),
                      child: ExpansionTile(
                        trailing: Icon(Icons.arrow_drop_down),
                        textColor: Colors.black,
                        collapsedTextColor: Colors.black,
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "12-03-2023",
                              // DateFormat.yMMMEd().format(snapshot.data[index].date),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              snapshot.data![index].paymentmethod,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.green.shade900,
                                  fontWeight: FontWeight.w300),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              snapshot.data![index].totalamount + '/-',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.red.shade900,
                                  fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                        children: [
                          ListView.separated(
                            shrinkWrap: true,
                            padding: const EdgeInsets.only(top: 25),
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data![index].products.length,
                            itemBuilder: (context, index) {
                              return Card(
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(23)),
                                  child: SizedBox(
                                    height: 100,
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20),
                                          child: Container(
                                            height: 80,
                                            width: 100,
                                            decoration: BoxDecoration(
                                                color: Colors.transparent,
                                                borderRadius:
                                                    BorderRadius.circular(23),
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        "http://bootcamp.cyralearnings.com/products/" +
                                                            snapshot
                                                                .data![index]
                                                                .products[index]
                                                                .image),
                                                    fit: BoxFit.contain)),
                                          ),
                                        ),
                                        Flexible(
                                          child: Padding(
                                            padding: const EdgeInsets.all(6.0),
                                            child: Wrap(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    snapshot
                                                        .data![index]
                                                        .products[index]
                                                        .productname,
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors
                                                            .grey.shade700,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0,
                                                          right: 8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        snapshot
                                                            .data![index]
                                                            .products[index]
                                                            .price
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors
                                                                .redAccent),
                                                      ),
                                                      Text(
                                                        snapshot
                                                                .data![index]
                                                                .products[index]
                                                                .quantity +
                                                            ' X',
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.green
                                                                .shade900),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ));
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 10,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
