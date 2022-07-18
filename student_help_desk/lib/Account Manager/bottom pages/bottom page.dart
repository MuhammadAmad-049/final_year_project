import 'package:flutter/material.dart';
import 'package:fyp/Account%20Manager/bottom%20pages/profile.dart';
import '../home_page.dart';

class AM_Home extends StatefulWidget {
  const AM_Home({Key? key}) : super(key: key);

  @override
  _AM_HomeState createState() => _AM_HomeState();
}

class _AM_HomeState extends State<AM_Home> {
  int _currentIndex=0;
  final tabs=[
    AM_Home_Page(),
    AM_Profile(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_currentIndex],
      bottomNavigationBar: SizedBox(
        height: 67,
        child: BottomNavigationBar(
          backgroundColor: Color(0xff1E1967),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white38,
          selectedLabelStyle: TextStyle(color: Color(0xFFA67926), fontSize: 20.0),
          unselectedLabelStyle: TextStyle(color: Colors.grey[600], fontSize: 15.0),
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_box),
              label: 'Profile',
            ),
          ],
          onTap: (index){
            setState(() {
              _currentIndex=index;
            });
          },
        ),
      ),
    );
  }
}
