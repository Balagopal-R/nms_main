import 'dart:async';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
// import '../../controllers/app_controller.dart';
import '../sharedpreferences/sharedpreferences.dart';

class RefreshTokenExpiryChecker extends GetxController {
  Future<void> refreshTokenExpiryChecker() async {
    final refreshToken = await NMSSharedPreferences().getRefreshTokenFromPrefs();
    if (refreshToken != null) {
      final isExpired = JwtDecoder.isExpired(refreshToken);
      if (isExpired) {
        await logOutFunction();
      }
    } else {}
  }

  Future<void> logOutFunction() async {
    await clearSharedPreferences();
    // AppController.to.loggedOut();
  }
}
