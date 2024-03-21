import 'package:flutter/material.dart';
import 'package:get/get.dart';

// import '../managers/firebase_api/firebase_fcm_token_manager.dart';

enum LoggedStatus { loggedInitial, notLoggedIn, loggedIn }

class AppController extends GetxController {
  static AppController get to => Get.find();
  final isLogged = LoggedStatus.loggedInitial.obs;

  @override
  onInit() {
    super.onInit();
    ever(isLogged, _fireRoute);
  }

  _fireRoute(logged) async {
    if (logged == LoggedStatus.loggedIn) {
      // FCMTokenManager.registerToken();
      await Get.offAllNamed('/nms_dashboard_screen',
          arguments: {'index': 1});
    } else if (logged == LoggedStatus.notLoggedIn) {
      await Get.offAllNamed("/signin_screen");
    }
  }

  // signedUp() {
  //   debugPrint('SignnedUp');
  //   isLogged.value = LoggedStatus.loggedIn;
  // }

  signedIn() {
    debugPrint('loggedIn');
    isLogged.value = LoggedStatus.loggedIn;
  }

  notLoggedIn() {
    debugPrint('notloggedIn');
    isLogged.value = LoggedStatus.notLoggedIn;
  }

  loggedOut() {
    debugPrint('loggedOut');
    isLogged.value = LoggedStatus.notLoggedIn;
    Get.offAllNamed('/signin_screen');
  }
}
