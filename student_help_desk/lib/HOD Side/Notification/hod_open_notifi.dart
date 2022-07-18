import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'hod_notifications.dart';

class HOD_Open_Notification extends StatefulWidget {
   Map forward;
  var studentkey;
  HOD_Open_Notification(this.studentkey,this.forward,{Key? key}) : super(key: key);

  @override
  _HOD_Open_NotificationState createState() => _HOD_Open_NotificationState(this.studentkey,this.forward);
}

class _HOD_Open_NotificationState extends State<HOD_Open_Notification> {
  _HOD_Open_NotificationState(this.complaint_key, this.singlecomplaints){}
  Map singlecomplaints;
  var complaint_key;
Future <void> _updateData(String value)async{
  await FirebaseFirestore.instance
      .collection("complaint")
      .doc(singlecomplaints["complaint_id"])
      .update({
    "status":value,
  })
      .whenComplete(() {
    print("successfully update!");
  });
}
  _accept()async{

    await FirebaseFirestore.instance
        .collection("hod_complaints")
        .doc(complaint_key)
        .update({"status": "approved"}).then((_) async {
      //print("success to approve!");
       await _updateData("approved");
    });
  }
  _reject()async{

    await FirebaseFirestore.instance
        .collection("hod_complaints")
        .doc(complaint_key)
        .update({"status": "rejected"}).then((_) async{
      // print("success to reject!");
      await _updateData("rejected");

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
              MaterialPageRoute(builder: (context) => HOD_Notification()),
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
                        SizedBox(
                          height: 30,
                        ),
                        Center(
                          child: Text(
                            'Moduule:   ${singlecomplaints['Department']}',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        Center(
                          child: Text(
                            'Student_Name:   ${singlecomplaints['student_name']}',
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
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Container(
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
                        ),
                      ],
                    ),
                    // Container(child: Column(
                    //   children: [
                    //    // Image.network("${singlecomplaints['picture']}",height: 280,width: 280,),
                    //   ],
                    // ),),
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
                              Navigator.push(context, MaterialPageRoute(builder: (c)=>HOD_Notification()));
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
                              Navigator.push(context, MaterialPageRoute(builder: (c)=>HOD_Notification()));
                            },
                          ),
                        ],
                      ),
                    ),

                    Container(child: Image.network(singlecomplaints['picture'],height: 400,width: 400,))
                  ]
              ),
            ),
          ),
        ],
      ),
    );
  }
}
