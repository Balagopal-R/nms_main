import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:nms/managers/refresh_token_api/refresh_token_api.dart';
import 'package:nms/managers/refresh_token_expiry/refresh_token_expiry.dart';
import 'package:nms/mixins/snackbar_mixin.dart';

import '../../dtos/nms_dtos/login/get_employ/get_employ.dart';
import '../../managers/sharedpreferences/sharedpreferences.dart';
import '../../models/login_screen/get_employee_model.dart';
import '../../repository/api_repository.dart';

class BasicDetailsController extends GetxController with SnackbarMixin {

  final _getEmployData = Rx<EmployeeData?>(null);
  EmployeeData? get getEmployData => _getEmployData.value;

  String userId = "";
  
  @override
  void onInit() async{
    await getIdFromToken();
    await getEmployDetails();
    super.onInit();
  }

      getIdFromToken() async {
    await RefreshTokenExpiryChecker().refreshTokenExpiryChecker();
    await RefreshTokenApiCall().checkTokenExpiration();
    final authToken = await NMSSharedPreferences().getTokenFromPrefs();
    if (authToken != null) {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(authToken);
      String uid = decodedToken["userId"];
      userId = uid;
      debugPrint("user id is ------$userId");
    }
  }

  //get employ details

  getEmployDetails() async {
    // _isLoading.value = true;
    try {
      final authService = NMSJWTDecoder();
      final decodedToken = await authService.decodeAuthToken();
      if (decodedToken != null) {
        userId = decodedToken["userId"];
        final request = GetEmpoyRequest(userId: userId);
        final response =
            await ApiRepository.to.getEmployDetails(request: request);
        if (response.status == 200) {
          _getEmployData.value = response.data;
          update();
        }
      }
    } catch (e) {
      showErrorSnackbar(message: e.toString());
      // _isLoading.value = false;
      debugPrint(e.toString());
    }
  }
}
