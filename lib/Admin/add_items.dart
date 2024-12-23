import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/Admin/my_requests.dart';
import 'package:flutter/material.dart';

class Add_Item extends StatefulWidget {
  const Add_Item({super.key});

  @override
  State<Add_Item> createState() => _Add_ItemState();
}

class _Add_ItemState extends State<Add_Item> {

  var productname=TextEditingController();
  var price=TextEditingController();


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
      child: Scaffold(
        appBar: AppBar(),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.greenAccent.shade200,
              ),
              Text("SPEEDY SEND"),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Product Name",
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                    hintText: "Price"
                ),
              ),
              InkWell(
                  onTap: () {

                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                        height: 53,
                        width: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.redAccent),
                        child: Center(
                          child: Text('ADD ITEM'),
                        )),
                  )),
              InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => My_Requests(),));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                        height: 53,
                        width: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.redAccent),
                        child: Center(
                          child: Text('MY REQUESTS'),
                        )),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
