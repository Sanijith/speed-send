import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/Driver/bottom_nav.dart';
import 'package:delivery_app/Driver/driv_home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Request_Decision extends StatefulWidget {
  const Request_Decision({super.key});

  @override
  State<Request_Decision> createState() => _Request_DecisionState();
}

class _Request_DecisionState extends State<Request_Decision> {


  Future<void> _refreshReqDecision() async {
    setState(() {}); // Trigger a rebuild to refresh the data
  }

  var ID;

  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    SharedPreferences spref = await SharedPreferences.getInstance();
    setState(() {
      ID = spref.getString('id');
    });
    print('Shared Preference data get');
  }

  DocumentSnapshot? Driver;

  getFirebase() async {
    Driver =
    await FirebaseFirestore.instance.collection("Driver").doc(ID).get();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => CurvedNavigationBar1(),));
            },
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
          image: DecorationImage(image: AssetImage('images/bg.jpg'),fit: BoxFit.fill)
        ),
        child: Column(
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
                    Text("Requests ",
                        style: GoogleFonts.ubuntu(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Colors.white)),
                  ],
                ),
              ),
            ),
            Divider(
              thickness: 2,
              color: Colors.black,
            ),
            Expanded(
                child: FutureBuilder(
                    future:
                        FirebaseFirestore.instance.collection("Requests").where("DriverId",isEqualTo: ID).get(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Center(
                          child: Text("Error:${snapshot.error}"),
                        );
                      }
                      final requests = snapshot.data?.docs ?? [];
                      return RefreshIndicator(
                        onRefresh: _refreshReqDecision,
                        child: ListView.builder(
                          itemCount: requests.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: ListTile(
                                title: Text("Request $index"),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("From: ${requests[index]["From"]}"),
                                    Text("To: ${requests[index]["To"]}"),
                                    Text("Items: ${requests[index]["Items"]}"),
                                    Row(
                                      children: [
                                        requests[index]["Status"] == "0"
                                            ? Row(
                                                children: [
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        FirebaseFirestore.instance
                                                            .collection(
                                                                "Requests")
                                                            .doc(requests[index]
                                                                .id)
                                                            .update({
                                                          'Status': "1"
                                                        }); // Update the 'Status' field to 1
                                                      });
                                                      print("object");
                                                    },
                                                    child:  Text('Accept',style: GoogleFonts.ubuntu(fontWeight:FontWeight.bold,fontSize: 18,color: Colors.white),),
                                                    style:
                                                        ElevatedButton.styleFrom(
                                                      backgroundColor:
                                                          Colors.lightGreenAccent,
                                                    ),
                                                  ),
                                                  SizedBox(width: 30),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        FirebaseFirestore.instance
                                                            .collection(
                                                                "Requests")
                                                            .doc(requests[index]
                                                                .id)
                                                            .update({
                                                          'Status': "2"
                                                        }); // Update the 'Status' field to 1
                                                      });
                                                    },
                                                    child:  Text('Reject',style: GoogleFonts.ubuntu(fontWeight:FontWeight.bold,fontSize: 18,color: Colors.white),),
                                                    style:
                                                        ElevatedButton.styleFrom(
                                                      backgroundColor: Colors.red,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : requests[index]["Status"] == "1"
                                                ? ElevatedButton(
                                                    onPressed: () {
                                                      print("object");
                                                    },
                                                    child: const Text('Accepted'),
                                                    style:
                                                        ElevatedButton.styleFrom(
                                                      backgroundColor:
                                                          Colors.lightGreenAccent,
                                                    ),
                                                  )
                                                : ElevatedButton(
                                                    onPressed: () {
                                                      print("object");
                                                    },
                                                    child: const Text('Rejected'),
                                                    style:
                                                        ElevatedButton.styleFrom(
                                                      backgroundColor: Colors.red,
                                                    ),
                                                  ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }))
          ],
        ),
      ),
    );
  }
}
