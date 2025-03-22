import 'dart:convert';
import 'dart:developer';
import 'package:ecommerce_workshop/register_page.dart';
import 'package:http/http.dart' as http;
import 'package:ecommerce_workshop/class_shared.dart';
import 'package:ecommerce_workshop/screens/home_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class loginPage extends StatefulWidget {
  loginPage({super.key});

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  GlobalKey<FormState> _formkey = GlobalKey();

  TextEditingController _usernameController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    _loadCounter().then((value) {
      if (isLoggedIn == true) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => 
        homePage(),));
      }
    });
    super.initState();
  }

  late final bool? isLoggedIn;
  late final String? username;

  Future<void> _loadCounter() async {
    isLoggedIn = await Store.getLoggedIn();
    username = await Store.getUsername();
    log(isLoggedIn.toString());
  }

  login(String username, password) async {
    print('webservice');
    
    var result;
    final Map<String, dynamic> loginData = {
      'username': username,
      'password': password,
    };
    final response = await http.post(
      Uri.parse('http://bootcamp.cyralearnings.com/login.php'),
      body: loginData,
    );
    
    if (response.statusCode == 200) {
      if (response.body.contains('success')) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Login Successfull!'),
          backgroundColor: Color.fromARGB(255, 175, 5, 152),));
        log('login successfully completed');
        Store.setLoggedIn(true);
        Store.setUsername(_usernameController.text);
        Navigator.push(context, MaterialPageRoute(builder: (context) => 
        homePage(),));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Login Failed!'),
          backgroundColor: Color.fromARGB(255, 175, 5, 152),));
        log('login failed');
      }
    } else {
      result= {log(json.decode(response.body)['error'].toString())};
    }
   return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formkey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome Back',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'Login with your username and password',
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _usernameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the username';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(9),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(9),
                      ),
                      labelText: 'Username',
                      // labelStyle: TextStyle(color: Colors.purple),
                      fillColor: Color(0xFFE8E8E8),
                      filled: true,
                    ),
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _passwordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the password';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(9),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(9),
                      ),
                      labelText: 'Password',
                      //  labelStyle: TextStyle(color: Colors.grey),
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
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width / 2,
                  child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Color(0xFFFF151E3D),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                              side: BorderSide.none)),
                      onPressed: () {
                        if (_formkey.currentState!.validate()) {
                        
                         login(_usernameController.text, _passwordController.text);
                      
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => 
                        // homePage(),));
                        }
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.white),
                      )),
                ),
                SizedBox(
                  height: 10,
                ),
                RichText(
                  text: TextSpan(
                    text: "Don't have an account? ",
                    children: [
                      TextSpan(
                        text: 'Sign Up',
                        style: TextStyle(color: Colors.blueAccent),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => 
                            registerPage(),));
                          },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
