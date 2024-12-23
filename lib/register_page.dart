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
    await FirebaseFirestore.instance.collection("Driver Register").add({
      "Username": name.text,
      "Password": password.text,
      "Email": email.text,
      "Phone Number": phone.text,
      "Path":"https://media.istockphoto.com/id/1300845620/vector/user-icon-flat-isolated-on-white-background-user-symbol-vector-illustration.jpg?s=612x612&w=0&k=20&c=yBeyba0hUkh14_jgv1OKqIH0CCSWU_4ckRkAoy2p73o=",
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
          appBar: AppBar(
            backgroundColor: Colors. indigo,
          ),
          body: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height * 1,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage('images/bg.jpg'),fit: BoxFit.fill)
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  spacing: 25,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('images/logo.jpg'),
                    ),
                    Text('SPEEDY SEND',
                        style: GoogleFonts.aclonica(fontSize: 30, color: Colors.red)),
                    TextFormField(
                      controller: name,
                      validator: (value){
                        if(value!.isEmpty){
                          return "Empty Name!";
                        }
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.blueGrey.shade100,
                        border: OutlineInputBorder(
                        ),
                        hintText: "Username",
                      ),
                    ),
                    TextFormField(
                      controller: password,
                      validator: (value){
                        if(value!.isEmpty){
                          return "Empty Password!";
                        }
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.blueGrey.shade100,
                        border: OutlineInputBorder(),
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
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.blueGrey.shade100,
                        border: OutlineInputBorder(),
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
                        return null;
                      },
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.blueGrey.shade100,
                          border: OutlineInputBorder(), hintText: "Phone Number"),
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
                                  color: Colors.greenAccent),
                              child: Center(
                                child: Text('Register'),
                              )),
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already Exists "),
                        TextButton(onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Login_Page(),));
                        }, child: Text("Login"))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
