import 'package:flutter/material.dart';
import 'package:fyp/Student%20Side/Bottom%20Scrrens/home.dart';
import 'package:fyp/Student%20Side/Bottom%20Scrrens/profile.dart';
import '../Bottom Scrrens/history.dart';
import 'package:firebase_auth/firebase_auth.dart';
class MyApp extends StatefulWidget {

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: ' homepage ',
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex=0;
  final tabs=[
    Home(),
    History(),
    ProfilePage(),
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
              icon: Icon(Icons.history),
              label: 'History',
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

