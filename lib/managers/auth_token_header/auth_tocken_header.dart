import 'package:get/get.dart';
import '../refresh_token_expiry/refresh_token_expiry.dart';
import '../sharedpreferences/sharedpreferences.dart';

class NMSAuthTokenHeader extends GetxController {
  static NMSAuthTokenHeader get to => Get.find();

  Future<Map<String, String>> getAuthTokenHeader() async {
    await RefreshTokenExpiryChecker().refreshTokenExpiryChecker();
    // await RefreshTokenApiCall().checkTokenExpiration();
    final authToken = await NMSSharedPreferences().getTokenFromPrefs();

    if (authToken == null) {
      throw Exception("No authentication token found");
    }

    var header = {
      'Content-Type': 'application/json',
      'org-id': 'nintriva',
      'Authorization': 'Bearer $authToken',
    };

    return header;
  }
}
