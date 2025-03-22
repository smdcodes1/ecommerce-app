import 'dart:convert';
import 'dart:developer';


import 'package:ecommerce_workshop/model/categorymodel.dart';
import 'package:ecommerce_workshop/model/ordermodel.dart';
import 'package:ecommerce_workshop/model/productmodel.dart';
import 'package:ecommerce_workshop/model/usermodel.dart';
import 'package:http/http.dart' as http;


class Webservice {
  
 Future<List<CategoryModel>?> fetchCategory() async {
  try {
    final response= await http.get(
      Uri.parse('http://bootcamp.cyralearnings.com/getcategories.php'),
    );
    if (response.statusCode == 200) {
      final parsed= json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed
             .map<CategoryModel>((json) => CategoryModel.fromJson(json))
             .toList();
    } else {
      throw Exception('failed to load category');
    }
  } catch (e) {
    log(e.toString());
  }
 }

  Future<List<ProductModel>> fetchProduct() async {
    final response = await http
        .get(Uri.parse('http://bootcamp.cyralearnings.com/view_offerproducts.php'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed
          .map<ProductModel>((json) => ProductModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load');
    }
  }
  Future<List<ProductModel>> fetchCatProducts(int catid) async {
    final response= await http
    .post(Uri.parse('http://bootcamp.cyralearnings.com/get_category_products.php'),
    body: {'catid': catid.toString()});

    if (response.statusCode == 200) {
      final parsed= json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed
             .map<ProductModel>((json) => ProductModel.fromJson(json))
             .toList();
    } else {
      throw Exception('failed to load');
    }
  }
  Future<UserModel> fetchUser(String username) async {
   final response= await http.post(Uri.parse('http://bootcamp.cyralearnings.com/get_user.php'),
   body: {'username': username}
   );
   if (response.statusCode == 200) {
     return UserModel.fromJson(jsonDecode(response.body));
   } else {
    throw Exception('falied to load the user');
   }
  }

  Future<List<OrderModel>?> fetchOrderDetails(String username) async {
    try {
    final response= await http.post(Uri.parse('http://bootcamp.cyralearnings.com/get_orderdetails.php'),
    body: {'username': username.toString()}
    );

    if (response.statusCode == 200) {
      final parsed= json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed
             .map<OrderModel>((json) => OrderModel.fromJson(json))
             .toList();
    } else {
      throw Exception('failed to load order details');
    }
    } catch(e) {
      log(e.toString());
    }
  } 

}