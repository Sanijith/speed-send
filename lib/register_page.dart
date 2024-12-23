import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/login_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Register_Page extends StatefulWidget {
  const Register_Page({super.key});

  @override
  State<Register_Page> createState() => _Register_PageState();
}

class _Register_PageState extends State<Register_Page> {
  final formKey=GlobalKey<FormState>();
  var name = TextEditingController();
  var password = TextEditingController();
  var email = TextEditingController();
  var phone = TextEditingController();

  Future<dynamic> reg() async {
    await FirebaseFirestore.instance.collection("Driver").add({
      "Username": name.text,
      "Password": password.text,
      "Email": email.text,
      "Phone Number": phone.text,
     });
    print("done");
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login_Page()));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Form(
        key: formKey,
        child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              // height: MediaQuery.of(context).size.height * 1,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/bg.jpg'),
                      fit: BoxFit.fill)),
              padding: const EdgeInsets.all(50),
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
                  const Text(
                    'Register',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  TextFormField(
                    controller: name,
                    validator: (value){
                      if(value!.isEmpty){
                        return "Empty Name!";
                      }
                    },
                    keyboardType: TextInputType.name,
                    decoration:  InputDecoration(
                      filled: true,
                      fillColor: Colors.blueGrey.shade100,
                      border: OutlineInputBorder(),
                      icon: Icon(Icons.person),
                      hintText: "Username",
                    ),
                  ),
                  TextFormField(
                    obscureText: true,
                    controller: password,
                    validator: (value){
                      if(value!.isEmpty){
                        return "Empty Password!";
                      }
                    },
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.blueGrey.shade100,
                      border: OutlineInputBorder(
                      ),
                      icon: const Icon(Icons.lock),
                      hintText: "Password",
                    ),
                  ),
                  TextFormField(
                    controller: email,
                    validator: (value){
                      if(value!.isEmpty){
                        return "Empty Email!";
                      }
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.blueGrey.shade100,
                      border: OutlineInputBorder(

                      ),
                      icon: const Icon(Icons.email),
                      hintText: "Email",
                    ),
                  ),
                  TextFormField(
                    controller: phone,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Empty Phone Number!";
                      } else if (value.length != 10 || !RegExp(r'^[0-9]+$').hasMatch(value)) {
                        return "Invalid Phone Number";
                      }
                      return null; // Valid input
                    },
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.blueGrey.shade100,
                      border: OutlineInputBorder(
                      ),
                      icon: const Icon(Icons.phone),
                      hintText: "Phone Number",
                    ),
                  ),
                  InkWell(
                      onTap: () {
                        if(formKey.currentState!.validate()){
                          reg();
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Container(
                            height: 53,
                            width: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.green),
                            child: Center(
                              child: Text('Register',
                                  style: GoogleFonts.ubuntu(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                            )),
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account?'),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Login_Page()));
                          },
                          child: const Text('Login')),
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
