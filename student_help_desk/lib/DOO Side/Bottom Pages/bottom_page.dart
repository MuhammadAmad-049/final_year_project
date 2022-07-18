import 'package:flutter/material.dart';
import 'doo_profile.dart';
import 'home_screen.dart';

class DOOHomePage extends StatefulWidget {
  const DOOHomePage({Key? key}) : super(key: key);

  @override
  _DOOHomePageState createState() => _DOOHomePageState();
}

class _DOOHomePageState extends State<DOOHomePage> {
  int _currentIndex=0;
  final tabs=[
    DOO_Home_Screen(),
    DOO_ProfilePage(),
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
