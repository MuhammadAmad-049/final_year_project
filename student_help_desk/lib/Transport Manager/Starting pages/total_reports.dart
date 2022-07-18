import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class Tm_total_reports extends StatefulWidget {
  const Tm_total_reports({Key? key}) : super(key: key);

  @override
  State<Tm_total_reports> createState() => _total_reportsState();
}

class _total_reportsState extends State<Tm_total_reports> {
  List T_complaints=[];
  List<String> complaintkey=[];
  void _delete(String complaint_key){
    FirebaseFirestore.instance.collection("complaint").doc(complaint_key).delete().then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Successfully deleted'),
          )
      );
    }).catchError((error)=> print("Delete failed $error"));
  }
  fetchcomplaint() {
    List listofcomplaint=[];
    FirebaseFirestore
        .instance
        .collection("complaint")
        .where("type", isEqualTo: "transport")

        .get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        listofcomplaint.add(result);
        complaintkey.add(result.id);
        print(result.data());
        if(mounted){
          setState(() {
            T_complaints=listofcomplaint;
          });
          loading=false;data=false;

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
      appBar: AppBar( backgroundColor: Color(0xff1E1967),title: Text("Total Reports"),centerTitle: true,),
      body: loading? Center(child: CircularProgressIndicator(strokeWidth: 3,backgroundColor: Colors.amber, color: Colors.black,),)
          :Column(
          children: <Widget>[
            Expanded(
                child: Container(
                    color: Colors.white,
                    child: ListView.builder(physics: ClampingScrollPhysics(),shrinkWrap: true,itemCount: T_complaints.length ,itemBuilder: (context, index){
                      return Container(
                        height: 250,
                        margin:  EdgeInsets.all(10.0),
                        child: Card(
                          color: Colors.white,
                          shape:  RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                          child: InkWell(
                            onTap: () {

                            },
                            child: Column(

                              children: <Widget>[
                                Row(
                                  children: [
                                    Container(
                                      height: 100,width: 100,
                                      child: ClipOval(child: Image.network(T_complaints[index]["std-image"])),
                                    ),
                                    SizedBox(
                                      width: 200,
                                      child: Column(
                                        children: [
                                          Text(
                                            'Module:  ${T_complaints[index]["type"]}',
                                            softWrap: false,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(height: 5,),
                                          Text(
                                            'Student_Name:  ${T_complaints[index]["student_name"]}',
                                            softWrap: false,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(height: 5,),

                                          Text(
                                            'Reg_No:  ${T_complaints[index]["student_reg"]}',

                                            style: TextStyle(fontSize: 12),
                                          ),
                                          SizedBox(height: 25,),


                                        ],
                                      ),
                                    ),

                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: IconButton(onPressed: () {
                                        setState(() {
                                          loading=true;
                                        });
                                        _delete(complaintkey[index]);

                                        loading==false? Center(child: CircularProgressIndicator(strokeWidth: 3,backgroundColor: Colors.amber, color: Colors.black,),) :fetchcomplaint();

                                      }, icon: Icon(Icons.delete, color: Colors.red,)),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  //width: 50,
                                  height: 100,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${T_complaints[index]['complaint']}',
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: false,
                                        maxLines: 7,

                                        style: TextStyle(fontSize: 12),
                                      ),

                                    ],
                                  ),
                                ),

                              ],
                            ),
                          ),
                          elevation: 8,
                        ),
                        color: Color(0xff1E1967), );



                    }))

            ),
          ]
      ),

    );

  }
}
