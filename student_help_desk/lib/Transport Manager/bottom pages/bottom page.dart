import 'package:flutter/material.dart';
import 'package:fyp/Transport%20Manager/bottom%20pages/profile.dart';
import 'package:fyp/Transport%20Manager/home_page.dart';

class TM_Home extends StatefulWidget {
  const TM_Home({Key? key}) : super(key: key);

  @override
  _TM_HomeState createState() => _TM_HomeState();
}

class _TM_HomeState extends State<TM_Home> {
  int _currentIndex=0;
  final tabs=[
    TM_Home_Page(),
    TM_Profile(),
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
