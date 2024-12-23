import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Send_Request extends StatefulWidget {
  const Send_Request({super.key});

  @override
  State<Send_Request> createState() => _Send_RequestState();
}

class _Send_RequestState extends State<Send_Request> {
  // Controller for text fields to retrieve their values
  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();
  final TextEditingController itemController = TextEditingController();

  String? selectedDriver;
  List<String> drivers = []; // List to store driver names
  bool isLoading = true; // To show loading indicator while fetching data

  @override
  void initState() {
    super.initState();
    _fetchDrivers();
  }

  // Fetch drivers from Firebase Firestore
  Future<void> _fetchDrivers() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('driver_register')
          .get();

      List<String> driverList = [];
      for (var doc in snapshot.docs) {
        driverList.add(doc['name']);
      }

      setState(() {
        drivers = driverList;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching drivers: $e');
    }
  }

  // Function to save data to Firebase Firestore
  Future<void> _saveRequest() async {
    if (fromController.text.isEmpty ||
        toController.text.isEmpty ||
        itemController.text.isEmpty ||
        selectedDriver == null) {
      // Show an error message if any field is empty
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }

    try {
      // Create a new document in the 'request' collection
      await FirebaseFirestore.instance.collection('Requests').add({
        'From': fromController.text,
        'To': toController.text,
        'Item': itemController.text,
        'Driver': selectedDriver,
      });

      // Show success dialog
      _showSuccessDialog();

      // Optionally, clear the fields after saving
      fromController.clear();
      toController.clear();
      itemController.clear();
      setState(() {
        selectedDriver = null;
      });
    } catch (e) {
      print('Error saving request: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to send request")),
      );
    }
  }


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
          backgroundColor: Colors.indigo,
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
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('images/logo.jpg'),
                ),
                Text("SPEEDY SEND"),
                TextFormField(
                  controller: fromController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.blueGrey.shade100,
                    border: OutlineInputBorder(),
                    hintText: "FROM",
                  ),
                ),
                TextFormField(
                  controller: toController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.blueGrey.shade100,
                    border: OutlineInputBorder(),
                    hintText: "TO",
                  ),
                ),
                TextFormField(
                  controller: itemController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.blueGrey.shade100,
                    border: OutlineInputBorder(),
                    hintText: "Item select",
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
                      });
                    },
                    isExpanded: true, // Make dropdown fill the container
                    underline: SizedBox(), // Remove the default underline
                    items: drivers
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                InkWell(
                  onTap: _saveRequest, // Save data when the button is pressed
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      height: 53,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.greenAccent),
                      child: Center(
                        child: Text('SEND'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
