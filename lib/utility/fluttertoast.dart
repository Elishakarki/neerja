import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';



class Utilites {
  String emptyString = "";
    static void showInToast(String message,
      { int toastPos = 2}) {
   
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: toastPos == 2
          ? ToastGravity.BOTTOM
          : toastPos == 1
              ? ToastGravity.CENTER
              : ToastGravity.TOP,
      fontSize: 12,
      backgroundColor: Colors.white,

      // elevation: 10,
      // imageSize: 35,
      textColor: Colors.black   ,
    );
  }





}



