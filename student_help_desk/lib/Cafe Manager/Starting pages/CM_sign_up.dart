import 'package:flutter/material.dart';
import 'package:fyp/Cafe%20Manager/Starting%20pages/CM_login.dart';
import 'package:fyp/Cafe%20Manager/bottom%20pages/bottom%20page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class CM_Sign_up extends StatefulWidget {
  const CM_Sign_up({Key? key}) : super(key: key);

  @override
  _CM_Sign_upState createState() => _CM_Sign_upState();
}

class _CM_Sign_upState extends State<CM_Sign_up> {
  late String name;
  late String emailid,password;
  TextEditingController name_controller=TextEditingController();
  TextEditingController email_controller=TextEditingController();
  TextEditingController pass_controller=TextEditingController();


  get_name(name){
    this.name=name;
  }

  get_email(email){
    this.emailid=email;
  }

  get_password(pass){
    this.password=pass;
  }

  void initState(){
    super.initState();
   // _sigup();

  }
  // Future _sigup() async{
  //   try{
  //     // final isvalid=_formkey.currentState!.validate();
  //     // if(isvalid) return;
  //     //showDialog(context: context, builder: (context)=> Center(child: CircularProgressIndicator(),));
  //     final currentuser= await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //       email: email_controller.text,
  //       password:pass_controller.text,


  //     );

  //   }
  //   on FirebaseAuthException catch(e){
  //     print(e);
  //   }

  // }

  // // _register() async {
  //   DocumentReference dc= await FirebaseFirestore.instance.collection("admin").doc(email_controller.text);
  //   Map<String, dynamic> users={
  //     "name":name_controller.text,
  //     "email":email_controller.text,


  //   };
  //   dc.set(users).whenComplete(() {
  //     print("${email_controller.text} Registered");

  //   });
  // }
  final _formkey= GlobalKey<FormFieldState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/Sign-up.png'),),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
    body: Form(
    key: _formkey,
    child: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(left: 68, top: 50),
              child: Text(
                'Create Account',
                style: TextStyle(
                  color: Color(0xff1E1967),
                  fontSize: 33,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 35, right: 35),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: name_controller,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: "Name",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            controller: email_controller,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: "E-mail Address",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            controller: pass_controller,
                            style: TextStyle(),
                            obscureText: true,
                            decoration: InputDecoration(
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: "Password",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Sign Up',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 27,
                                    fontWeight: FontWeight.w700),
                              ),
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Color(0xff1E1967),
                                child: IconButton(
                                    color: Colors.white,

                                    onPressed: () async {
                                      // _sigup();
                                      // _register();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>  CM_Home()),
                                      );
                                    },
                                    icon: Icon(
                                      Icons.arrow_forward,
                                    )),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>  CM_Login()),
                                  );
                                },
                                child: Text(
                                  'Log In',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Colors.white,
                                      fontSize: 18),
                                ),
                                style: ButtonStyle(),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      ));
  }
}
