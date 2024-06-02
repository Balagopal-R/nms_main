import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nms/dtos/nms_dtos/get_employe_punch_time/get_employe_punch_time_request.dart';
import 'package:nms/dtos/nms_dtos/punch_status_dtos/punch_status_request.dart';
import 'package:nms/mixins/snackbar_mixin.dart';
import '../../../managers/sharedpreferences/sharedpreferences.dart';
import '../../../repository/api_repository.dart';
import '../../../utils/utils.dart';

class DashboardController extends GetxController with SnackbarMixin {




  @override
  void onInit() async {
    // getEmployeDashboard();
    // await getEmployDetails();
    getEmployePunchStatus();
    super.onInit();
  }
  // final JBSharedPreferences authService = JBSharedPreferences();

  // final _getEmployData = (List<CorporateDetails>.empty()).obs;
  // List<CorporateDetails> get getEmployData => _getEmployData;

  // final _getEmployData = Rx<EmployeeData?>(null);
  // EmployeeData? get getEmployData => _getEmployData.value;


  final _isLoadingOverlay = false.obs;
  bool get isLoadingOverlay => _isLoadingOverlay.value;

 final _punchStatus = ''.obs;
  String get punchStatus => _punchStatus.value;

  





 

  

  Future<void> getEmployeDashboard() async {
    //String platform = (Platform.isAndroid || Platform.isIOS) ? "MOBILE" : "WEB";
    
      try {
        final request = GetEmployePunchTimeRequest(userId: 'c3f9a1c8-fe21-4c7e-9bae-612afa4a24f9', startDate: 1715970600, endDate: 1716489000
            );

        final response =
            await ApiRepository.to.getEmployePunchTime(request: request);

        if (response.status == 200) {
          print(response.data);
          // debugPrint('----------${response.data['accessToken']}--------------');
          // debugPrint(
          //     '----------${response.data['refreshToken']}--------------');
          // final nmsSharedPreferences = NMSSharedPreferences();
          // String accessToken = response.data['accessToken'];
          // String refreshToken = response.data['refreshToken'];
          // await nmsSharedPreferences.saveTokensToPrefs(
          //     accessToken, refreshToken);

          // await AppController.to.signedIn();

        
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

  //get employ details

  // getEmployDetails() async {
  //   // _isLoading.value = true;
  //   try {
  //     final authService = NMSJWTDecoder();
  //     final decodedToken = await authService.decodeAuthToken();
  //     if (decodedToken != null) {
  //       final userId = decodedToken["userId"];
  //       final request = GetEmpoyRequest(userId: userId);
  //       final response =
  //           await ApiRepository.to.getEmployDetails(request: request);
  //       if (response.status == 200) {
  //         _getEmployData.value = response.data;

  //         debugPrint(
  //             "Employ-- length  ${_getEmployData.value!.corporateDetails.buddy.personalDetailsBuddy.firstname}");

  //         update();
  //       }
  //     }
  //   } catch (e) {
  //     showErrorSnackbar(message: e.toString());
  //     // _isLoading.value = false;
  //     debugPrint(e.toString());
  //   }
  // }

  // employe punch status

  
  getEmployePunchStatus() async {
    //String platform = (Platform.isAndroid || Platform.isIOS) ? "MOBILE" : "WEB";
    
      try {

         final authService = NMSJWTDecoder();
      final decodedToken = await authService.decodeAuthToken();
      if (decodedToken != null) {
        final userId = decodedToken["userId"];
        
        final request = PunchStatusRequest(userId:userId);

        final response =
            await ApiRepository.to.getPunchStatus(request: request);

        if (response.status == 200) {
          print(response.data);
          _punchStatus.value = response.data ;
          update();
          print(punchStatus);

        
        } else if (response.message == "Failed") {
          debugPrint(response.errors['errorMessage']);
          showErrorSnackbar(message: errorOccuredText);
        }}
      } catch (e) {
        return catchErrorSection(e);
      }
    
  }
}
