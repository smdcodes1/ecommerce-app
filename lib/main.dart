
import 'package:ecommerce_workshop/login_page.dart';
import 'package:ecommerce_workshop/provider/cart_provider.dart';
import 'package:ecommerce_workshop/register_page.dart';
import 'package:ecommerce_workshop/screens/cart_screen.dart';
import 'package:ecommerce_workshop/screens/category_screen/category_products_page.dart';
import 'package:ecommerce_workshop/screens/checkout_screen.dart';
import 'package:ecommerce_workshop/screens/details_screen.dart';
import 'package:ecommerce_workshop/screens/home_screen.dart';
import 'package:ecommerce_workshop/screens/orderdetails_screen.dart';
import 'package:ecommerce_workshop/screens/splash_screen.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
   ChangeNotifierProvider(create: (_) => Cart(),)
  ],child: MyApp()
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Commerce',
      theme: ThemeData(
      
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/':(context) => splashScreen(),
        '/home':(context) => homePage(),
        '/cart':(context) => cartPage(),
        '/order details':(context) => orderDetailsPage(),
      },
    );
  }
}

