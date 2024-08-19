import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import '../../config/app/app_config.dart';
import '../api/api.dart';
import '../sharedpreferences/sharedpreferences.dart';
import 'package:http/http.dart' as http;

class RefreshTokenApiCall extends GetxController {
  Future<void> checkTokenExpiration() async {
    final authToken = await NMSSharedPreferences().getTokenFromPrefs();
    if (authToken != null) {
      final isExpired = JwtDecoder.isExpired(authToken);
      if (isExpired) {
        await refreshAccessToken();
      }
    } else {}
  }

  Future<void> refreshAccessToken() async {
    try {
      final nmsSharedPreferences = NMSSharedPreferences();
      final String? refreshToken =
          await nmsSharedPreferences.getRefreshTokenFromPrefs();
      if (refreshToken == null) {
        return;
      }
      final String baseUrl =
          "${NMSAppConfigManager.config.httpScheme}://${NMSAppConfigManager.config.backendBaseURL}/${NMSAppConfigManager.config.serviceUrl}/${ApiEndPoints.refresh}";
      var url = Uri.parse(baseUrl);
      final response = await http.post(
        url,
        headers: {
      'Content-Type': 'application/json',
      'org-id': 'nintriva',
      'Authorization': 'Bearer $refreshToken',
      'unit-id' : 'default'
    },
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final accessToken = jsonResponse['data']['accessToken'];
        final refreshToken = jsonResponse['data']['refreshToken'];

        if (accessToken != null && refreshToken != null) {
          await nmsSharedPreferences.saveTokensToPrefs(
              accessToken, refreshToken);
          debugPrint("Access token refreshed successfully: $accessToken");
        } else {
          debugPrint(
              "Access token or refresh token not found in the API response.");
        }
      } else {
        debugPrint(
            "Failed to refresh access token. Status code: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint('Error refreshing access token: $e');
    }
  }
}
