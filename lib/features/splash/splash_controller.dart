import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nms/managers/refresh_token_api/refresh_token_api.dart';
import 'package:nms/managers/refresh_token_expiry/refresh_token_expiry.dart';
import 'package:nms/managers/sharedpreferences/sharedpreferences.dart';

class SplashScreenController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void onInit() async {
    await animationInitilization();
    super.onInit();
  }

  animationInitilization() async {
    await RefreshTokenExpiryChecker().refreshTokenExpiryChecker();
    await RefreshTokenApiCall().checkTokenExpiration();
    NMSSharedPreferences prefs = NMSSharedPreferences();
    String? accessToken = await prefs.getTokenFromPrefs();
    debugPrint('get accessToken --$accessToken');
    Timer(const Duration(seconds: 5), () {
      if (accessToken != null) {
        Get.offAndToNamed('/nms_mainlayout_screen', arguments: {'index': 0});
      } else {
        Get.offAndToNamed('/signin_screen');
      }
    });
    update();
  }

}
