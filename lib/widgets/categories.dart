import 'package:flutter/material.dart';

class category extends StatelessWidget {
  category({super.key, required this.text});
  

  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: EdgeInsets.symmetric(horizontal: 16),
    decoration: BoxDecoration(shape: BoxShape.rectangle,
    color: Color.fromARGB(37, 5, 2, 39),
    borderRadius: BorderRadius.circular(9),),
    child: Center(child: Text(text,
    style: TextStyle(color: Color(0xFFFF151E3D),
    fontSize: 15,
    fontWeight: FontWeight.w600),)),
    );
  }
}