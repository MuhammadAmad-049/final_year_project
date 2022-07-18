import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fyp/registrstion_side/Bottom%20Pages/home_screen.dart';
import '../Bottom Pages/bottom_page.dart';
import 'rm_open_notifications.dart';

class RM_Notifications extends StatefulWidget {
  const RM_Notifications({Key? key}) : super(key: key);

  @override
  _RM_NotificationsState createState() => _RM_NotificationsState();
}

class _RM_NotificationsState extends State<RM_Notifications> {
  void initstate(){
    super.dispose();
    fetchcomplaint();
  }
  List registration_compalint=[];
  List stdkey=[];
  //List registration_compalint=[];
  fetchcomplaint() {
    List listofcomplaint=[];
    FirebaseFirestore
        .instance
        .collection("complaint")
        .where("type", isEqualTo:"registration")
    .where("status",isEqualTo: "pending")
        .get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        listofcomplaint.add(result);
        //stdkey.add(result.id);
        print(result.data());
        if(listofcomplaint.isNotEmpty){
          if(mounted){
            setState(() {
              registration_compalint=listofcomplaint;
            });
            loading=false;
            data=false;

          }
        }
        else{
          setState(() {

          });
        }


      });
    });
  }
  bool data=true;
  bool loading=true;
  @override
  Widget build(BuildContext context) {
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
              MaterialPageRoute(builder: (context) => RM_Home()),
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
                    child: ListView.builder(physics: ClampingScrollPhysics(),shrinkWrap: true,itemCount: registration_compalint.length ,itemBuilder: (context, index){
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
                                MaterialPageRoute(builder: (context) => RM_Open_Notificatons(registration_compalint[index].id, registration_compalint[index].data())),
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
                                      child: ClipOval(child: Image.network(registration_compalint[index]["std-image"])),
                                    ),
                                    SizedBox(
                                      width: 200,
                                      child: Column(
                                        children: [
                                          Text(
                                            '${registration_compalint[index]["type"]}',
                                            softWrap: false,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            '${registration_compalint[index]["student_name"]}',
                                            softWrap: false,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            '${registration_compalint[index]["student_reg"]}',

                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                                TextButton.icon(onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (c)=>RM_Open_Notificatons(registration_compalint[index].id, registration_compalint[index].data())));
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
