import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'cm_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CM_Open_Notificatons extends StatefulWidget {
  Map complaint;
  var studentkey;
  CM_Open_Notificatons(this.studentkey,this.complaint,{Key? key}) : super(key: key);

  @override
  _CM_Open_NotificatonsState createState() => _CM_Open_NotificatonsState(this.studentkey,this.complaint);
}

class _CM_Open_NotificatonsState extends State<CM_Open_Notificatons> {

  _CM_Open_NotificatonsState(this.complaint_key,this.singlecomplaints){}
  Map singlecomplaints;
  var complaint_key;
  _accept()async{

    await FirebaseFirestore.instance
        .collection("complaint")
        .doc(complaint_key)
        .update({"status": "approved"}).then((_) {
      print("success to approve!");
    });
  }
  _reject()async{

    await FirebaseFirestore.instance
        .collection("complaint")
        .doc(complaint_key)
        .update({"status": "rejected"}).then((_) {
      print("success to reject!");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1E1967),
      appBar: AppBar(
        backgroundColor: Color(0xff1E1967),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CM_Notifications()),
            );
          },
        ),
        centerTitle: true,
        title: Text(
          'Details',
          style: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0.0,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              color: Colors.white,
              child: ListView(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              TextButton(onPressed: (){
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
                                      Text('Cafe',textAlign: TextAlign.center,
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
                        SizedBox(
                          height: 30,
                        ),
                        Center(
                          child: Text(
                            '${singlecomplaints['student_name']}',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 0.5),
                            child: Text(
                              'CIIT/${singlecomplaints['student_reg']}/VHR',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(10.0),
                          child: Card(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                 ListTile(
                                  title: Text(
                                    '${singlecomplaints['complaint']}',
                                    style: TextStyle(
                                      fontSize: 17,
                                    ),
                                  ),
                                  // subtitle: Text(''),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FlatButton(
                            textColor: Colors.white,
                            color:  Color(0xff1E1967),
                            child: const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                "Accept",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            onPressed: () {
                              _accept();
                              Navigator.push(context, MaterialPageRoute(builder: (c)=>CM_Notifications()));
                            },
                          ),
                          FlatButton(
                            textColor: Colors.white,
                            color:  Color(0xff1E1967),
                            child: const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                "Reject",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            onPressed: () {
                              _reject();
                              Navigator.push(context, MaterialPageRoute(builder: (c)=>CM_Notifications()));

                            },
                          ),
                        ],
                      ),
                    ),
                    Container( height:400,width:350,child: Image.network(singlecomplaints['picture']))
                  ]
              ),
            ),
          ),
        ],
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
      title: "Succeefully",
      desc: "Your message has successfully forward to HOD.",
      image: Image.asset("assets/success.png"),
    ).show();
  }
}
