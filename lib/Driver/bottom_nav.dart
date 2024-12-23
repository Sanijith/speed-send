import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:delivery_app/Driver/driv_home_page.dart';
import 'package:delivery_app/Driver/profile.dart';
import 'package:flutter/material.dart';

class CurvedNavigationBar1 extends StatefulWidget {
  const CurvedNavigationBar1({super.key});

  @override
  State<CurvedNavigationBar1> createState() => _CurvedNavigationBar1State();
}

class _CurvedNavigationBar1State extends State<CurvedNavigationBar1> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text(
          'SPEEDY SEND',
          style: TextStyle(fontWeight: FontWeight.w500,),
        ),
        centerTitle: true,
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          DriverHome(),
          Profile(),
        ],
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        color: Colors.indigo,
        height: 60,
        items: [
          Icon(
            Icons.home_outlined,
            color: Colors.white,
          ),
          Icon(
            Icons.person_2_outlined,
            color: Colors.white,
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
