import 'package:flutter/material.dart';

class Request_Decision extends StatefulWidget {
  const Request_Decision({super.key});

  @override
  State<Request_Decision> createState() => _Request_DecisionState();
}

class _Request_DecisionState extends State<Request_Decision> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.home_outlined),color: Colors.lightGreenAccent,)
        ],
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: Text('SPEEDY SEND'),
      ),
      body: Container(
        color: Colors.blue,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.elliptical(30, 70),
                        topRight: Radius.elliptical(30, 70),
                        bottomRight: Radius.elliptical(70, 30),
                        bottomLeft: Radius.elliptical(70, 30))),
                height: 100,
                width: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Requests ",
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(

                        title: Text("Request $index"),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("From"),
                            Text("To"),
                            Text("Item $index"),
                            Text("Price"),
                            Row(
                              children: [
                                InkWell(
                                    onTap: () {

                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Container(
                                          height: 53,
                                          width: 100,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: Colors.greenAccent),
                                          child: Center(
                                            child: Text('Accept'),
                                          )),
                                    )),
                                InkWell(
                                    onTap: () {

                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all( 10),
                                      child: Container(
                                          height: 53,
                                          width: 100,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: Colors.redAccent),
                                          child: Center(
                                            child: Text('Reject'),
                                          )),
                                    )),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ))
          ],
        ),
      ),

    );
  }
}