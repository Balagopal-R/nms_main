import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../refresh_token_expiry/refresh_token_expiry.dart';

// import '../refresh_token_api/refresh_token_api.dart';
// import '../refresh_token_expiry/refresh_token_expiry.dart';

class NMSSharedPreferences {
  Future<void> saveTokensToPrefs(
      String accessToken, String refreshToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessToken', accessToken);
    await prefs.setString('refreshToken', refreshToken);
    debugPrint('Tokens saved to SharedPreferences');
  }

// Get access token from SharedPreferences
  Future<String?> getTokenFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessToken') ?? null;
  }

  // Get refresh token from SharedPreferences
  Future<String?> getRefreshTokenFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('refreshToken');
  }
}

//logout
clearSharedPreferences() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('refreshToken');
  await prefs.remove('accessToken');
  // await prefs.remove('fcmToken');
  // await prefs.remove('notification_tiles');
  // await prefs.remove('notification_bodies');
  // This will clear all data stored in SharedPreferences
  debugPrint('SharedPreferences cleared.');
}

class NMSJWTDecoder {
  Future<Map<String, dynamic>?> decodeAuthToken() async {
    await RefreshTokenExpiryChecker().refreshTokenExpiryChecker();
    // await RefreshTokenApiCall().checkTokenExpiration();
    final authToken = await NMSSharedPreferences().getTokenFromPrefs();
    if (authToken != null) {
      print(
          '******************************************************${JwtDecoder.decode(authToken)}++++++++++++');
      return JwtDecoder.decode(authToken);
    }
    return null;
  }
}
