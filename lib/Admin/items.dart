import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/Admin/add_items.dart';
import 'package:flutter/material.dart';

class Items extends StatefulWidget {
  const Items({super.key});

  @override
  State<Items> createState() => _ItemsState();
}

class _ItemsState extends State<Items> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.home_outlined),
            color: Colors.lightGreenAccent,
          )
        ],
        backgroundColor: Colors.indigo,
        automaticallyImplyLeading: false,
        title: Text('SPEEDY SEND'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * 1,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/bg.jpg'), fit: BoxFit.fill)),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                decoration: BoxDecoration(
                    image:
                        DecorationImage(image: AssetImage('images/item.jpg'))),
                height: 100,
                width: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Items ",
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                child: FutureBuilder(
                    future:
                        FirebaseFirestore.instance.collection("Items").get(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Center(
                          child: Text("Error:${snapshot.error}"),
                        );
                      }
                      final item = snapshot.data?.docs ?? [];
                      return ListView.builder(
                        itemCount: item.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              leading: CircleAvatar(
                                radius: 20,
                              ),
                              title: Text("Item: ${item[index]["Product Name"]}"),
                              subtitle: Text("Price: RS ${item[index]["Price"]} /-"),
                            ),
                          );
                        },
                      );
                    }))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Add_Item(),));
        },
        child: Icon(Icons.add_circle_outline),
      ),
    );
  }
}
