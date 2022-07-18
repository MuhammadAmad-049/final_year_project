import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fyp/Student%20Side/Bottom%20Scrrens/show_complaint.dart';
class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}


class _HistoryState extends State<History> {
  final  user=FirebaseAuth.instance.currentUser;
bool _loading=true;
int t=0,p=0,a=0,r=0;
  List currentuser=[];
  List userdata=[];

  void initstate(){
    super.dispose();
    counter();
   //_pending();
  }
 List complaint=[];
  List pendinglist=[];
  List rejectlist=[];
  List acceptlist=[];
    void counter() async{
      //String emailvalue='${user?.email!}';
      //emailvalue=emailvalue+" ";
      t=0;
      p=0;
      a=0;
      r=0;
      List data=[];
      //complaint=0;

      await FirebaseFirestore.instance.collection("users").where("email", isEqualTo: user?.email).get().then((querysnapshot) {
        querysnapshot.docs.forEach((element) {
          print(element.data());
          userdata.add(element.data());
        });
      });



      var result= await FirebaseFirestore.instance.collection("complaint").where("email", isEqualTo: user?.email).get();
      result.docs.forEach((element) {
      // print(element.data());
        t++;

      }
      );
      _loading=false;
      var result2= await FirebaseFirestore.instance.collection("complaint").where("email", isEqualTo: user?.email)
          .where("status", isEqualTo: "pending").get();
      result2.docs.forEach((element) {
         //print(element.data());
        p++;

      }
      );
      _loading=false;

      var result3= await FirebaseFirestore.instance.collection("complaint").where("email", isEqualTo: user?.email)
          .where("status", isEqualTo: "rejected").get();
      result3.docs.forEach((element) {
        // print(element.data());
        r++;

      }
      );
      _loading=false;
      var result4= await FirebaseFirestore.instance.collection("complaint").where("email", isEqualTo: user?.email)
          .where("status", isEqualTo: "approved").get();
      result4.docs.forEach((element) {
        // print(element.data());
        a++;

      }
      );
      _loading=false;
      if(first){
        first=false;
        if(mounted){
          setState(() {

          });
        }
      }

    }


  bool first=true;
  @override
  Widget build(BuildContext context) {
  if(first){
    counter();
  }
    return Scaffold(
      backgroundColor: Color(0xff1E1967),
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xff1E1967),
          centerTitle: true,
          title: Text(
            'History',
            style: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
              fontFamily: "Lobster",
            ),
          ),
          elevation: 0.0,
      ),
        body:         _loading==true? Center(child: CircularProgressIndicator(),):
      Column(
            children: <Widget>[
              Expanded (
                child: Container(
                  color: Colors.white,
                  child: ListView(
                    children: <Widget>[
                      Container(
                        height: 100,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Card(
                            elevation: 8,
                            color: Colors.white,
                            shape:  RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                            child: InkWell(
                              onTap: () {

                              },
                              child: Column(
                                //crossAxisAlignment: CrossAxisAlignment.stretch,
                                // add this
                                children: <Widget>[
                                  Row(
                                    children: [
                                      Padding(
                                        padding:  EdgeInsets.all(20),
                                        child: Icon(Icons.send),
                                      ),
                                      Padding(
                                        padding:  EdgeInsets.only(left: 5.0),
                                        child: Text(
                                          'Sent Reports',
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Spacer(),

                                      Padding(
                                        padding:  EdgeInsets.only(left: 5.0),
                                        child: Text(
                                          '${t}',
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 100,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Card(
                            elevation: 8,
                            color: Colors.white,
                            shape:  RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (c)=>show_complaint("approved")));
                              },
                              child: Column(
                                // crossAxisAlignment: CrossAxisAlignment.stretch,
                                // add this

                                children: <Widget>[
                                  Row(
                                    children: [
                                      Padding(
                                        padding:EdgeInsets.all(20),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(50),
                                          ),
                                          child: Icon(Icons.verified),
                                        ),
                                      ),
                                      Padding(
                                        padding:  EdgeInsets.only(left: 5.0),
                                        child: Text(
                                          'Accept Reports',
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Spacer(),
                                     Padding(
                                        padding:  EdgeInsets.only(left: 5.0),
                                        child: Text(
                                          '${a}',
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                      height: 100,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Card(
                            elevation: 8,
                            color: Colors.white,
                            shape:  RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (c)=>show_complaint("rejected")));

                              },
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: [
                                      Padding(
                                        padding:  EdgeInsets.all(20),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(50),
                                          ),
                                          child:  Icon(Icons.cancel_rounded),
                                        ),

                                      ),
                                      Padding(
                                        padding:  EdgeInsets.only(left: 5.0),
                                        child: Text(
                                          'Rejected Reports',
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Spacer(),
                                      SizedBox(width: 10),
                                      Padding(
                                        padding:  EdgeInsets.only(left: 5.0),
                                        child: Text(
                                          '${r}',
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 100,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Card(
                            elevation: 8,
                            color: Colors.white,
                            shape:  RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (c)=>show_complaint("pending")));

                              },
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: [
                                      Padding(
                                        padding:  EdgeInsets.all(20),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(50),
                                          ),
                                          child:  Icon(Icons.pending_rounded),
                                        ),

                                      ),
                                      Padding(
                                        padding:  EdgeInsets.only(left: 5.0),
                                        child: Text(
                                          'Pending Reports',
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Spacer(),

                                      Padding(
                                        padding:  EdgeInsets.only(left: 5.0),
                                        child: Text(
                                          '${p}',
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]
        ),
    );
  }

}
