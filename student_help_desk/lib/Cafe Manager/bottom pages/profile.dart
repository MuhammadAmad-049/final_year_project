import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fyp/Account%20Manager/Starting%20pages/AM_login.dart';
import 'package:fyp/Contect_us.dart';
import 'package:fyp/DOO%20Side/Starting%20pages/doo_login.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:image_picker/image_picker.dart';
import '../../Select Side Page.dart';
import '../Starting pages/CM_login.dart';
import 'package:email_validator/email_validator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class MenuItems{
  static const List<MenuItem> items =[
    itemContect,
    itemSignOut,
    itemChoosePage,
  ];
  static const itemContect = MenuItem(
    text: 'update',
  );
  static const itemSignOut = MenuItem(
    text: 'Sign Out ',
  );
  static const itemChoosePage = MenuItem(
    text: 'Select Side Page ',
  );
}

class CM_Profile extends StatefulWidget {
  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<CM_Profile> {
  void dispose(){
    super.dispose();
    email.dispose();
    password.dispose();
    contact.dispose();
    name.dispose();
  }
  List admin=[];
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
  TextEditingController name=TextEditingController();
  TextEditingController contact=TextEditingController();
  final GlobalKey<FormState> _formkey= GlobalKey<FormState>();
  void initState(){
    super.initState();
    //fetch();
  }
  String? imageUrl;
  List record=[];
  Future<bool> fetch()async{
    List admin=[];
    await FirebaseFirestore.instance.collection("admin").where("type", isEqualTo: "cm").get().then((querysnapshot) {
      querysnapshot.docs.forEach((element) {
        print(element.data());

        admin.add(element.data());
        if(admin.isNotEmpty){
          //loading=false;
          record=admin;
        }
        else{
          if(mounted){
            //loading=true;
            setState(() {

            });
          }
        }
      });
    });
    return true;
  }
  update() async{
    List admindata=[];
    await FirebaseFirestore.instance.collection("admin").where("type", isEqualTo: "cm").get().then((querysnapshot) {
      querysnapshot.docs.forEach((element) {
        print(element.data());
        admindata.add(element.data());
        if(admindata.isNotEmpty){
          loading=false;
          admin=admindata;
        }
        else{
          if(mounted){
            loading=true;
            setState(() {

            });
          }
        }
      });
    });
    String type=admindata[0]["type"];
    await FirebaseFirestore.instance.collection("admin").doc(type).update({
      "name": name.text,
      "email":email.text,
      "password":password.text,
      "contact":contact.text,

    }).then((value){
      name.clear();
      email.clear();
      password.clear();
      contact.clear();
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Successfully updated'),
          )
      );
    });
  }
  Future<void> imageUpload() async {
    //String emailvalue='${user?.email!}';
    //emailvalue=emailvalue+" ";
    try {
      if (pickedImage != null) {
        print('Im in imageupload');

        final ref = FirebaseStorage.instance
            .ref()
            .child('admin_profile')
            .child(DateTime.now().toString()+'.jpg');
        await ref
            .putFile(pickedImage!)
            .whenComplete(() => print('Image is successfully uploaded'));
        imageUrl = await ref.getDownloadURL();
        print(imageUrl);
        List userdata=[];
        await FirebaseFirestore.instance.collection("admin").where("type", isEqualTo: "cm").get().then((querysnapshot) {
          querysnapshot.docs.forEach((element) {
            print(element.data());
            userdata.add(element.data());
          });
        });
        String type=userdata[0]["type"];
        FirebaseFirestore.instance
            .collection("admin")
            .doc(type).set({
          "name":userdata[0]["name"],
          "email":userdata[0]["email"],
          "password": userdata[0]["password"],
          "contact": userdata[0]["contact"],
          "type": userdata[0]["type"],
          "image": imageUrl,
          "photo_status": true,

        }).then((_) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Successfully update image'),
              ));
        });

      }
    } catch (error) {
      throw error;
    }

    // throw error;
  }

  bool loading=true;
  File? pickedImage;
  //int _currentIndex = 1;

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
              ElevatedButton(onPressed: () {
                imageUpload();

                Navigator.of(context).pop();
              }, child: Text("Upload Image")),
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
    return FutureBuilder(future: fetch(),builder: ((context, snapshot) {
      if(snapshot.hasData){
        return  Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0.0,
            backgroundColor: Color(0xff1E1967),
            actions: <Widget>[
              PopupMenuButton<MenuItem>(
                  onSelected: (item) => onSelected(context, item),
                  itemBuilder: (context) => [
                    ...MenuItems.items.map(buildItem).toList(),
                  ]
              )
            ],
          ),
          body: Stack(
            alignment: Alignment.center,
            children: [
              CustomPaint(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                ),
                painter: HeaderCurvedContainer(),
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      "Profile",
                      style: TextStyle(
                        fontSize: 35,
                        letterSpacing: 1.5,
                        color: Color(0xffDFDDDD),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  record[0]["photo_status"]==true? Container(
                    padding: EdgeInsets.all(10.0),
                    width: 210,
                    height: 210,
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffDFDDDD), width: 2),
                      shape: BoxShape.circle,
                      color: Color(0xffDFDDDD),
                    ),
                    child: ClipOval(
                      child: pickedImage != null
                          ? Image.file(
                        pickedImage!,
                        width: 170,
                        height: 170,
                        fit: BoxFit.cover,
                      )
                          : Image.network(record[0]["image"]),
                    ),
                  ):
                  Container(
                    padding: EdgeInsets.all(10.0),
                    width: 210,
                    height: 210,
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffDFDDDD), width: 2),
                      shape: BoxShape.circle,
                      color: Color(0xffDFDDDD),
                    ),
                    child: ClipOval(
                      child: pickedImage != null
                          ? Image.file(
                        pickedImage!,
                        width: 170,
                        height: 170,
                        fit: BoxFit.cover,
                      )
                          : Image.asset("images/Man-profile.jpeg"),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 150, left: 164),
                child: CircleAvatar(
                  radius: 24,
                  backgroundColor: Color(0xff1E1967),
                  child: IconButton(
                    icon: Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed:_showChoiceDialogue,
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 325.0,bottom: 10,),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Name:',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      Container(
                          width: 350,
                          height: 40,
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                    color: Colors.grey,
                                    width: 1,
                                  ))),
                          child: Row(children: [
                            Expanded(
                                child: TextButton(
                                    onPressed: () {
                                    },
                                    child: Center(
                                      child: Text('${record[0]["name"]}',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ))),
                          ])),
                    ],
                  )),
              Padding(
                  padding: EdgeInsets.only(top: 425.0,bottom: 10,),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'E-mail Address:',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      Container(
                          width: 350,
                          height: 40,
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                    color: Colors.grey,
                                    width: 1,
                                  ))),
                          child: Row(children: [
                            Expanded(
                                child: TextButton(
                                    onPressed: () {
                                    },
                                    child: Center(
                                      child: Text('${record[0]["email"]}',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ))),
                          ])),
                    ],
                  )),
            ],
          ),
        );
      }
      else {
        return Center(child: CircularProgressIndicator(),);
      }
    })
    );
  }

  void onSelected(BuildContext context, MenuItem item) {
    switch (item) {
      case MenuItems.itemContect:
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Stack(
                  overflow: Overflow.visible,
                  children: <Widget>[
                    Positioned(
                      right: -40.0,
                      top: -40.0,
                      child: InkResponse(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: const CircleAvatar(
                          child: Icon(Icons.close),
                          backgroundColor: Colors.red,
                        ),
                      ),
                    ),
                    Form(
                      key: _formkey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: TextFormField(
                              controller: name,
                              decoration: const InputDecoration(
                                labelText: 'Your Name',
                                // icon: Icon(Icons.person),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter Name';
                                }
                                return null;
                              },

                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: TextFormField(
                              controller: contact,
                              decoration: const InputDecoration(
                                labelText: 'Contact',
                                hintText: 'Enter number without 0',
                                // icon: Icon(Icons.phone),
                              ),
                              autovalidateMode: AutovalidateMode
                                  .onUserInteraction,
                              validator: (value) {
                                String pattern =
                                    r'(^(?:[+0]9)?[0-9]{10}$)';
                                RegExp regExp = RegExp(pattern);
                                if (value!.isEmpty) {
                                  return 'Please enter mobile number';
                                } else if (!regExp
                                    .hasMatch(value)) {
                                  return 'Please enter valid mobile number';
                                }
                                return null;
                              },

                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: TextFormField(
                                controller: email,
                                decoration: const InputDecoration(
                                  labelText: 'Enter email',
                                  // icon: Icon(Icons.message_outlined),
                                ),
                                validator: (email){
                                  email !=null && EmailValidator.validate(email)
                                      ?'Enter valid email'
                                      : null;
                                }
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: TextFormField(
                                controller: password,
                                decoration: const InputDecoration(
                                  labelText: 'Enter password',
                                  // icon: Icon(Icons.message_outlined),
                                ),
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                validator: (value){
                                  value!=null && value.length>6
                                      ? 'Enter atleast 6 charcter'
                                      : null;
                                }

                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                RaisedButton(
                                    color: Colors.red,
                                    child: const Text(
                                      "Cancel",
                                      style: TextStyle(
                                          color: Colors.white),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    }),
                                const Spacer(),
                                RaisedButton(
                                  child: const Text(
                                    "update ",
                                    style: TextStyle(
                                        color: Colors.white),
                                  ),
                                  color: const Color(0xff1E1967),
                                  onPressed: () {
                                    if (_formkey.currentState!
                                        .validate()) {
                                      update();

                                    }

                                  },
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            });

        break;
    }
    switch (item) {
      case MenuItems.itemSignOut:
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>  DOO_Login("cm")),
      );
        break;
    }
    switch (item) {
      case MenuItems.itemChoosePage:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>  SelectSide()),
        );
        break;
    }
  }
}
PopupMenuItem<MenuItem> buildItem(MenuItem item) => PopupMenuItem<MenuItem>(
  value: item,
  child: Text(item.text),
);

class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Color(0xff1E1967);
    Path path = Path()
      ..relativeLineTo(0, 150)
      ..quadraticBezierTo(size.width / 2, 225, size.width, 150)
      ..relativeLineTo(0, -150)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
class MenuItem {
  final String text;

  const MenuItem({
    required this.text,
  });
}
