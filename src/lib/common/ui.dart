// ignore_for_file: non_constant_identifier_names

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

//####### MY UI #######

class MyUi {
  static double rem = 14;

  //horizontal spacer & vertical spacer
  static Widget hs_2xs() {
    return SizedBox(height: 0.2 * rem);
  }

  static Widget hs_xs() {
    return SizedBox(height: 0.5 * rem);
  }

  static Widget hs_sm() {
    return SizedBox(height: 0.75 * rem);
  }

  static Widget hs_md() {
    return SizedBox(height: 1 * rem);
  }

  static Widget hs_lg() {
    return SizedBox(height: 2 * rem);
  }

  static Widget hs_xl() {
    return SizedBox(height: 3 * rem);
  }

  static Widget vs_xs() {
    return SizedBox(width: 0.5 * rem);
  }

  static Widget vs_sm() {
    return SizedBox(width: 0.75 * rem);
  }

  static Widget vs_md() {
    return SizedBox(width: 1 * rem);
  }

  static Widget vs_lg() {
    return SizedBox(width: 2 * rem);
  }

  static Widget vs_xl() {
    return SizedBox(width: 3 * rem);
  }

  static Widget hr({bool? paddingFlag}) {
    var w = Divider(color: Colors.grey.shade200);
    if (paddingFlag != null && paddingFlag == false) {
      w = Divider(height: 1, color: Colors.grey.shade200);
    }
    return w;
  }

  static Widget dialog({Widget? child, double padding = 0}) {
    final d = Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: Colors.white,
        child: child?.paddingAll(padding));
    return d;
  }

  static Widget loadingCirlce() {
    final w = Container(
      width: 24,
      height: 24,
      padding: const EdgeInsets.all(6.0),
      child: const CircularProgressIndicator(
        color: Colors.black87,
        strokeWidth: 2,
      ),
    );
    return w;
  }

  static Widget loadingListIcon({int length = 5}) {
    final w = ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(vertical: 0),
        itemCount: length,
        itemBuilder: (context, index) {
          final c = Skeletonizer(
            enabled: true,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              ListTile(
                leading: Bone.icon(),
                title: Bone.text(words: 3),
                subtitle: Bone.text(words: 2),
              ),
            ]),
          );

          return c;
        });

    return w;
  }

  static Widget loadingList({int length = 5}) {
    final w = ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(vertical: 10),
        itemCount: length,
        itemBuilder: (context, index) {
          final c = Skeletonizer(
            enabled: true,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(BoneMock.chars(36, "-")),
              Text(BoneMock.chars(66, "-")),
              MyUi.hr(),
            ]),
          );

          return c;
        });

    return w;
  }

  static Widget bullet({Color color = Colors.black}) {
    final w = Container(
      height: 12.0,
      width: 12.0,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
    return w;
  }

  static Widget whiteLabel({String text = "yea"}) {
    final w = Container(
      padding: EdgeInsets.all(1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        border: Border.all(color: Colors.blueAccent),
        color: Colors.white70,
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.black,
          fontSize: 12,
        ),
      ),
    );
    return w;
  }

  static BoxShadow shadow() {
    return BoxShadow(
      color: Colors.grey.withValues(alpha: 0.2),
      spreadRadius: 2,
      blurRadius: 3,
      offset: Offset(0, 2), // changes position of shadow
    );
  }

  //loynote: use wTag in _general_ui.dart

  static Widget tag(String txt) {
    final w = Container(
      padding: EdgeInsets.fromLTRB(8, 2, 8, 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        //border: Border.all(color: Colors.blueAccent),
        color: Colors.blue.shade100,
      ),
      child: Text(
        txt.toUpperCase(),
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.blue.shade900,
          fontSize: 10,
        ),
      ),
    );

    return w;
  }
}
