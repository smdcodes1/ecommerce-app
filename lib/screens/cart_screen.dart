import 'package:ecommerce_workshop/constants.dart';

import 'package:ecommerce_workshop/provider/cart_provider.dart';
import 'package:ecommerce_workshop/screens/checkout_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class cartPage extends StatelessWidget {
 cartPage({super.key});

 List<CartProduct> cartlist= [];
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE8E8E8),
      appBar: AppBar(
        title: Text('Cart',
        style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 22,
        color: Colors.black),),
        centerTitle: true,
        elevation: 0,
        toolbarHeight: 60,
        backgroundColor: Color(0xffE8E8E8),
        leading: IconButton(onPressed: () {
          Navigator.of(context).pop();
        },
         icon: Icon(Icons.arrow_back_ios_new)),
         actions: [
          context.watch<Cart>().getItems.isEmpty
          ? SizedBox()
          : IconButton(onPressed: () {
            context.read<Cart>().clearCart();
          },
           icon: Icon(Icons.delete,
           color: Color.fromARGB(255, 56, 55, 55),)),
         ],
      ),
    body: context.watch<Cart>().getItems.isEmpty
          ? Center(child: Text('Empty Cart'),)
          : Consumer<Cart>(builder: (context, cart, child) {
      cartlist= cart.getItems;
      return ListView.builder(
      itemCount: cart.count,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            color: Colors.white,
            elevation: 9,
            child: ListTile(
              leading: Container(
                height: 80,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(23),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(23),
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                     image: cartlist[index].imagesUrl,
                     fit: BoxFit.cover,),
                ),
              ),
              
              title: Text(cartlist[index].name,
              style: TextStyle(fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey),),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(cartlist[index].price.toString(),
                  style: TextStyle(fontSize: 14,
                  color: Colors.redAccent,
                  fontWeight: FontWeight.bold),),
                Container(
                  height: 36,
                  
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(23),
                  ),
                
                  
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(onPressed: () {
                      cart.getItems[index].qty == 1
                      ? cart.removeItem(cart.getItems[index])
                      : cart.reduceByOne(cart.getItems[index]);
                    }
                    , icon: cart.getItems[index].qty == 1
                            ? Icon(Icons.delete,
                                   size: 20,)
                            : Icon(Icons.remove_outlined,
                                  size: 20,)),
                    
                    Text(cart.getItems[index].qty.toString(),
                    style: TextStyle(color: Colors.black),),
                    
                    IconButton(onPressed: () {
                      cart.increment(cart.getItems[index]);
                    },
                     icon: Icon(Icons.add_outlined,
                               size: 20,))
                  ],
                ),
                )
                ],
              ),
                  
            ),
          ),
        );
      },);
    },),
    bottomSheet: Container(
      height: 60,
      width: MediaQuery.of(context).size.width,
     color: Colors.white,
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
             Row(
              children: [
                 Text('Total : ' + context.read<Cart>().totalPrice.toString(),
                 style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.redAccent
                 ),),
                
              ],
             ),
                Flexible(
                  child: InkWell(
                    onTap: () {
                      context
                      .read<Cart>()
                      .getItems.isEmpty
                      ? ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        duration: Duration(seconds: 3),
                        behavior: SnackBarBehavior.floating,
                        padding: EdgeInsets.all(15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(9)),
                          side: BorderSide.none
                        ),
                        content: Text('Cart is empty',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18,
                                          color: Colors.white),)
                                          ))
                        : Navigator.push(context, MaterialPageRoute(builder: (context) => 
                        checkoutPage(cart: cartlist),));
                    },
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width/ 2.2,
                      decoration: BoxDecoration(
                        color: Color(0xFFFF151E3D),
                        borderRadius: BorderRadius.circular(23),
                      ),
                      child: Center(
                        child: Text('Order Now',
                        style: TextStyle(color: Colors.white),),
                      ),
                    ),
                  )
                )
            ],
          ),
    ),
    ),
    );
  }
}