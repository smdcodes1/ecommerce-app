import 'dart:async';

import 'package:ecommerce_workshop/login_page.dart';
import 'package:ecommerce_workshop/screens/home_screen.dart';
import 'package:flutter/material.dart';

class splashScreen extends StatefulWidget {
  const splashScreen({super.key});

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 5), ()=> Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => 
    loginPage())) );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE8E8E8),
      body: Center(
        child: Image.asset('assets/images/e-commerce-removebg-preview.png',
             height: 280,),
      ),
    );
  }
}