import 'package:flutter/material.dart';
import 'package:fyp/Transport%20Manager/Notifications/tm_open_notification.dart';
import 'package:fyp/Transport%20Manager/bottom%20pages/bottom%20page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TM_Notifications extends StatefulWidget {
  const TM_Notifications({Key? key}) : super(key: key);

  @override
  _TM_NotificationsState createState() => _TM_NotificationsState();
}

class _TM_NotificationsState extends State<TM_Notifications> {

  void initstate(){
    super.dispose();
    //fetchcomplaint();
  }
  List transport_compalint=[];
  List stdkey=[];

  fetchcomplaint() {
    List listofcomplaint=[];
    FirebaseFirestore
        .instance
        .collection("complaint")
        .where("type", whereIn: ["transport"])
        .where("status",isEqualTo: "pending")
        .get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        listofcomplaint.add(result);
        //stdkey.add(result.id);
        setState(() {
          transport_compalint=listofcomplaint;
        });
        loading=false;

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
              MaterialPageRoute(
                  builder: (context) =>  TM_Home()),
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
      body:loading? Center(child: CircularProgressIndicator(strokeWidth: 3,backgroundColor: Colors.amber, color: Colors.black,),): Column(
          children: <Widget>[
            Expanded(
                child: Container(
                    color: Colors.white,
                    child: ListView.builder(physics: ClampingScrollPhysics(),shrinkWrap: true,itemCount: transport_compalint.length,itemBuilder: (context, index){
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
                                MaterialPageRoute(builder: (context) => TM_Open_Notificatons(transport_compalint[index].id, transport_compalint[index].data())),
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
                                      child: ClipOval(child: Image.network(transport_compalint[index]["std-image"])),
                                    ),
                                    SizedBox(
                                      width: 200,
                                      child: Column(
                                        children: [
                                          Text(
                                            'Module:   ${transport_compalint[index]["type"]}',

                                            style: TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            'Student_Name:    ${transport_compalint[index]["student_name"]}',
                                            softWrap: false,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          Text(
                                            'Reg_No:    ${transport_compalint[index]["student_reg"]}',
                                            softWrap: false,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                                TextButton.icon(onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (c)=>TM_Open_Notificatons(transport_compalint[index].id, transport_compalint[index].data()))
                                  );
                                  },
                                    icon: Icon(Icons.remove_red_eye), label: Text("See detail",
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
