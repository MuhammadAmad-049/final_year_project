import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '';

class studentinfo{
  static String reg="";
  void fetchstudent(){
    FirebaseFirestore.instance.collection("users").doc().get();
  }
}

