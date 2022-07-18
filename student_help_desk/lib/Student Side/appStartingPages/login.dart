
import 'package:flutter/material.dart';
import 'package:fyp/Student%20Side/Modules/bottom_page.dart';
import 'package:fyp/Student%20Side/appStartingPages/verifyEmail.dart';
import '../Bottom Scrrens/home.dart';
import 'ResetPassword.dart';
import 'sign_up.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StudentLogin extends StatefulWidget {
  StudentLogin({Key? key}) : super(key: key);

  @override
  State<StudentLogin> createState() => _StudentLoginState();
}

class _StudentLoginState extends State<StudentLogin> {
  @override
  final TextEditingController Reg_controller=TextEditingController();

  final TextEditingController email_controller=TextEditingController();

  final TextEditingController pass_controller=TextEditingController();
  final navigatorkey = GlobalKey<NavigatorState>();
  final _key = GlobalKey<FormState>();

  List users=[];

  var useremail;

  // void _onPressed() {
  late String emailaddress;

  Future _signIn() async{
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ));
    await FirebaseFirestore
        .instance
        .collection("users")

        .where("registration_no", isEqualTo: Reg_controller.text)
        .get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        //print(result.data());
        users.add(result.data());
       emailaddress= users[0]["email"];
      });

    });


    try{

      FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailaddress, password: pass_controller.text.trim());
      Navigator.push(
          context, MaterialPageRoute(builder: (context) =>  MyApp()));
    } on FirebaseAuthException catch(e) {

    }
    navigatorkey.currentState?.popUntil((route) => route.isFirst);



  }

Future Login() async {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ));
  try{

    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailaddress, password: pass_controller.text.trim());
  } on FirebaseAuthException catch(e) {

  }
  }

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
                  return VerifyEmail();
                }
                else{
                  return Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 35, top: 300),
                        child: Text(
                          'Welcome',
                          style: TextStyle(
                            color: Color(0xff1E1967),
                            fontSize: 33,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Form(
                        key: _key,
                        child: SingleChildScrollView(
                          child: Container(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.51),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 35, right: 35),
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        controller: Reg_controller,
                                        style: TextStyle(color: Colors.black),
                                        decoration: InputDecoration(
                                            fillColor: Colors.grey.shade100,
                                            filled: true,
                                            hintText: "Registration Number",
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
                                            'Log in',
                                            style: TextStyle(
                                                fontSize: 27, fontWeight: FontWeight.w700),
                                          ),
                                          CircleAvatar(
                                            radius: 30,
                                            backgroundColor: Color(0xff1E1967),
                                            child: IconButton(
                                                color: Colors.white,
                                                onPressed: () async{
                                                  if(_key.currentState!.validate()){
                                                    _signIn();

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
                                                    builder: (context) =>  StudentSign_up()),
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
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                    builder: (context) =>  ResetPassword()));
                                              },
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
                      ),
                    ],
                  );
                }
              })
      ),
    );
  }
}

