// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ShareFunc {
  static void cancelToast() {
    Fluttertoast.cancel();
  }

  static void showToast(String txt, {Color txtColor = Colors.black, Color bgColor = Colors.orangeAccent}) {
    Fluttertoast.showToast(
        msg: txt,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: bgColor,
        textColor: txtColor,
        fontSize: 16.0);
  }
}
