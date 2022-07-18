import 'package:flutter/material.dart';
import 'package:fyp/registrstion_side/Bottom%20Pages/bottom_page.dart';

import '../../Account Manager/bottom pages/bottom page.dart';
import '../../Cafe Manager/bottom pages/bottom page.dart';
import '../../HOD Side/Bottom Pages/bottom-page.dart';
import '../../Transport Manager/bottom pages/bottom page.dart';
import '../Bottom Pages/bottom_page.dart';
import 'doo_sign_up.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DOO_Login extends StatefulWidget {
  String value;
  DOO_Login(this.value,{Key? key}) : super(key: key);

  @override
  _DOO_LoginState createState() => _DOO_LoginState(this.value);
}
class _DOO_LoginState extends State<DOO_Login> {
  _DOO_LoginState(this.type){}

  late String type;
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
  final GlobalKey<FormState> _form= GlobalKey<FormState>();
  final navigatorkey = GlobalKey<NavigatorState>();



  List admin=[];
  Future<void > login()async{
    await FirebaseFirestore.instance.collection("admin").where("type",isEqualTo: type).get().then((value) {
      value.docs.forEach((element) {
        admin.add(element.data());
      });
    });
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
        body: Form(
          key: _form,
          child: Stack(
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
                      top: MediaQuery.of(context).size.height * 0.51),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 35, right: 35),
                        child: Column(
                          children: [
                            TextFormField(
                              controller: email,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                  fillColor: Colors.grey.shade100,
                                  filled: true,
                                  hintText: "E-mail Address",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                              validator: (value){
                                if(value!.isEmpty){
                                  return 'Enter email';
                                }
                              },
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              controller: password,
                              style: TextStyle(),
                              obscureText: true,
                              decoration: InputDecoration(
                                  fillColor: Colors.grey.shade100,
                                  filled: true,
                                  hintText: "Password",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                              validator: (value){
                                if(value!.isEmpty){
                                  return 'Enter password';
                                }
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
                                      onPressed: () async {
                                        await login();

                                        if(_form.currentState!.validate()){

                                          if(admin[0]["email"]==email.text.trim() && admin[0]["password"]==password.text.trim() ){

                                            if(admin[0]["type"]=="doo"){
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>  DOOHomePage()),
                                              );
                                            }
                                            else if(admin[0]["type"]=="tm"){
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>  TM_Home()),
                                              );
                                            }
                                            else if(admin[0]["type"]=="am"){
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>   AM_Home()),
                                              );
                                            }
                                            else if(admin[0]["type"]=="cm"){
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>  CM_Home()),
                                              );
                                            }
                                            else if(admin[0]["type"]=="hod"){
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>  HODHomePage()),
                                              );
                                            }
                                            else if(admin[0]["type"]=="rm"){
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>  RM_Home()),
                                              );
                                            }
                                          }
                                          //navigatorkey.currentState?.popUntil((route) => route.isFirst);

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
