import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fyp/Student%20Side/Bottom%20Scrrens/profile.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ContectUs extends StatefulWidget {
  @override
  _ContectUsState createState() => _ContectUsState();
}

class _ContectUsState extends State<ContectUs> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1E1967),
      appBar: AppBar(
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
      ),
      body: Column(
        children: <Widget>[
        Container(
        height: 30.0,
        color: Color(0xff1E1967),
      ),
      Expanded(
        child: Container(
          //height: 500.0,
          decoration: BoxDecoration(
            color: Color(0xffDFDDDD),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50.0),
              topRight: Radius.circular(50.0),
            ),
          ),
          child: ListView(
              children: <Widget>[Container(
        child: Column(
          children: [
            Padding(
              padding:  EdgeInsets.only(top: 90.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Contect Us',
                    style: TextStyle(
                      color: Color(0xff1E1967),
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 20.0, left: 10.0,right: 10.0),
              child: TextField(
                maxLength: 100,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Write your text here',
                ),
                maxLines: 15,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: RaisedButton(
                textColor: Colors.white,
                color: Color(0xff1E1967),
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text("Submit",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                onPressed: () {
                  _onAlertWithCustomImagePressed(context);
                },
              ),
            ),
          ],
        ),
              ),
              ]
          ),
        ),
      ),
        ]
      ),
    );
  }

  Widget fadeAlertAnimation(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
      ) {
    return Align(
      child: FadeTransition(
        opacity: animation,
        child: child,
      ),
    );
  }
  _onAlertWithCustomImagePressed(context) {
    Alert(
      style: AlertStyle(
        alertAlignment: Alignment.topCenter,
        animationType: AnimationType.fromTop,
        //isCloseButton: false,
        isOverlayTapDismiss: false,
        animationDuration: Duration(milliseconds: 400),
        alertBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
          side: BorderSide(
            color: Colors.grey,
          ),
        ),
      ),
      alertAnimation: fadeAlertAnimation,
      context: context,
      title: "Succeed",
      desc: "Your message has successfully sent.",
      image: Image.asset("assets/success.png"),
    ).show();
  }
}
