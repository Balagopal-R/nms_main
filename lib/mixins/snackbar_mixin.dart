import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:another_flushbar/flushbar.dart';

import '../utils/utils.dart';

mixin SnackbarMixin on GetxController {
  showErrorSnackbar({required String message}) {
    Flushbar(
      padding: const EdgeInsets.fromLTRB(20, 18, 18, 18),
      titleColor: secondaryColor,
      messageColor: errorColorText,
      icon: SvgPicture.asset(
        "assets/svg/error.svg",
      ),
      // title: title,
      // titleSize: 18,
      message: message,
      messageSize: 12,
      duration: const Duration(seconds: 3),
      backgroundColor: const Color(0xffFFE7E6),
      margin: const EdgeInsets.all(10),
      borderRadius: BorderRadius.circular(10),
      borderColor: Colors.transparent,
      isDismissible: true,
      blockBackgroundInteraction: true,
    ).show(Get.context!);
  }

  showSuccessSnackbar({required String title, required String message}) {
    Flushbar(
      padding: const EdgeInsets.fromLTRB(20, 16, 16, 16),
      titleColor: secondaryColor,
      messageColor: secondaryColor,
      icon: SvgPicture.asset(
        "assets/svg/success.svg",
      ),
      title: title,
      titleSize: 18,
      message: message,
      messageSize: 12,
      duration: const Duration(seconds: 3),
      backgroundColor: backgroundColor,
      margin: const EdgeInsets.all(10),
      borderRadius: BorderRadius.circular(10),
      borderColor: Colors.green,
      isDismissible: true,
      blockBackgroundInteraction: true,
    ).show(Get.context!);
  }

  showInfoSnackbar({required String title, required String message}) {
    Flushbar(
      padding: const EdgeInsets.fromLTRB(20, 16, 16, 16),
      titleColor: secondaryColor,
      messageColor: secondaryColor,
      icon: SvgPicture.asset(
        "assets/svg/snackinfo.svg",
      ),
      title: title,
      titleSize: 18,
      message: message,
      messageSize: 12,
      duration: const Duration(seconds: 3),
      backgroundColor: backgroundColor,
      margin: const EdgeInsets.all(10),
      borderRadius: BorderRadius.circular(10),
      borderColor: secondaryMediumColor,
      isDismissible: true,
      blockBackgroundInteraction: true,
      //blockBackgroundInteraction: true,
    ).show(Get.context!);
  }

  showToastSnackbar({required String message}) {
    Flushbar(
      messageText: Center(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(0xFF303030)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(message,
                style: AppTheme.lightTheme.textTheme.bodyMedium
                    ?.copyWith(color: Colors.white)),
          ),
        ),
      ),
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.transparent,
      margin: const EdgeInsets.all(10),
      borderRadius: BorderRadius.circular(10),
      isDismissible: true,
      blockBackgroundInteraction: true,
    ).show(Get.context!);
  }
}
