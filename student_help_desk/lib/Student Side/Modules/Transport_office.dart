import 'dart:async';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'bottom_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Transport_Office extends StatefulWidget {
  @override
  _Transport_OfficeState createState() => _Transport_OfficeState();
}

class _Transport_OfficeState extends State<Transport_Office> {
  bool first=true;
  bool _loading=false;
  bool uploaded=false;
  final  user=FirebaseAuth.instance.currentUser;

  List currentuser=[];


  void initstate(){
    super.dispose();
  }
  void fetchuser( Function abc) async{
    List users=[];
    //String emailvalue='${user?.email!}';
    //emailvalue=emailvalue+" ";
    var firebaseUser =  FirebaseAuth.instance.currentUser;
    dynamic usr=await FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: user?.email)
        .get()
        .then((value) {
      value.docs.forEach((result) {
        print(result.data());
        users.add(result.data());
        currentuser=users;

      });
    });
    first=false;
    abc();
  }
  File? pickedImage;

  String? value;

  int _value = 0;
  late String complaints;
  late String route;
  final GlobalKey<FormState> _form= GlobalKey<FormState>();
  TextEditingController complaint_controller = new TextEditingController();
  TextEditingController route_controller=new TextEditingController();
  TextEditingController pic_controller = new TextEditingController();

  String? imageUrl;
  Future<void> imageUpload() async {

    try {
      if (pickedImage != null) {
        print('Im in imageupload');

        final ref = FirebaseStorage.instance
            .ref()
            .child('complaint')
            .child(DateTime.now().toString()+'.jpg');//yahn py mana image ko name diya khud like title wala name
        await ref
            .putFile(pickedImage!)
            .whenComplete(() => print('Image is successfully uploaded'));//or pickedImage ma mari image hy  jo upload ho rahi hy
        imageUrl = await ref.getDownloadURL();//yahn sy imageUrl ma link ly raha hn image ka
  print(imageUrl);


      }



    } catch (error) {
      throw error;
    }

    // throw error;
  }


 Future< void> upload()async {
    if(pickedImage==null){
      print("image is not selected"); return;
    }
    await imageUpload();
    String? uid;
    DocumentReference dc=FirebaseFirestore.instance.collection("complaint").doc(uid);
    Map<String,dynamic> user={
      "complaint": complaints,
      "picture": imageUrl,
      "route no": route,
      "type":"transport",
      "status":"pending",
      "student_name":currentuser[0]['name'],
      "student_reg":currentuser[0]['registration_no'],
      "email":currentuser[0]['email'],
      "std-image":currentuser[0]['image'],
    };
    dc.set(user).whenComplete((){
      print("$user created");
      route_controller.clear();
      complaint_controller.clear();

      setState(() {
        _loading=false;

      });

    });
  }

  void _showChoiceDialogue() {
    showDialog(context: context, builder: (BuildContext context) {
      return AlertDialog(title: const Text('Choose Option',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              InkWell(
                onTap: () {
                  pickImage(ImageSource.camera);
                },
                child: Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(2.0),
                      child: Icon(
                        Icons.camera,
                        color: Colors.blueGrey,
                      ),
                    ),
                    Text('Camera',
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  pickImage(ImageSource.gallery);
                },
                child: Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(2.0),
                      child: Icon(
                        Icons.image,
                        color: Colors.blueGrey,
                      ),
                    ),
                    Text('Gallery',
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  pickImage(ImageSource imageType) async {
    try {
      final photo = await ImagePicker().pickImage(source: imageType);
      if (photo == null) return;
      final tempImage = File(photo.path);
      setState(() {
        pickedImage = tempImage;
      });

      Get.back();
    } catch (error) {
      debugPrint(error.toString());
    }
  }


  @override
  Widget build(BuildContext context) {
    if(first){
      fetchuser((){setState(() {

      });});

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
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          },
        ),
          centerTitle: true,
          title: Text(
            'Transport Office',
            style: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
              fontFamily: "Lobster",
            ),
          ),
          elevation: 0.0,
      ),
      body: Form(
        key: _form,
        child: Column(
          children: <Widget>[
            Container(
              height: 30.0,
              color: Color(0xff1E1967),
            ),
            Expanded (
              child: Container(
                //height: 500.0,
                decoration: BoxDecoration(
                  color: Color(0xffDFDDDD),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50.0),
                    topRight: Radius.circular(50.0),
                  ),
                ),
                child: ListView(
                    children: <Widget>[
                      Column(
                  children: [
                    Padding(
                      padding:  EdgeInsets.only(top: 10.0),
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
                                  Image.asset("images/Transport.png",height: 80,width: 80,),
                                  SizedBox(height: 3,),
                                  Text('Transport',textAlign: TextAlign.center,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding:  EdgeInsets.only(top: 10.0,left: 15.0,),
                          child: Text(
                            'Add Complaint:',
                            style: TextStyle(
                              fontSize: 25.0,
                              color: Color(0xff1E1967),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5.0,left: 10.0, right: 10.0,),
                      child: TextFormField(
                        maxLength: 1000,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(1),
                          ),
                          hintText: 'Write your text here!!!',
                        ),
                        maxLines: 10,
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Enter your complaint';
                          }
                        },
                        onChanged: (String com){
                          getcomplaint(com);
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding:  EdgeInsets.only(top: 10.0,left: 15.0,),
                          child: Text(
                            'Route NO:',
                            style: TextStyle(
                              fontSize: 25.0,
                              color: Color(0xff1E1967),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5.0,left: 10.0, right: 120.0,),
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
                        controller: route_controller,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(1),
                          ),
                          hintText: 'Write your Route NO:',
                        ),
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Enter your route no.';
                          }
                        },
                        onChanged: (String route){
                          getroute(route);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ElevatedButton.icon(
                            onPressed: _showChoiceDialogue,
                            style: ElevatedButton.styleFrom(
                                fixedSize: Size(210, 50),
                                primary: Color(0xff1E1967),
                                textStyle:
                                const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white,)),
                            icon: const Icon(Icons.add_a_photo_sharp), label:  const Text('UPLOAD IMAGE',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: ClipRRect(
                            child: pickedImage != null
                                ? Image.file(
                              pickedImage!,
                              width: 300,
                              height: 300,
                              fit: BoxFit.cover,
                            )
                                : Text("No Image Selected"),
                          ),
                        ),
                      ],
                    ),
                    if (pickedImage != null)

                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(65),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xff1E1967),
                            minimumSize: Size.fromHeight(45),
                            //shape: StadiumBorder(),
                          ),
                          onPressed: () async{

                            uploaded = true;
                            //uploaded = true;
                            if (_loading) return;
                            setState(() {
                              _loading = true;
                            });
                            await upload();

                            pic_controller.clear();



                          },
                          child: _loading == true
                              ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 25,
                                width: 25,
                                child: const CircularProgressIndicator(
                                  strokeWidth: 3,
                                  backgroundColor:
                                  Color.fromARGB(255, 247, 121, 3),
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.blue),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                "Please wait...",
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          )
                              : uploaded == true
                              ? Text(
                            'Submitted',
                            style: TextStyle(fontSize: 20),
                          )
                              : Text(
                            'Submit',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),

                      ),
                  ],
                ),
        ],
              ),
            ),
            ),
          ],
        ),
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
            color: Colors.grey
             ,
          ),
        ),
      ),
      alertAnimation: fadeAlertAnimation,
      context: context,
      title: "Succeed",
      desc: "Your message has successfully sent.",
      image: Image.asset("assets/success.png"),
    ).show();
  }
  getcomplaint(String com) {
    this.complaints=com;
  }
  getroute(String route){
    this.route=route;
  }
}
