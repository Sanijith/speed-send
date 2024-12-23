import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/Admin/my_requests.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'home_page.dart';

class Add_Item extends StatefulWidget {
  const Add_Item({super.key});

  @override
  State<Add_Item> createState() => _Add_ItemState();
}

class _Add_ItemState extends State<Add_Item> {

  final formKey = GlobalKey<FormState>();
  var productname = TextEditingController();
  var price = TextEditingController();

  Future<dynamic> ItemsList() async {
    await FirebaseFirestore.instance.collection("Items").add({
      "Product Name": productname.text,
      "Price": price.text,
    });
    print('done');
    setState(() {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Form(
        key: formKey,
        child: Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => UserHome(),));
                },
                icon: const Icon(Icons.home_outlined),
                color: Colors.lightGreenAccent,
              ),
            ],
            backgroundColor: Colors.indigo,
            automaticallyImplyLeading: false,
            title: const Text('SPEEDY SEND'),
          ),
          body: Container(
            height: MediaQuery.of(context).size.height * 1,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/bg.jpg'), fit: BoxFit.fill)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                spacing: 20,
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
                  Text(
                    "SPEEDY SEND",
                    style: GoogleFonts.aclonica(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.white),
                  ),
                  TextFormField(
                    controller: productname,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Empty Product!";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.blueGrey.shade100,
                      border: OutlineInputBorder(),
                      hintText: "Product Name",
                    ),
                  ),
                  TextFormField(
                    controller: price,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Empty Price!";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        fillColor: Colors.blueGrey.shade100,
                        filled: true,
                        border: OutlineInputBorder(),
                        hintText: "Price"),
                  ),
                  InkWell(
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        ItemsList();
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
                              child: Text(
                            'ADD ITEM',
                            style: GoogleFonts.ubuntu(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.white),
                          )),
                        )),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
