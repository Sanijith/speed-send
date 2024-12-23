import 'package:delivery_app/Admin/drivers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class UserHome extends StatefulWidget {
  const UserHome({super.key});

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.login,
              color: Colors.red,
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              height: MediaQuery.of(context).size.height * 1,
              decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage('images/bg.jpg'),fit: BoxFit.fill)
              ),
            ),
          ),
          Positioned(
              top: 50,
              left: 0,
              right: 0,
              child: Container(
                child: Column(
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("SPEEDY SEND"),
                    )
                  ],
                ),
              )),
          Positioned(
            top: 230, // Adjust the top position as needed
            left: 100, // Adjust the left position as needed
            right: 0, // Adjust the right position as needed
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Drivers(),));
              },
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                    color: Colors.lightGreenAccent,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        topLeft: Radius.circular(30))),
                // Second container color
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Drivers',
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 380, // Adjust the top position as needed
            left: 0, // Adjust the left position as needed
            right: 100, // Adjust the right position as needed
            child: InkWell(
              onTap: () {},
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                    color: Colors.lightGreenAccent,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        bottomRight: Radius.circular(30))),
                // Second container color
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Items',
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 530, // Adjust the top position as needed
            left: 100, // Adjust the left position as needed
            right: 0, // Adjust the right position as needed
            child: InkWell(
              onTap: () {},
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                    color: Colors.lightGreenAccent,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        topLeft: Radius.circular(30))),
                // Second container color
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Delivery',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
