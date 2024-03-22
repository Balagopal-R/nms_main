import 'package:flutter/material.dart';
import 'package:get/get.dart';

AppBar appbarMain(BuildContext context, String appbarName) {
  // final String appbarName;
  return AppBar(
    leading: InkWell(
        onTap: () {
          Get.back();
        },
        child: Image.asset('assets/png/arrow_left.png')),
    surfaceTintColor: Colors.white,
    title: SizedBox(
        width: MediaQuery.of(context).size.width - 140,
        child: Center(child: Text(appbarName))),
  );
}
