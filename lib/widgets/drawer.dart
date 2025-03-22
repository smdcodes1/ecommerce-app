import 'package:ecommerce_workshop/class_shared.dart';
import 'package:ecommerce_workshop/login_page.dart';
import 'package:ecommerce_workshop/provider/cart_provider.dart';
import 'package:ecommerce_workshop/screens/cart_screen.dart';
import 'package:ecommerce_workshop/screens/home_screen.dart';
import 'package:ecommerce_workshop/screens/orderdetails_screen.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';


class drawer extends StatelessWidget {
  const drawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 200,
                child: Center(
                  child: Text("E-COMMERCE",
                  style: TextStyle(color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,),),
                ),
              ),
              Divider(
                color: Colors.black45,
              ),
              SizedBox(height: 10,),
              ListTile(
                leading: Icon(
                  Icons.home_outlined,
            
                ),
                title: Text(
                  'Home',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    letterSpacing: 0,
                  ),
                ),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.pushNamed(context, '/home');
              },
              ),
              ListTile(
                leading: badges.Badge(
                  showBadge: context.read<Cart>().getItems.isEmpty ? false : true,
                  badgeStyle: badges.BadgeStyle(badgeColor: Colors.red),
                  badgeContent: Text(
                    context.watch<Cart>().getItems.length.toString(),
                    style: TextStyle(fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                  ),
                  child: const Icon(
                    Icons.shopping_cart_outlined,
                              
                  ),
                ),
                title: Text(
                  'Cart Page',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    letterSpacing: 0,
                  ),
                ),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.pushNamed(context, '/cart');
              },
              ),
               ListTile(
                leading: Icon(
                  Icons.list_alt_outlined,
            
                ),
                title: Text(
                  'Order Details',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    letterSpacing: 0,
                  ),
                ),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.pushNamed(context, '/order details');
              },
              ),
              Divider(color: Colors.black45,),
              ListTile(
                leading: Icon(
                  Icons.power_settings_new,
                  color: Colors.redAccent,
                ),
                title: Text(
                  'Logout',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    letterSpacing: 0,
                  ),
                ),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Store.setLoggedIn(false).then((value) => Store.clear());
                Navigator.push(context, MaterialPageRoute(builder: (context) => 
                loginPage(),));
              },
              )
            ],
          ),
        ),
      );
  }
}