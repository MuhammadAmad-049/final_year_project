import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Notifications/am_notifications.dart';
import 'Starting pages/accepted_reports.dart';
import 'Starting pages/rejected_reports.dart';
import 'Starting pages/total_reports.dart';

class AM_Home_Page extends StatefulWidget {
  const AM_Home_Page({Key? key}) : super(key: key);

  @override
  _AM_Home_PageState createState() => _AM_Home_PageState();
}

class _AM_Home_PageState extends State<AM_Home_Page> {
  List account_compalint=[];
  List acceptedlist=[];
  List rejectedlist=[];
  fetchcomplaint() async {
    List listofcomplaint=[];
    List listofaccept=[];
    List listofreject=[];
    FirebaseFirestore
        .instance
        .collection("complaint")
        .where("type", isEqualTo: "account")
        .get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        listofcomplaint.add(result.data());
       if(mounted) {
         setState(() {
           account_compalint = listofcomplaint;
           loading = false;
         });
       }});
    });
    await FirebaseFirestore
        .instance
        .collection("complaint")
        .where("type", isEqualTo: "account")
        .where("status", isEqualTo: "approved")
        .get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        listofaccept.add(result.data());
        if(mounted){
          setState(() {
            acceptedlist=listofaccept;
            loading=false;
          });
        }
      });
    });
    await FirebaseFirestore
        .instance
        .collection("complaint")
        .where("type", isEqualTo: "account")
        .where("status", isEqualTo: "rejected")
        .get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        listofreject.add(result.data());
        if(mounted){
          setState(() {
            rejectedlist=listofreject;
            loading=false;
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
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xff1E1967),
          centerTitle: true,
          title: Text(
            'Account',
            style: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
              fontFamily: "Lobster",
            ),
          ),
          elevation: 0.0,
          actions: <Widget>[
      Row(
      children: [
      IconButton(onPressed: (){

    showSearch(context: context, delegate:  CustomSearchDelegate(),);
    }, icon: Icon(Icons.search)),
            TextButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (c)=>AM_Notifications()));
              },
              child: Stack(children: [
                Icon(Icons.notifications_active_outlined,color: Colors.red,size: 30,),
                Align(alignment: Alignment.topRight,
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    //padding: EdgeInsets.fromLTRB(4, 0,1, 0),
                    child: Center(
                      child: Text("${account_compalint.length}",

                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,

                        ),),
                    ),
                    height: 14,
                    width: 14,
                  ),
                )
              ],),

            ),
          ]
      ),
    ]
    ),
      body: Column(
          children: <Widget>[
            Container(
              height: 30.0,
              color: Color(0xff1E1967),
            ),
            Expanded (
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xffDFDDDD),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50.0),
                    topRight: Radius.circular(50.0),
                  ),
                ),
                child: ListView(
                  children: <Widget>[
                    SizedBox(
                      height: 35.0,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Tm_total_reports()),
                            );
                          },
                            child: Container(
                              padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                              height: 120,
                              width: 100,
                              decoration:  BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.blueAccent.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: Offset(0, 3), // changes position of shadow
                                    ),
                                  ],
                                  color: Colors.white
                              ),
                              child:  Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 12.0),
                                    child: Column(
                                      children: [
                                        Text('Total Reports',textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                          ),),
                                        SizedBox(height: 10,),
                                        SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: loading ==true? Center(
                                            child: Container(
                                              child: CircularProgressIndicator(
                                                strokeWidth: 5,
                                              ),
                                            ),
                                          ):Text("${account_compalint.length}",textAlign: TextAlign.center,
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: false,
                                            maxLines: 1,
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 14,
                                            ),),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),),
                          TextButton(onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Am_accepted_reports()),
                            );
                          },
                            child: Container(
                              padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                              height: 120,
                              width: 100,
                              decoration:  BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.blueAccent.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: Offset(0, 3), // changes position of shadow
                                    ),
                                  ],
                                  color: Colors.white
                              ),
                              child:  Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 12.0),
                                    child: Column(
                                      children: [
                                        Text('Approved Reports',textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                          ),),
                                        SizedBox(height: 10,),
                                        SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: loading ==true? Center(
                                            child: Container(
                                              child: CircularProgressIndicator(
                                                strokeWidth: 5,
                                              ),
                                            ),
                                          ):Text("${acceptedlist.length}",textAlign: TextAlign.center,
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: false,
                                            maxLines: 1,
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 14,
                                            ),),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),),
                        ]
                    ),
                    SizedBox(
                      height: 35.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Tm_rejected_reports()),
                          );
                        },
                          child: Container(
                            padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                            height: 120,
                            width: 100,
                            decoration:  BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blueAccent.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                                color: Colors.white
                            ),
                            child:  Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 12.0),
                                  child: Column(
                                    children: [
                                      Text('Rejected Reports',textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                        ),),
                                      SizedBox(height: 10,),
                                      SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: loading ==true? Center(
                                          child: Container(
                                            child: CircularProgressIndicator(
                                              strokeWidth: 5,
                                            ),
                                          ),
                                        ):Text("${rejectedlist.length}",textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: false,
                                          maxLines: 1,
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 14,
                                          ),),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ]
      ),
    );
  }
}
class CustomSearchDelegate extends SearchDelegate{
  List<String> searchTerms=[];
  List searchData=[];
  CustomSearchDelegate(){
    FirebaseFirestore
        .instance
        .collection("complaint").where("type", isEqualTo: "account")
        .get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        searchTerms.add(result.data()["student_reg"]);
        print(searchTerms);
        searchData.add(result.data());
        print(searchData);
      });

    });
  }
  @override
  List<Widget> buildActions(BuildContext context){
    return [
      IconButton(onPressed: (){
        if(query.isEmpty){
          close(context, null);
        }
        else{
          query='';
          searchTerms=[];
        }
      }, icon: Icon(Icons.clear))
    ];
  }
  @override
  Widget buildLeading(BuildContext context){
    return IconButton(onPressed: (){
      close(context, null);

    }, icon: Icon(Icons.arrow_back));
  }
  @override
  Widget buildResults(BuildContext context){
    List<String> match=[];
    for(var data in searchTerms){
      if(data.toLowerCase().startsWith(query.toLowerCase())){
        match.add(data);
      }
    }
    return  ListView.builder(physics: ClampingScrollPhysics(),shrinkWrap: true,itemCount: match.length ,itemBuilder: (context, index){
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
                      child: ClipOval(child: Image.network(searchData[index]["std-image"])),
                    ),
                    SizedBox(
                      width: 200,
                      child: Column(
                        children: [
                          Text(
                            'Module:    ${searchData[index]["type"]}',
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5,),
                          Text(
                            'Student_Name:    ${searchData[index]["student_name"]}',
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5,),

                          Text(
                            'Reg_No:    ${searchData[index]["student_reg"]}',

                            style: TextStyle(fontSize: 12),
                          ),
                          SizedBox(height: 25,),


                        ],
                      ),
                    ),
                    // Align(
                    //   alignment: Alignment.topLeft,
                    //   child: IconButton(onPressed: () {
                    //     setState(() {
                    //       loading=true;
                    //     });
                    //     _delete(complaintkey[index]);
                    //
                    //     loading==false? Center(child: CircularProgressIndicator(strokeWidth: 3,backgroundColor: Colors.amber, color: Colors.black,),) :fetchcomplaint();
                    //
                    //   }, icon: Icon(Icons.delete, color: Colors.red,)),
                    // )

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
                        '${searchData[index]['complaint']}',
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



    });

  }
  @override
  Widget buildSuggestions(BuildContext context){
    List<String> match=[];
    for(var data in searchTerms){
      if(data.toLowerCase().contains(query.toLowerCase())){
        match.add(data);
      }
    }
    return  ListView.builder(physics: ClampingScrollPhysics(),shrinkWrap: true,itemCount: match.length ,itemBuilder: (context, index){
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
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => DOO_Open_Notificatons(exam_compalint[index].id, exam_compalint[index].data())),
              // );
            },
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              // add this
              children: <Widget>[
                Row(
                  children: [
                    Container(
                      height: 100,width: 100,
                      child: ClipOval(child: Image.network(searchData[index]["std-image"])),
                    ),
                    SizedBox(
                      width: 200,
                      child: Column(
                        children: [
                          Text(
                            'Module:    ${searchData[index]["type"]}',
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5,),
                          Text(
                            'Student_Name:    ${searchData[index]["student_name"]}',
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5,),

                          Text(
                            'Reg_No:    ${searchData[index]["student_reg"]}',

                            style: TextStyle(fontSize: 12),
                          ),
                          SizedBox(height: 25,),


                        ],
                      ),
                    ),
                    // Align(
                    //   alignment: Alignment.topLeft,
                    //   child: IconButton(onPressed: () {
                    //     setState(() {
                    //       loading=true;
                    //     });
                    //     _delete(complaintkey[index]);
                    //
                    //     loading==false? Center(child: CircularProgressIndicator(strokeWidth: 3,backgroundColor: Colors.amber, color: Colors.black,),) :fetchcomplaint();
                    //
                    //   }, icon: Icon(Icons.delete, color: Colors.red,)),
                    // )

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
                        '${searchData[index]['complaint']}',
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



    });

  }

}
