import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:nms/dtos/nms_dtos/login/get_employ/get_employ_request.dart';
import 'package:nms/managers/refresh_token_api/refresh_token_api.dart';
import 'package:nms/managers/refresh_token_expiry/refresh_token_expiry.dart';
import 'package:nms/managers/sharedpreferences/sharedpreferences.dart';
import 'package:nms/mixins/snackbar_mixin.dart';
import 'package:nms/models/login_screen/get_employee_model.dart';
import 'package:nms/repository/api_repository.dart';
import 'package:nms/utils/helpers/validation.dart';
import 'package:nms/utils/theme/theme.dart';
import '../../dtos/nms_dtos/logout_dtos/logout_request.dart';

class ProfileController extends GetxController with SnackbarMixin {

  final _getEmployData = Rx<EmployeeData?>(null);
  EmployeeData? get getEmployData => _getEmployData.value;

  final _logOut = ''.obs;
  String get logOut => _logOut.value;
  String userId = "";


  @override
  void onInit() async{
  await getIdFromToken();
  await getEmployDetails();
  
    super.onInit();
  }

   String extractYear(String date) {
  try {
    DateTime parsedDate = DateTime.parse(date);
    return parsedDate.year.toString();
  } catch (e) {
    return 'Invalid date';
  }
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

   // User Logout
  userLogout() async {
    try {
        final request = LogoutRequest();
        final response = await ApiRepository.to.logout(request: request);

        if (response.status == 200) {
          // print(response.data);
          // _logOut.value = response.data;
          showSuccessSnackbar(title:'Success', message:  "Logged out successfully");
        } else if (response.message == "Failed") {
          debugPrint(response.errors['errorMessage']);
          showErrorSnackbar(message: errorOccuredText);
        }
      
    } catch (e) {
      return catchErrorSection(e);
    }
  }

   catchErrorSection(e) async {
    debugPrint('error-----${e.toString()}------');

    if (e.toString().isNotEmpty) {
      try {
        Map<String, dynamic> errorResponse = jsonDecode(e.toString());

        if (errorResponse.containsKey("errors")) {
          Map<String, dynamic> errors =
              Map<String, dynamic>.from(errorResponse["errors"]);
          if (errors.containsKey("errorMessage")) {
            String errorMessage = errors["errorMessage"];

            if (errorMessage.contains("Bad Credentials")) {
              debugPrint('error');
            }

            return;
          }
        }
      } catch (e) {
        debugPrint('Error decoding JSON: ${e.toString()}');
        showErrorSnackbar(
          message: e.toString(),
        );
        return e.toString();
      }
    }
  }

 void showCustomLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          backgroundColor: backgroundColor,
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text(
                  'Are you sure you want to log out?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: primaryTextColor,
                    fontFamily: 'Satoshi',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    height: 1.4, // 140% line height
                  ),
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () async{
                    //  Navigator.of(context).pop();
                     await userLogout();
                     await clearSharedPreferences();
                     Get.offAllNamed('/signin_screen');
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: darkRed,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    alignment: Alignment.center,
                    child: const Text(
                      'Logout',
                      style: TextStyle(
                        color: backgroundColor,
                        fontFamily: 'Satoshi',
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      border: Border.all(
                        color: darkRed,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    alignment: Alignment.center,
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        color: darkRed,
                        fontFamily: 'Satoshi',
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  


}