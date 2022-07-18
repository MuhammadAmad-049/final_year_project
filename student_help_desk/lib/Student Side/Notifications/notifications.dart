import 'package:flutter/material.dart';
import '../Modules/bottom_page.dart';
import 'open.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
class Student_Notifications extends StatefulWidget {
  const Student_Notifications({Key? key}) : super(key: key);

  @override
  _Student_NotificationsState createState() => _Student_NotificationsState();
}

class _Student_NotificationsState extends State<Student_Notifications> {
  bool data=true;
  bool loading=true;
  List accepted_complaints=[];
 final user=FirebaseAuth.instance.currentUser;
  fetchcomplaint() {
    List listofcomplaint=[];
    FirebaseFirestore
        .instance
        .collection("complaint")
        //.where("type", isEqualTo: "exam")
          .where("status",isNotEqualTo: "pending")
        .get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        listofcomplaint.add(result);
        //complaintkey.add(result.id);
        print(result.data());
        if(mounted){
          setState(() {
            accepted_complaints=listofcomplaint;

          });
          loading=false;data=false;

        }

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if(data){fetchcomplaint();}
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
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          },
        ),
        centerTitle: true,
        title: Text(
          'Notifications',
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
                child:ListView.builder( itemCount: accepted_complaints.length,itemBuilder: (context, index){

                 return  Container(
                   margin:  EdgeInsets.all(10.0),
                   child: Padding(
                     padding: const EdgeInsets.only(top: 10.0,),
                     child: Card(
                       color: Colors.white,
                       shape:  RoundedRectangleBorder(
                           borderRadius:
                           BorderRadius.all(Radius.circular(10.0))),
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.stretch,
                         // add this
                         children: <Widget>[
                           if(accepted_complaints[index]["type"]=="registration")
                             Row(
                               children: [
                                 Padding(
                                   padding:  EdgeInsets.only(top: 5.0, left: 10.0,),
                                   child:Icon(Icons.notifications_active, size: 20,),
                                 ),
                                 Padding(
                                   padding:  EdgeInsets.only(left: 5.0),
                                   child: Text(
                                     'Registration Manager\nhas ${accepted_complaints[index]["status"]} your Issue',
                                     style: TextStyle(fontWeight: FontWeight.bold),
                                   ),
                                 ),
                               ],
                             ),
                          if(accepted_complaints[index]["type"]=="exam")
                            Row(
                              children: [
                                Padding(
                                  padding:  EdgeInsets.only(top: 5.0, left: 10.0,),
                                  child:Icon(Icons.notifications_active, size: 20,),

                  ),
                                Padding(
                                  padding:  EdgeInsets.only(left: 5.0),
                                  child: Text(
                                    'DOO\nhas ${accepted_complaints[index]["status"]} your Issue',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                           if(accepted_complaints[index]["type"]=="account")
                             Row(
                               children: [
                                 Padding(
                                   padding:  EdgeInsets.only(top: 5.0, left: 10.0,),
                                   child:Icon(Icons.notifications_active, size: 20,),

                                 ),
                                 Padding(
                                   padding:  EdgeInsets.only(left: 5.0),
                                   child: Text(
                                     'Account Manager\nhas ${accepted_complaints[index]["status"]} your Issue',
                                     style: TextStyle(fontWeight: FontWeight.bold),
                                   ),
                                 ),
                               ],
                             ),
                           if(accepted_complaints[index]["type"]=="cafe")
                             Row(
                               children: [
                                 Padding(
                                   padding:  EdgeInsets.only(top: 5.0, left: 10.0,),
                                   child:Icon(Icons.notifications_active, size: 20,),

                                 ),
                                 Padding(
                                   padding:  EdgeInsets.only(left: 5.0),
                                   child: Text(
                                     'Cafe Manager\nhas ${accepted_complaints[index]["status"]} your Issue',
                                     style: TextStyle(fontWeight: FontWeight.bold),
                                   ),
                                 ),
                               ],
                             ),
                           if(accepted_complaints[index]["type"]=="transport")
                             Row(
                               children: [
                                 Padding(
                                   padding:  EdgeInsets.only(top: 5.0, left: 10.0,),
                                   child:Icon(Icons.notifications_active, size: 20,),

                                 ),
                                 Padding(
                                   padding:  EdgeInsets.only(left: 5.0),
                                   child: Text(
                                     'Transport Manager\nhas ${accepted_complaints[index]["status"]} your Issue',
                                     style: TextStyle(fontWeight: FontWeight.bold),
                                   ),
                                 ),
                               ],
                             ),
                         ],
                       ),
                       elevation: 8,
                     ),
                   ),
                 );


                })
              ),
            ),
          ]
      ),
    );
  }
}
