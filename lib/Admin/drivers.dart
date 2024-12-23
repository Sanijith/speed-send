import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Drivers extends StatefulWidget {
  const Drivers({super.key});

  @override
  State<Drivers> createState() => _DriversState();
}

class _DriversState extends State<Drivers> {
  String? selectedDriver;  // To store the selected driver ID
  List<Map<String, dynamic>> drivers = [];  // To store drivers from Firebase

  @override
  void initState() {
    super.initState();
    _fetchDrivers();  // Fetch drivers when the widget is initialized
  }

  // Fetch drivers from Firestore
  Future<void> _fetchDrivers() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Driver register').get();

      setState(() {
        drivers = querySnapshot.docs.map((doc) {
          return {
            'id': doc.id,
            'name': doc['name'],  // Assuming you have a 'name' field in Firestore
            'phone': doc['phone'], // Assuming you have a 'phone' field in Firestore
          };
        }).toList();
      });
    } catch (e) {
      print('Error fetching drivers: $e');
    }
  }

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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: DropdownButton<String>(
                isExpanded: true,
                value: selectedDriver,
                hint: const Text('Select Driver'),
                items: drivers.map((driver) {
                  return DropdownMenuItem<String>(
                    value: driver['id'],
                    child: Text(driver['name']),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedDriver = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 20),
            // Display the selected driver's details
            if (selectedDriver != null)
              FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance
                    .collection('Driver register')
                    .doc(selectedDriver)
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  if (snapshot.hasError) {
                    return const Text('Error fetching details');
                  }
                  if (!snapshot.hasData || !snapshot.data!.exists) {
                    return const Text('Driver not found');
                  }

                  var driverData = snapshot.data!;
                  return Card(
                    child: ListTile(
                      leading: const CircleAvatar(radius: 20),
                      title: Text(driverData['name']),
                      subtitle: Text(driverData['phone']),
                      trailing: const Icon(Icons.phone_outlined),
                    ),
                  );
                },
              ),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: const CircleAvatar(radius: 20),
                      title: Text("Driver $index"),
                      trailing: const Icon(Icons.phone_outlined),
                      subtitle: Text("Phone Number $index"),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
