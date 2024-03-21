import 'dart:async';
import 'package:flutter/material.dart';
import 'flavors.dart';
import 'nms_app.dart';

FutureOr<void> main() async {
  F.appFlavor = Flavor.dev;
  await initNMSApp();
  runApp(const NMSApp());
}
