import 'dart:convert';
import 'dart:developer';

import 'package:ecommerce_workshop/class_shared.dart';
import 'package:ecommerce_workshop/provider/cart_provider.dart';
import 'package:ecommerce_workshop/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:http/http.dart' as http;

class paymentPage extends StatefulWidget {
  paymentPage({super.key,
             required this.cart,
             required this.amount,
             required this.paymentmethod,
             required this.date,
             required this.name,
             required this.address,
             required this.phone});

   List<CartProduct> cart;
    String amount;
    String paymentmethod;
    String date;
    String name;
    String address;
    String phone;

  @override
  State<paymentPage> createState() => _paymentPageState();
}

class _paymentPageState extends State<paymentPage> {
  
  Razorpay? razorpay;
  TextEditingController textEditingController= new TextEditingController();


  @override
  void initState() {
    _loadUsername();
    razorpay= Razorpay();
    razorpay!.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorpay!.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorpay!.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    flutterpayment("abcd",10);
    super.initState();
  }
  @override
  void dispose() {
    razorpay!.clear();
    super.dispose();
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
    try { String jsondata= jsonEncode(cart);
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
    } catch(e) {
      log(e.toString());
    }
  }

  void flutterpayment(String orderId, int t) {
   var options= {
    "key": "rzp_test_IGhdfrMPYIDCPR",
    "amount": t * 1,
    "name": "afi",
    "currency": "INR",
    "description": "maligai",
    "external": {
      "wallets": ["paytm"]
    },
    "retry": {"enabled": true, "max_count": 1},
    "send_sms_hash": true,
    "prefill": {"contact": "9497235611", "email": "ace567871@gmail.com"},
   };
   try {
     razorpay!.open(options);
   } catch (e) {
     debugPrint('Error: e');
   }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    response.orderId;

    sucessmethd(response.paymentId.toString());
  }
  void _handlePaymentError(PaymentFailureResponse response) {
    log('error== '+response.message.toString());
  }
  void _handleExternalWallet(ExternalWalletResponse response) {
    log('wallet==');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(),
    );
  }
  void sucessmethd(String paymentId) {
    log('success== '+ paymentId.toString());
    orderPlace(widget.cart,
                 widget.amount.toString(),
                  widget.paymentmethod,
                   widget.date,
                    widget.name,
                     widget.address,
                      widget.phone);
  }
}