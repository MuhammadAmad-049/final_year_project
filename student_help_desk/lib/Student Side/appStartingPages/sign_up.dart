import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'login.dart';
class StudentSign_up extends StatelessWidget {
   StudentSign_up({Key? key}) : super(key: key);

  final _formkey= GlobalKey<FormState>();
  TextEditingController name_controller=TextEditingController();
  TextEditingController email_controller=TextEditingController();
  TextEditingController reg_controller=TextEditingController();
  TextEditingController pass_controller=TextEditingController();

  Future _sigup() async{
    try{

      final currentuser= await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email_controller.text.trim(),
        password:pass_controller.text.trim(),


      );

    }
    on FirebaseAuthException catch(e){
      print(e);
    }

  }

  Future _register() async {
    DocumentReference dc= await FirebaseFirestore.instance.collection("users").doc(reg_controller.text);
    Map<String, dynamic> users={
      "name":name_controller.text,
      "email":email_controller.text,
      "registration_no":reg_controller.text,
      "photo_status": false,

    };
    dc.set(users).whenComplete(() {
      print("${reg_controller.text} Registered");

    });
  }

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
          child: ListView(
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
                                  //filled: true,
                                  hintText: "Name",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter name';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              controller: email_controller,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                  fillColor: Colors.grey.shade100,
                                  //filled: true,
                                  hintText: "E-mail Address",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                RegExp regex =
                                RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                                if (value!.isEmpty) {
                                  return 'Enter Email.';
                                } else {
                                  if (!regex.hasMatch(value)) {
                                    return 'Enter valid Email';
                                  } else {
                                    return null;
                                  }
                                }
                              },

                            ),
                            SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              controller: reg_controller,
                              style: TextStyle(color: Colors.black),

                              decoration: InputDecoration(

                                  fillColor: Colors.grey.shade100,
                                  //filled: true,
                                  hintText: "FA00-AAA-000",
                                  border: OutlineInputBorder(

                                    borderRadius: BorderRadius.circular(10),
                                  )),
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                RegExp regex =
                                RegExp(r"^(FA|SP)[0-9][0-9]-(BCS|MCS|BSE|BBA)-[0-9][0-9][0-9]$");
                                if (value!.isEmpty) {
                                  return 'Please Registration no.';
                                } else {
                                  if (!regex.hasMatch(value)) {
                                    return 'Enter valid Registration no.';
                                  } else {
                                    return null;
                                  }
                                }
                              },
                              // validator: (value){
                              //   RegExp regex =
                              //   RegExp(r"^(FA|SP)[0-9][0-9]-(BCS|MCS|BSE)-[0-9][0-9][0-9]$");
                              //   if (value!.isEmpty) {
                              //     return 'Please Registration no.';
                              //   } else {
                              //     if (!regex.hasMatch(value)) {
                              //       return 'Enter valid Registration no.';
                              //     } else {
                              //       return null;
                              //     }
                              //   }
                              // },

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
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter password';
                                }
                                return null;
                              },
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
                                        if(_formkey.currentState!.validate()){
                                           _sigup();
                                           _register();

                                          Navigator.push(context, MaterialPageRoute(builder: (c)=>StudentLogin()));

                                        }


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
                                          builder: (context) =>  StudentLogin()),
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
      ),
    );
  }


}



