import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Drivers extends StatefulWidget {
  const Drivers({super.key});

  @override
  State<Drivers> createState() => _DriversState();
}

class _DriversState extends State<Drivers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.home_outlined),
            color: Colors.lightGreenAccent,
          ),
        ],
        backgroundColor: Colors.indigo,
        automaticallyImplyLeading: false,
        title: const Text('SPEEDY SEND'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/bg.jpg'),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/drivers.jpg'),
                  ),
                ),
                height: 100,
                width: 200,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Drivers",
                    ),
                  ],
                ),
              ),
            ),
            // Dropdown to select a driver
            Expanded(
                child: FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection("Driver")
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
                      final driver = snapshot.data?.docs ?? [];
                      return ListView.builder(
                        itemCount: driver.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              leading: const CircleAvatar(radius: 20),
                              title: Text(driver[index]["Username"]),
                              trailing: const Icon(Icons.phone_outlined),
                              subtitle: Text("Phone Number: ${driver[index]["Phone Number"]}"),
                            ),
                          );
                        },
                      );
                    })),
          ],
        ),
      ),
    );
  }
}
