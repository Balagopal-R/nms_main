import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nms/dtos/nms_dtos/last_punch_in_dtos/last_punch_in.dart';
import 'package:nms/managers/sharedpreferences/sharedpreferences.dart';
import 'package:nms/mixins/snackbar_mixin.dart';
import 'package:nms/repository/api_repository.dart';
import '../../../../models/last_punch_in_model/last_punch_in_model.dart';

class ApprovalsController extends GetxController with SnackbarMixin {

    final _getEmployPunchIn = Rx<LastPunchInModel?>(null);
  LastPunchInModel? get getEmployPunchIn => _getEmployPunchIn.value;


  @override
  void onInit() async {
    await getLastPunchIn();
    super.onInit();
  }

   // last punch in

  getLastPunchIn() async {
    try {
      final authService = NMSJWTDecoder();
      final decodedToken = await authService.decodeAuthToken();
      if (decodedToken != null) {
        final userId = decodedToken["userId"];
        final request = LastPunchInRequest(userId: userId);
        final response = await ApiRepository.to.lastPunchIn(request: request);
        if (response.status == 200) {
          _getEmployPunchIn.value = response.data;
        }
      }
    } catch (e) {
      showErrorSnackbar(message: e.toString());
      // _isLoading.value = false;
      debugPrint(e.toString());
    }
  }


}