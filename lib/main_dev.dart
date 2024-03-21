import 'package:flutter/widgets.dart';
import 'flavors.dart';
import 'nms_app.dart';

Future<void> main() async {
  F.appFlavor = Flavor.dev;
  await initNMSApp();
  runApp(const NMSApp());
}
