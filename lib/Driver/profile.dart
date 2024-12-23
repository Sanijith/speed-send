import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo,
        ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height * 1,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/bg.jpg'), fit: BoxFit.fill)),
            padding: EdgeInsets.all(40),
            child: Column(
              children: [
                Container(
                  height: 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.lightBlueAccent.shade100),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 30,
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          // Padding(
                          //   padding:
                          //   const EdgeInsets.symmetric(horizontal: 25),
                          //   child: Stack(
                          //     children: [
                          //       isloading
                          //           ? CircularProgressIndicator(
                          //         color: Color(0xFF93B4D1),
                          //       )
                          //           : Padding(
                          //           padding: const EdgeInsets.only(
                          //               left: 5, top: 10),
                          //           child: Container(
                          //             height: MediaQuery.of(context)
                          //                 .size
                          //                 .height *
                          //                 .09,
                          //             width: MediaQuery.of(context)
                          //                 .size
                          //                 .width *
                          //                 .15,
                          //             decoration: BoxDecoration(
                          //               shape: BoxShape.circle,
                          //             ),
                          //             // child: CircleAvatar(
                          //             //   radius: 50,
                          //             //   backgroundColor: Colors.transparent,
                          //             // ),
                          //           )),
                          //       Positioned(
                          //         top: 50,
                          //         left: 40,
                          //         bottom: 0,
                          //         right: 0,
                          //         child: IconButton(
                          //           onPressed: () {
                          //             setState(() {
                          //
                          //             });
                          //           },
                          //           icon: Icon(Icons.camera_alt_outlined),
                          //           color: Colors.black,
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          Text(
                            "Driver Name",
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Card(
                    color: Colors.blueGrey.shade50,
                    elevation: 4,
                    child: ListTile(
                      leading: Icon(Icons.email_outlined),
                      trailing: Text("Email"),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Card(
                    color: Colors.blueGrey.shade50,
                    elevation: 4,
                    child: ListTile(
                      leading: Icon(Icons.phone_outlined),
                      trailing: Text("Phone Number"),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Container(
                          height: 53,
                          width: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.redAccent),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.logout_outlined),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('Logout'),
                              ],
                            ),
                          )),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
