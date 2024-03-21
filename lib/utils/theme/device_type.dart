import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

enum DeviceType { phone, tablet, desktop }

DeviceType getDeviceTypeGetx() {
  var width = MediaQuery.of(Get.context!).size.width;
  if (width < 650) {
    return DeviceType.phone;
  } else if (width < 1100 && width >= 650) {
    return DeviceType.tablet;
  }

  return DeviceType.desktop;
}
