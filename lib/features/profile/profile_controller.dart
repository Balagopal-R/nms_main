import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:nms/dtos/nms_dtos/login/get_employ/get_employ_request.dart';
import 'package:nms/managers/sharedpreferences/sharedpreferences.dart';
import 'package:nms/mixins/snackbar_mixin.dart';
import 'package:nms/models/login_screen/get_employee_model.dart';
import 'package:nms/repository/api_repository.dart';

class ProfileController extends GetxController with SnackbarMixin {

  final _getEmployData = Rx<EmployeeData?>(null);
  EmployeeData? get getEmployData => _getEmployData.value;


  @override
  void onInit() async{

    print('Manuuuuuuu');

  await getEmployDetails();
    super.onInit();
  }

  getEmployDetails() async {
    // _isLoading.value = true;
    print('------------------------------------Maluuuuuuu');
    try {
      final authService = NMSJWTDecoder();
      final decodedToken = await authService.decodeAuthToken();
      if (decodedToken != null) {
        final userId = decodedToken["userId"];
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