import 'package:flutter/material.dart';
import 'package:fyp/Cafe%20Manager/Starting%20pages/CM_sign_up.dart';
import 'package:fyp/Cafe%20Manager/bottom%20pages/bottom%20page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../home_page.dart';

class CM_Login extends StatefulWidget {
  CM_Login({Key? key}) : super(key: key);

  @override
  _CM_LoginState createState() => _CM_LoginState();
}
class _CM_LoginState extends State<CM_Login> {


  TextEditingController email_controller=TextEditingController();
  TextEditingController pass_controller=TextEditingController();
  void initstate(){
    super.dispose();

  }
  List users=[];
  var useremail;
  // void _onPressed() {
  //   FirebaseFirestore.instance.collection("admin").get().then((querySnapshot) {
  //     querySnapshot.docs.forEach((result) {
  //       print(result.data());

  //     });
  //   });
  // }
  // void _signIn() async{
  //   await FirebaseFirestore
  //       .instance
  //       .collection("admin")

  //       .where("email", isEqualTo: email_controller.text)
  //       .get().then((querySnapshot) {
  //     querySnapshot.docs.forEach((result) {
  //       print(result.data());
  //       users.add(result.data());
  //     });
  //   });
  //   {
  //     FirebaseAuth.instance.signInWithEmailAndPassword(
  //         email: users[1]["email"], password: pass_controller.text);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/Login.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
    body: StreamBuilder(
    stream:FirebaseAuth.instance.authStateChanges(),
    builder: (context, snapshot){
    if(snapshot.hasData){
    return CM_Home();
    }
    else {
      return Stack(
        children: [
          Container(
            padding: EdgeInsets.only(left: 35, top: 300),
            child: Text(
              'Welcome!!!',
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
                  top: MediaQuery
                      .of(context)
                      .size
                      .height * 0.51),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 35, right: 35),
                    child: Column(
                      children: [
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
                              'Log in',
                              style: TextStyle(
                                  fontSize: 27, fontWeight: FontWeight.w700),
                            ),
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: Color(0xff1E1967),
                              child: IconButton(
                                  color: Colors.white,
                                  onPressed: () {
                                    CM_Home();
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
                                      builder: (context) => CM_Sign_up()),
                                );
                              },
                              child: Text(
                                'Sign Up',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Color(0xff4c505b),
                                    fontSize: 18),
                              ),
                              style: ButtonStyle(),
                            ),
                            TextButton(
                                onPressed: () {},
                                child: Text(
                                  'Forgot Password',
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Color(0xff4c505b),
                                    fontSize: 18,
                                  ),
                                )),
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
      );
    }
    }),

      ),
    );
  }
}
