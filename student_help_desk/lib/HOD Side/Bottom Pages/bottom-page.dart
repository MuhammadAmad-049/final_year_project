import 'package:flutter/material.dart';
import 'hod_profile.dart';
import '../home_page.dart';

class HODHomePage extends StatefulWidget {
  const HODHomePage({Key? key}) : super(key: key);

  @override
  _HODHomePageState createState() => _HODHomePageState();
}

class _HODHomePageState extends State<HODHomePage> {
  int _currentIndex=0;
  final tabs=[
    HOD_Home_Screen(),
    HOD_ProfilePage(),
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
