import 'package:delivery_app/Driver/request_decision.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class DriverHome extends StatefulWidget {
  const DriverHome({super.key});

  @override
  State<DriverHome> createState() => _DriverHomeState();
}

class _DriverHomeState extends State<DriverHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned.fill(
            child: SingleChildScrollView(child: Container(
              height: MediaQuery.of(context).size.height * 1,
              decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage('images/bg.jpg'),fit: BoxFit.fill)
              ),
            )),
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
            top: 250, // Adjust the top position as needed
            left: 100, // Adjust the left position as needed
            right: 0, // Adjust the right position as needed
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Request_Decision(),));
              },
              child: Container(
                height: 70,
                decoration: BoxDecoration(
                    color: Colors.lightGreenAccent,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        topLeft: Radius.circular(15))),
                // Second container color
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Requests',
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Positioned(
          //   top: 250, // Adjust the top position as needed
          //   left: 0, // Adjust the left position as needed
          //   right: 100, // Adjust the right position as needed
          //   child: InkWell(
          //     onTap: () {},
          //     child: Container(
          //       height: 70,
          //       decoration: BoxDecoration(
          //           color: Colors.lightGreenAccent,
          //           borderRadius: BorderRadius.only(
          //               topRight: Radius.circular(30),
          //               bottomRight: Radius.circular(30))),
          //       // Second container color
          //       child: Column(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           Text(
          //             'Items',
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          // Positioned(
          //   top: 400, // Adjust the top position as needed
          //   left: 100, // Adjust the left position as needed
          //   right: 0, // Adjust the right position as needed
          //   child: InkWell(
          //     onTap: () {},
          //     child: Container(
          //       height: 70,
          //       decoration: BoxDecoration(
          //           color: Colors.lightGreenAccent,
          //           borderRadius: BorderRadius.only(
          //               bottomLeft: Radius.circular(30),
          //               topLeft: Radius.circular(30))),
          //       // Second container color
          //       child: Column(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           Text(
          //             'Delivery',
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
