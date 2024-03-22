import 'package:flutter/material.dart';

AppBar appbarMain(BuildContext context, String appbarName) {
  // final String appbarName;
  return AppBar(
    surfaceTintColor: Colors.white,
    title: SizedBox(
        width: MediaQuery.of(context).size.width - 140,
        child: Center(child: Text(appbarName))),
  );
}
