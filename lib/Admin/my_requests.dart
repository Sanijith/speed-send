import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class My_Requests extends StatefulWidget {
  const My_Requests({super.key});

  @override
  State<My_Requests> createState() => _My_RequestsState();
}

class _My_RequestsState extends State<My_Requests> {
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
                  color: Colors.blueGrey,
                ),
                height: 70,
                width: 150,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "My Requests",
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                child: FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection("Requests")
                        .get(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Center(
                          child: Text("Error:${snapshot.error}"),
                        );
                      }
                      final request = snapshot.data?.docs ?? [];
                      return ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Card(
                              child: ListTile(
                                leading: CircleAvatar(
                                  radius: 20,
                                ),
                                title: Text("Request $index"),
                                trailing: Icon(Icons.check_circle_outline),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(request[index]["Driver"]),
                                    Text("From: ${request[index]["From"]}"),
                                    Text("To: ${request[index]["To"]}"),
                                    Text("Item $index"),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }))
          ],
        ),
      ),
    );
  }
}
