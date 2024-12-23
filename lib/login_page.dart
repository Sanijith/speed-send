import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/Admin/home_page.dart';
import 'package:delivery_app/Driver/bottom_nav.dart';
import 'package:delivery_app/register_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Driver/driv_home_page.dart';

class Login_Page extends StatefulWidget {
  const Login_Page({super.key});

  @override
  State<Login_Page> createState() => _Login_PageState();
}

class _Login_PageState extends State<Login_Page> {

  final formKey = GlobalKey<FormState>();
  var email = TextEditingController();
  var password = TextEditingController();
  String id = '';
  String name = '';
  String phoneNumber = '';


  void login() async {
    // Check for admin credentials
    if (email.text == 'admin@gmail.com' && password.text == '123') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => UserHome(),
        ),
      );
    } else {

      final driver = await FirebaseFirestore.instance
          .collection('Driver')
          .where('Email', isEqualTo: email.text)
          .where('Password', isEqualTo: password.text)
          .get();
      if (driver.docs.isNotEmpty) {

        id = driver.docs[0].id;
        name = driver.docs[0]["Username"];
        phoneNumber = driver.docs[0]["Phone Number"];

        SharedPreferences data = await SharedPreferences.getInstance();
        data.setString('id', id);
        data.setString('name', name);
        data.setString('Phone', phoneNumber);

        setState(() {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => CurvedNavigationBar1(),
            ),
          );
        });

      } else {

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            "Username and password error",
            style: TextStyle(color: Colors.red),
          ),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Form(
        key: formKey,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.indigo,
          ),
          body: Container(
            height: MediaQuery.of(context).size.height * 1,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/bg.jpg'), fit: BoxFit.fill,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                spacing: 25,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.red,
                    child: CircleAvatar(
                      backgroundImage: AssetImage('images/logo.jpg'),
                      radius: 45,
                    ),
                  ),
                  Text('SPEEDY SEND',
                      style: GoogleFonts.aclonica(fontSize: 30, color: Colors.red)),
                  TextFormField(
                    controller: email,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Empty Email!";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.blueGrey.shade100,
                      border: OutlineInputBorder(),
                      hintText: "Email",
                    ),
                  ),
                  TextFormField(
                    controller: password,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Empty Password!";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.blueGrey.shade100,
                      border: OutlineInputBorder(),
                      hintText: "Password",
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        login();
                      }
                    },
                    child: Container(
                      height: 53,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.greenAccent,
                      ),
                      child: Center(
                        child: Text('Login'),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("For New User "),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Register_Page(),
                            ),
                          );
                        },
                        child: Text("Sign Up"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
