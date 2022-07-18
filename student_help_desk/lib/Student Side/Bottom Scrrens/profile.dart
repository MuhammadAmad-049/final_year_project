import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fyp/Student%20Side/appStartingPages/login.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:image_picker/image_picker.dart';
import '../../Select Side Page.dart';
import '../../Contect_us.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
class MenuItems{
  static const List<MenuItem> items =[
    itemContect,
    itemSignOut,
    itemChoosePage,
  ];
  static const itemContect = MenuItem(
    text: 'Contect Us',
  );
  static const itemSignOut = MenuItem(
    text: 'Sign Out ',
  );
  static const itemChoosePage = MenuItem(
    text: 'Select Side Page ',
  );
}

class ProfilePage extends StatefulWidget {


  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  final  user=FirebaseAuth.instance.currentUser;

  List currentuser=[];

bool upload=false;
 @override
  void initState() {
    
    super.initState();
  }

  void fetchuser( Function abc) async{
    // upload=true;
List users=[];
String emailvalue='${user?.email!}';
// emailvalue=emailvalue+" ";
    //var firebaseUser =  FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: user?.email)
        .get()
        .then((value) {
      value.docs.forEach((result) {
        print(result.data());
        users.add(result.data());
        currentuser=users;

          first=false;

      });
    });

 if(mounted){
  abc();
 }
  
  }

  File? pickedImage;
 //int _currentIndex = 1;
  String? imageUrl;

  Future<void> imageUpload() async {
    String emailvalue='${user?.email!}';
    //emailvalue=emailvalue+" ";
    try {
      if (pickedImage != null) {
        print('Im in imageupload');

        final ref = FirebaseStorage.instance
            .ref()
            .child('image')
            .child(DateTime.now().toString()+'.jpg');
        await ref
            .putFile(pickedImage!)
            .whenComplete(() => print('Image is successfully uploaded'));
        imageUrl = await ref.getDownloadURL();
        print(imageUrl);
        List userdata=[];
        await FirebaseFirestore.instance.collection("users").where("email", isEqualTo: emailvalue).get().then((querysnapshot) {
        querysnapshot.docs.forEach((element) { 
          print(element.data());
          userdata.add(element.data());
        });  
        });
        String reg=userdata[0]["registration_no"];
          FirebaseFirestore.instance
              .collection("users")
              .doc(reg).set({
            "name":userdata[0]["name"],
            "email":userdata[0]["email"],
            "registration_no":userdata[0]["registration_no"],
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
bool first=true;
  @override
  Widget build(BuildContext context) {
    if(first){
      fetchuser((){setState(() {

      });});

    }
      return first ? Center(child: CircularProgressIndicator(),)
      : Scaffold(
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
                currentuser[0]["photo_status"]==true
                    ?Container(
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
                      // width: 170,
                      // height: 170,
                      fit: BoxFit.cover,
                    )
                        : Image.network(currentuser[0]["image"]),
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
                        : Image.asset('images/female-profile.jpg'),
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
                      'Name:    ${currentuser[0]['name']}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff1E1967),
                      ),
                    ),

                  ],
                )),
            Padding(
                padding: EdgeInsets.only(top: 425.0,bottom: 10,),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'E-mail: ${user?.email}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff1E1967),
                      ),
                    ),
                  ],
                )),
            Padding(
                padding: EdgeInsets.only(top: 525.0,bottom: 10,),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(
                      'Registration:    ${currentuser[0]['registration_no']}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff1E1967),
                      ),
                    ),

                  ],
                )),
          ],
        ),
      );
  }

  void onSelected(BuildContext context, MenuItem item) {
    switch (item) {
      case MenuItems.itemContect:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>  ContectUs()),
        );
        break;
    }
    switch (item) {
      case MenuItems.itemSignOut:
        FirebaseAuth.instance.signOut();
        Navigator.push(context, MaterialPageRoute(builder: (c)=>StudentLogin()));

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


