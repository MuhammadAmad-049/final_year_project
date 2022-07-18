import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
class show_complaint extends StatefulWidget {
  String str;
   show_complaint(this.str, {Key? key}) : super(key: key);

  @override
  State<show_complaint> createState() => _show_complaintState(this.str);
}

class _show_complaintState extends State<show_complaint> {
  final user=FirebaseAuth.instance.currentUser;
  _show_complaintState(this.status){}
bool _loading=true;
  String status;
  List record=[];
  fetchdata()async{
    List newdata=[];
    //String emailvalue='${user?.email!}';
    //emailvalue=emailvalue+" ";
    final result=await FirebaseFirestore.instance.collection("complaint").where("email",isEqualTo: user?.email).where("status", isEqualTo: status).get();
    result.docs.forEach((element) {
      print(element.data());
      newdata.add(element.data());
      if(newdata.isEmpty){
        _loading=true;
      }
      else{
        if(mounted){
          setState(() {
            record=newdata;
            first=false;

          });
        }
      }

    }
    );

  }
  bool first=true;
  @override
  Widget build(BuildContext context) {
    if(first){
      fetchdata();
    }
    return Scaffold(appBar: AppBar(
      title: Text("Show_Details"),centerTitle: true, backgroundColor: Color(0xff1E1967),
    ),
    body: ListView.builder(itemCount: record.length,itemBuilder: (context, index){
      return Column(
        //crossAxisAlignment: CrossAxisAlignment.stretch,
        // add this
        children: <Widget>[
         Padding(padding: EdgeInsets.all(10),
         child:  Container(

           decoration: BoxDecoration(
             color: Colors.white,
             border: Border.all(color: Colors.white),
             borderRadius: BorderRadius.circular(20),
             boxShadow: [
               BoxShadow(
                 color: Color(0xff1E1967),
                 offset: Offset(1,2),
                 blurRadius: 1,
               )
             ],

           ),

           height: 250,
           child: Row(
             crossAxisAlignment: CrossAxisAlignment.start,
             mainAxisAlignment:MainAxisAlignment.start,
             children: [

               Container(
                 height: 100,width: 100,
                 child: ClipOval(child: Image.network(record[index]["std-image"])),
               ),

               SizedBox(
                 width: 200,
                 child: Column(
                   children: [

                     Text(
                       '${record[index]["type"]}',

                       style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                     ),
                     SizedBox(height: 10,),
                     Text(
                       'Complaint:   \n ${record[index]["complaint"]}',

                       style: TextStyle(fontSize: 12),
                     ),

                   ],
                 ),

               ),
               if(record[index]["status"]=="pending")
                 Text(
                   '${record[index]["status"]}',

                   style: TextStyle(
                       fontSize: 12,

                       color: Colors.amber),
                 )
               else  if(record[index]["status"]=="approved")
                 Text(
                   '${record[index]["status"]}',

                   style: TextStyle(
                       fontSize: 10,

                       color: Colors.blue),
                 ) else  if(record[index]["status"]=="rejected")
                   Text(
                     '${record[index]["status"]}',

                     style: TextStyle(
                         fontSize: 12,

                         color: Colors.red),
                   ),

             ],

           ),


           //color: Colors.white60
         ),
         ),






        ],
      );

    }
    ));

  }

}

