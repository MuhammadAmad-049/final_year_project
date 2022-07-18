import 'package:flutter/material.dart';
import 'package:fyp/HOD%20Side/Bottom%20Pages/bottom-page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../home_page.dart';
import 'hod_open_notifi.dart';

class HOD_Notification extends StatefulWidget {
  const HOD_Notification({Key? key}) : super(key: key);

  @override
  _HOD_NotificationState createState() => _HOD_NotificationState();
}

class _HOD_NotificationState extends State<HOD_Notification> {


  List forward_complaints=[];
  List stdkey=[];
  fetchcomplaint() {
    List listofcomplaint=[];
    FirebaseFirestore
        .instance
        .collection("hod_complaints")

        .where("status", isEqualTo: "pending")
        .get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        listofcomplaint.add(result);
        //stdkey.add(result.id);
        print(result.data());
        if(mounted){
          setState(() {
            forward_complaints=listofcomplaint;
          });
          loading=false;
          data=false;

        }

      });
    });
  }
  bool loading=true;
bool data=true;
  @override build(BuildContext context) {
    if(data){
      fetchcomplaint();
    }
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
              MaterialPageRoute(builder: (context) => HODHomePage()),
            );
          },
        ),
        centerTitle: true,
        title: Text(
          'Notications',
          style: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
            fontFamily: "Lobster",
          ),
        ),
        elevation: 0.0,
      ),
      body: loading? Center(child: CircularProgressIndicator(strokeWidth: 3,backgroundColor: Colors.amber, color: Colors.black,),)
          :Column(
          children: <Widget>[
            Expanded(
                child: Container(
                    color: Colors.white,
                    child: ListView.builder(physics: ClampingScrollPhysics(),shrinkWrap: true,itemCount: forward_complaints.length ,itemBuilder: (context, index){
                      return Container(
                        margin:  EdgeInsets.all(10.0),
                        child: Card(
                          color: Colors.white,
                          shape:  RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => HOD_Open_Notification(forward_complaints[index].id, forward_complaints[index].data())),
                              );
                            },
                            child: Column(
                              //crossAxisAlignment: CrossAxisAlignment.stretch,
                              // add this
                              children: <Widget>[
                                Row(
                                  children: [
                                    Container(
                                      height: 100,width: 100,
                                      child: ClipOval(child: Image.network(forward_complaints[index]["std-image"])),
                                    ),
                                    SizedBox(
                                      width: 200,
                                      child: Column(
                                        children: [
                                          Text(
                                            'Module:    ${forward_complaints[index]["type"]}',
                                            softWrap: false,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            'Student_Name:    ${forward_complaints[index]["student_name"]}',
                                            softWrap: false,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            'Reg_No:    ${forward_complaints[index]["student_reg"]}',

                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                                TextButton.icon(onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (c)=>HOD_Open_Notification(forward_complaints[index].id, forward_complaints[index].data())));
                                }, icon: Icon(Icons.remove_red_eye), label: Text("See detail",
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),)),
                              ],
                            ),
                          ),
                          elevation: 8,
                        ),
                      );

                    }))
            ),
          ]
      ),
    );
  }
}
