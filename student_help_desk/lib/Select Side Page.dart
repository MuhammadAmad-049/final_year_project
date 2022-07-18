import 'package:flutter/material.dart';
import 'Account Manager/Starting pages/AM_login.dart';
import 'Cafe Manager/Starting pages/CM_login.dart';
import 'DOO Side/Starting pages/doo_login.dart';
import 'HOD Side/Starting pages/hod_login.dart';
import 'Student Side/appStartingPages/login.dart';
import 'Transport Manager/bottom pages/bottom page.dart';


class SelectSide extends StatefulWidget {
  const SelectSide({Key? key}) : super(key: key);

  @override
  _SelectSideState createState() => _SelectSideState();
}

class _SelectSideState extends State<SelectSide> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
        image: DecorationImage(
        image: AssetImage('assets/Select-Side.png'), fit: BoxFit.cover),
    ),
    child:  Scaffold(
      backgroundColor: Colors.transparent,
        body: SafeArea(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 100.0,
          ),
          Center(
       child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 50.0,
        backgroundImage: AssetImage("assets/COMSATS-logo.png",),
    ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Center(
            child: Column(
              children: [
                ElevatedButton(
                  child: const Text('HOD'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  DOO_Login("hod")),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(210, 50),
                      primary: Color(0xff1E1967),
                      textStyle:
                      const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white,)),
                ),
                SizedBox(
                  height: 10.0,
                ),
                ElevatedButton(
                  child: const Text('DOO'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  DOO_Login("doo")),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(210, 50),
                      primary: Color(0xff1E1967),
                      textStyle:
                      const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white,)),
                ),
                SizedBox(
                  height: 10.0,
                ),
                ElevatedButton(
                  child: const Text('Registration Manager'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  DOO_Login("rm")),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(210, 50),
                      primary: Color(0xff1E1967),
                      textStyle:
                      const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white,)),
                ),
                SizedBox(
                  height: 10.0,
                ),
                ElevatedButton(
                  child: const Text('Account Manager'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  DOO_Login("am")),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(210, 50),
                      primary: Color(0xff1E1967),
                      textStyle:
                      const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white,)),
                ),
                SizedBox(
                  height: 10.0,
                ),
                ElevatedButton(
                  child: const Text('Cafe Manager'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  DOO_Login("cm")),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(210, 50),
                      primary: Color(0xff1E1967),
                      textStyle:
                      const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white,)),
                ),
                SizedBox(
                  height: 10.0,
                ),
                ElevatedButton(
                  child: const Text('Transport Manager'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  DOO_Login("tm")),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(210, 50),
                      primary: Color(0xff1E1967),
                      textStyle:
                      const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white,)),
                ),
                SizedBox(
                  height: 10.0,
                ),
                ElevatedButton(
                  child: const Text('Student'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  StudentLogin()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(210, 50),
                      primary: Color(0xff1E1967),
                      textStyle:
                      const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white,)),
                ),
              ],
            ),
          ),
          //SizedBox(
           // height: 20.0,
         // ),
        /*  Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                child: const Text('HOD'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>  HOD_Login()),
                  );
                },
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(160, 50),
                    primary: Color(0xff1E1967),
                    textStyle:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white,)),
              ),
              ElevatedButton(
                child: const Text('DOO'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>  DOO_Login()),
                  );
                },
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(160, 50),
                    primary: Color(0xff1E1967),
                    textStyle:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white,)),
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
           // width: 150.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                child: const Text('Account Manager'),
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(200, 50),
                    primary: Color(0xff1E1967),
                    textStyle:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white,)),
              ),
              ElevatedButton(
                child: const Text('Cafe Manager'),
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(160, 50),
                    primary: Color(0xff1E1967),
                    textStyle:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white,)),
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                child: const Text('Transport Manager'),
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(160, 50),
                    primary: Color(0xff1E1967),
                    textStyle:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white,)),
              ),
              ElevatedButton(
                child: const Text('Student'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>  StudentLogin()),
                  );
                },
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(160, 50),
                    primary: Color(0xff1E1967),
                    textStyle:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white,)),
              ),
            ],
          ),*/
        ]
        ),
        ),
    ),
    );
  }
}
