import 'package:flutter/material.dart';
import 'package:fyp/Student%20Side/Modules/Account_Office.dart';
import 'package:fyp/Student%20Side/Modules/Cafe.dart';
import 'package:fyp/Student%20Side/Modules/Exam_office.dart';
import 'package:fyp/Student%20Side/Modules/Registration.dart';
import 'package:fyp/Student%20Side/Modules/Transport_office.dart';
import 'package:fyp/Student%20Side/Notifications/notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
class Home extends StatefulWidget {

  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void initState(){
    super.initState();
    fetchcomplaint();
  }
final user=FirebaseAuth.instance.currentUser;
  List notification=[];
  bool loading=true;
  bool data=true, color=false;
  fetchcomplaint() {
    List listofcomplaint=[];
    FirebaseFirestore
        .instance
        .collection("complaint")
        .where("email", isEqualTo: user?.email)

    //.where("type", isEqualTo: "exam")
        .where("status",isNotEqualTo: "pending")
        .get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        listofcomplaint.add(result);
        //complaintkey.add(result.id);
        print(result.data());

          if(mounted){
            setState(() {
              notification=listofcomplaint;

            });
            loading=false;data=false;
            color=true;
        }

      });
    });
  }
  @override
  Widget build(BuildContext context) {
    // if(data){
    //   fetchcomplaint();
    // }
    return Scaffold(
      backgroundColor: Color(0xff1E1967),
      appBar: AppBar(
          leading: Padding(
            padding:  EdgeInsets.only(top: 5.0, left: 10.0,),
            child: Image.asset(
              "assets/COMSATS-logo.png",
              alignment: Alignment.centerLeft,
              height: 60,
              width: 60,
            ),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xff1E1967),
          centerTitle: true,
          title: Text(
            'Student Help Desk',
            style: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
              fontFamily: "Lobster",
            ),
          ),
          elevation: 0.0,
          actions: <Widget>[
           Stack(
             alignment: Alignment.topRight,
             children: [
               Text("${notification.length}", style: TextStyle(color: Colors.red),),
               IconButton(
                 icon: Icon(
                   Icons.notifications,
                   color: Colors.red,
                 ),
                 onPressed: () {
                   color=false;
                   Navigator.push(
                     context,
                     MaterialPageRoute(builder: (context) => Student_Notifications()),
                   );
                 },
               )
             ],
           )
          ]
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 30.0,
            color: Color(0xff1E1967),
          ),
          Expanded (
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xffDFDDDD),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50.0),
                  topRight: Radius.circular(50.0),
                ),
              ),
              child: ListView(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Padding(
                        padding:  EdgeInsets.only(top: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Select Your Category',
                              style: TextStyle(
                                color: Color(0xff1E1967),
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Poppins",
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            TextButton(onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> Cafeteria(),));
                            },
                              child: Container(
                                padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                // color: Colors.red,
                                height: 120,
                                width: 100,
                                decoration:  BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(0, 3), // changes position of shadow
                                      ),
                                    ],
                                    color: Colors.white
                                ),
                                child:  Column(
                                  children: [
                                    Image.asset("images/Cafe.png",height: 80,width: 80,),
                                    SizedBox(height: 3,),
                                    Text('Cafeteria',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Color(0xff1E1967),
                                        fontWeight: FontWeight.bold,
                                      ),),
                                  ],

                                ),
                              ),),
                            TextButton(onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> Registration_Office(),));
                            },
                              child: Container(
                                padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                // color: Colors.red,
                                height: 120,
                                width: 100,
                                decoration:  BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(0, 3), // changes position of shadow
                                      ),
                                    ],
                                    color: Colors.white
                                ),
                                child:  Column(
                                  children: [
                                    Image.asset("images/Registration.png",height: 70,width: 70,),
                                    SizedBox(height: 2,),
                                    Text('Registration',textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xff1E1967),
                                        fontWeight: FontWeight.bold,
                                      ),),
                                  ],
                                ),
                              ),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            TextButton(onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> Account_Office(),));
                            },
                              child: Container(
                                padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                // color: Colors.red,
                                height: 120,
                                width: 100,
                                decoration:  BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(0, 3), // changes position of shadow
                                      ),
                                    ],
                                    color: Colors.white
                                ),
                                child:  Column(
                                  children: [
                                    Image.asset("images/Account.png",height: 80,width: 80,),
                                    SizedBox(height: 3,),
                                    Text('Account',textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Color(0xff1E1967),
                                        fontWeight: FontWeight.bold,
                                      ),),
                                  ],
                                ),
                              ),),
                            TextButton(onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> ExamOffice(),));
                            },
                              child: Container(
                                padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                // color: Colors.red,
                                height: 120,
                                width: 100,
                                decoration:  BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(0, 3), // changes position of shadow
                                      ),
                                    ],
                                    color: Colors.white
                                ),
                                child:  Column(
                                  children: [
                                    Image.asset("images/Exam.png",height: 80,width: 80,),
                                    SizedBox(height: 3,),
                                    Text('Exam',textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Color(0xff1E1967),
                                        fontWeight: FontWeight.bold,
                                      ),),
                                  ],
                                ),
                              ),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            TextButton(onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> Transport_Office(),));
                            },
                              child: Container(
                                padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                // color: Colors.red,
                                height: 120,
                                width: 100,
                                decoration:  BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(0, 3), // changes position of shadow
                                      ),
                                    ],
                                    color: Colors.white
                                ),
                                child:  Column(
                                  children: [
                                    Image.asset("images/Transport.png",height: 80,width: 80,),
                                    SizedBox(height: 3,),
                                    Text('Transport',textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Color(0xff1E1967),
                                        fontWeight: FontWeight.bold,
                                      ),),
                                  ],
                                ),
                              ),),
                          ],
                        ),
                      ),

                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
