import 'dart:convert';
import 'dart:developer';
import 'package:ecommerce_workshop/login_page.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class registerPage extends StatelessWidget {
  registerPage({super.key,});

  Future<void> registration(BuildContext context,String name, phone, address, username, password) async {
    print('webservice');
    
    var result;
    final Map<String, dynamic> Data= {
      'name': name,
      'phone': phone,
      'address': address,
      'username': username,
      'password': password,
    };
    final response= await http.post(
      Uri.parse('http://bootcamp.cyralearnings.com/registration.php'),
      body: Data,
    );
    
    if (response.statusCode == 200) {
      if (response.body.contains('success')) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Registration Successfull!'),
          backgroundColor: Color.fromARGB(255, 175, 5, 152),));
        log('registration successfull');
        Navigator.push(context, MaterialPageRoute(builder:(context) => 
        loginPage(),));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Registration Failed!'),
          backgroundColor: Color.fromARGB(255, 175, 5, 152),));
        log('registration failed');
      }
    } else {
      result= {log(json.decode(response.body)['error'].toString())};
    }
   return result;
  }

  GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerPhone = TextEditingController();
  TextEditingController _controllerAddress = TextEditingController();
  TextEditingController _controllerUsername = TextEditingController();
  TextEditingController _controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  'Register Account',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                ),
                Text(
                  'Complete your details',
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the name';
                      }
                      return null;
                    },
                    controller: _controllerName,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(9),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(9),
                      ),
                      hintText: 'Enter your Name',
                      // hintStyle: TextStyle(color: Colors.grey),
                      fillColor: Color(0xFFE8E8E8),
                      filled: true,
                    ),
                    style: TextStyle(fontSize: 15),
                    maxLength: 20,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the mobile number';
                      }
                      return null;
                    },
                    controller: _controllerPhone,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(9),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(9),
                      ),
                      hintText: 'Enter your Mobile',
                      // hintStyle: TextStyle(color: Colors.grey),
                      fillColor: Color(0xFFE8E8E8),
                      filled: true,
                    ),
                    style: TextStyle(fontSize: 15),
                    maxLength: 20,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the address';
                      }
                      return null;
                    },
                    controller: _controllerAddress,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(9),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(9),
                      ),
                      hintText: 'Address',
                      fillColor: Color(0xFFE8E8E8),
                      filled: true,
                    ),
                    style: TextStyle(fontSize: 15),
                    maxLines: 4,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the username';
                      }
                      return null;
                    },
                    controller: _controllerUsername,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(9),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(9),
                      ),
                      hintText: 'Enter your Username',
                      fillColor: Color(0xFFE8E8E8),
                      filled: true,
                    ),
                    style: TextStyle(fontSize: 15),
                    maxLength: 20,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the password';
                      } else if (value.length < 8) {
                        return 'The Password must not be below 8 letters';
                      }
                      return null;
                    },
                    controller: _controllerPassword,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(9),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(9),
                      ),
                      hintText: 'Enter your Password',
                      fillColor: Color(0xFFE8E8E8),
                      filled: true,
                    ),
                    style: TextStyle(fontSize: 15),
                    obscureText: true,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                        
                          registration(context,
                           _controllerName.text,
                            _controllerPhone.text,
                             _controllerAddress.text,
                              _controllerUsername.text,
                               _controllerPassword.text);
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => 
                        // loginPage(),));
                        }
                      },
                      child: Text(
                        'Register',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: TextButton.styleFrom(
                          backgroundColor: Color(0xFFFF151E3D),
                          shape: RoundedRectangleBorder(
                            side: BorderSide.none,
                            borderRadius: BorderRadius.circular(6),
                          )),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                RichText(
                  text: TextSpan(
                    text: "Already have an account? ",
                    children: [
                      TextSpan(
                        text: 'Sign in',
                        style: TextStyle(color: Colors.blueAccent),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => 
                            loginPage(),));
                          },
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
