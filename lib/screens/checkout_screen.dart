import 'dart:convert';
import 'dart:developer';

import 'package:ecommerce_workshop/class_shared.dart';
import 'package:ecommerce_workshop/model/usermodel.dart';
import 'package:ecommerce_workshop/provider/cart_provider.dart';
import 'package:ecommerce_workshop/razorpay.dart';
import 'package:ecommerce_workshop/screens/home_screen.dart';
import 'package:ecommerce_workshop/webservice/webservice.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class checkoutPage extends StatefulWidget {
  checkoutPage({super.key, required this.cart});
  List<CartProduct> cart;

  @override
  State<checkoutPage> createState() => _checkoutPageState();
}

class _checkoutPageState extends State<checkoutPage> {
  String radioButtonItem = 'Cash on Delivery';

  int id = 1;

  String? name, phone, address;
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
  orderPlace(
    List<CartProduct> cart,
    String amount,
    String paymentmethod,
    String date,
    String name,
    String address,
    String phone,
  ) async {
    String jsondata= jsonEncode(cart);
    log('jsondata== ${jsondata}');

    final vm= Provider.of<Cart>(context, listen: false);
    final response= await http.post(Uri.parse("http://bootcamp.cyralearnings.com/order.php"),
    body: {
      'username': username,
      'amount': amount,
      'paymentmethod': paymentmethod,
      'date': date,
      'quantity': vm.count.toString(),
      'cart': jsondata,
      'name': name,
      'address': address,
      'phone': phone,
    }
    );
    if (response.statusCode == 200) {
      log(response.body);
      if (response.body.contains("Success")) {
        vm.clearCart();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          duration: Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
          padding: EdgeInsets.all(15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            side: BorderSide.none
          ),
          content: Text('YOUR ORDER SUCCESSFULLY COMPLETED',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18,
          color: Colors.white),)));
          Navigator.push(context, MaterialPageRoute(builder: (context) => 
          homePage(),));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text(
          'Checkout',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios_new)),
        backgroundColor: Colors.grey.shade100,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<UserModel>(
              future: Webservice().fetchUser(username.toString()),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  name = snapshot.data!.name;
                  phone = snapshot.data!.phone;
                  address = snapshot.data!.address;
                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide.none),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'Name: ',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w600),
                              ),
                              Text(name.toString())
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                'Phone: ',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w600),
                              ),
                              Text(phone.toString())
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                'Address: ',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w600),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 1.5,
                                child: Text(
                                  address.toString(),
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
            SizedBox(
              height: 10,
            ),
            RadioListTile(
              value: 1,
              groupValue: id,
              onChanged: (val) {
                setState(() {
                  radioButtonItem = 'Cash on Delivery';
                  id = val!;
                });
              },
              title: new Text(
                'Cash on Delivery',
                style: TextStyle(fontSize: 15),
              ),
              subtitle: new Text(
                'Pay Cash at home',
                style: TextStyle(fontSize: 15),
              ),
            ),
            RadioListTile(
              value: 2,
              groupValue: id,
              onChanged: (val) {
                setState(() {
                  radioButtonItem = 'Pay Now';
                  id = val!;
                });
              },
              title: new Text(
                'Pay Now',
                style: TextStyle(fontSize: 15),
              ),
              subtitle: new Text(
                'Online Payment',
                style: TextStyle(fontSize: 15),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: InkWell(
        onTap: () {
          String dateTime = DateTime.now().toString();
          final vm= Provider.of<Cart>(context, listen: false);
        if (radioButtonItem == 'Pay Now') {
          Navigator.push(context, MaterialPageRoute(builder: (context) => 
          paymentPage(cart: widget.cart,
                       amount: vm.totalPrice.toString(),
                        paymentmethod: radioButtonItem.toString(),
                         date: dateTime.toString(),
                          name: name.toString(),
                           address: address.toString(),
                            phone: phone.toString()),));
        } else if (radioButtonItem == 'Cash on Delivery') {
          orderPlace(widget.cart,
                      vm.totalPrice.toString(),
                       radioButtonItem.toString(),
                        dateTime.toString(),
                         name!,
                          address!,
                           phone!);
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
                  'Checkout',
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
