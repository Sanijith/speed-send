import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'home_page.dart';

class Send_Request extends StatefulWidget {
  const Send_Request({super.key});

  @override
  State<Send_Request> createState() => _Send_RequestState();
}

class _Send_RequestState extends State<Send_Request> {
  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();

  String? selectedDriver;
  String? selectedDriverId; // Store selected driver's ID
  List<Map<String, String>> drivers =
      []; // Store drivers as a map with 'Username' and 'DriverId'
  List<String> items = []; // List to store items from Firebase
  List<String> selectedItems = []; // List to store selected items
  bool isLoading = true; // To show loading indicator while fetching data

  @override
  void initState() {
    super.initState();
    _fetchDrivers();
    _fetchItems();
  }

  // Fetch drivers from Firebase Firestore
  Future<void> _fetchDrivers() async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('Driver').get();

      List<Map<String, String>> driverList = [];
      for (var doc in snapshot.docs) {
        driverList.add({
          'Username': doc['Username'],
          'DriverId': doc.id, // Use the document ID as the Driver ID
        });
      }

      setState(() {
        drivers = driverList;
      });
    } catch (e) {
      print('Error fetching drivers: $e');
    }
  }

  // Fetch items from Firebase Firestore
  Future<void> _fetchItems() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('Items') // Assuming items collection is named "items"
          .get();

      List<String> itemList = [];
      for (var doc in snapshot.docs) {
        itemList.add(doc[
            'Product Name']); // Assuming each item document has a "name" field
      }

      setState(() {
        items = itemList;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching items: $e');
    }
  }

  // Function to save data to Firebase Firestore
  Future<void> _saveRequest() async {
    if (fromController.text.isEmpty ||
        toController.text.isEmpty ||
        selectedItems.isEmpty ||
        selectedDriver == null ||
        selectedDriverId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }

    try {
      await FirebaseFirestore.instance.collection('Requests').add({
        'From': fromController.text,
        'To': toController.text,
        'Items': selectedItems,
        'Driver': selectedDriver, // Store the driver's username
        'DriverId': selectedDriverId, // Store the driver's ID
        'Status': "0",
      });

      _showSuccessDialog();

      fromController.clear();
      toController.clear();
      setState(() {
        selectedDriver = null;
        selectedDriverId = null;
        selectedItems = [];
      });
    } catch (e) {
      print('Error saving request: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to send request")),
      );
    }
  }

  // Show success dialog after saving request
  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 50,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Request Sent Successfully!',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                  image: AssetImage('images/bg.jpg'),
                  fit: BoxFit.fill,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  spacing: 30,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blueGrey,
                        ),
                        height: 100,
                        width: 200,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Text("SEND \n REQUESTS  ",
                                  style: GoogleFonts.ubuntu(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30,
                                      color: Colors.white)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: fromController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Empty Place!";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.blueGrey.shade100,
                        border: OutlineInputBorder(),
                        hintText: "FROM",
                      ),
                    ),
                    TextFormField(
                      controller: toController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Empty Place!";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.blueGrey.shade100,
                        border: OutlineInputBorder(),
                        hintText: "TO",
                      ),
                    ),
                    // Multi-Select Items Dropdown
                    isLoading
                        ? CircularProgressIndicator()
                        : Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: Colors.blueGrey.shade100,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: Colors.blueGrey.shade300,
                                width: 1.0,
                              ),
                            ),
                            child: DropdownButton<String>(
                              value: null,
                              // No value to pre-select
                              hint: Text("Select Items"),
                              onChanged: (newValue) {
                                setState(() {
                                  if (newValue != null &&
                                      !selectedItems.contains(newValue)) {
                                    selectedItems.add(newValue);
                                  }
                                });
                              },
                              isExpanded: true,
                              underline: SizedBox(),
                              items: items.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                    // Display selected items
                    TextFormField(
                      enabled: false,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.blueGrey.shade100,
                        border: OutlineInputBorder(),
                        hintText: selectedItems.isEmpty
                            ? "No items selected"
                            : selectedItems.join(', '),
                      ),
                    ),
                    // Driver Select Dropdown
                    isLoading
                        ? CircularProgressIndicator()
                        : Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: Colors.blueGrey.shade100,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: Colors.blueGrey.shade300,
                                width: 1.0,
                              ),
                            ),
                            child: DropdownButton<String>(
                              value: selectedDriver,
                              hint: Text("Select Driver"),
                              onChanged: (newValue) {
                                setState(() {
                                  selectedDriver = newValue;
                                  selectedDriverId = drivers.firstWhere(
                                    (driver) => driver['Username'] == newValue,
                                  )['DriverId'];
                                });
                              },
                              isExpanded: true,
                              underline: SizedBox(),
                              items: drivers.map<DropdownMenuItem<String>>(
                                  (Map<String, String> driver) {
                                return DropdownMenuItem<String>(
                                    value: driver['Username'],
                                    child: Text(driver['Username']!),
                                    );
                              }).toList(),
                            ),
                          ),
                    InkWell(
                      onTap: _saveRequest,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Container(
                          height: 53,
                          width: 150,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.green),
                          child: Center(
                            child: Text('Send Request',
                                style: GoogleFonts.ubuntu(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }
}
