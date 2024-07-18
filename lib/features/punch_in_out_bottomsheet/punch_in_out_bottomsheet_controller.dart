import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nms/dtos/nms_dtos/punch_in_dtos/punch_in.dart';
import 'package:nms/dtos/nms_dtos/punch_out_dtos/punch_out.dart';
import 'package:nms/managers/sharedpreferences/sharedpreferences.dart';
import 'package:nms/repository/api_repository.dart';
import '../../mixins/snackbar_mixin.dart';
import '../../utils/helpers/validation.dart';

class PunchRequestBottomSheetController extends GetxController with SnackbarMixin{

    final _punchInMessage = ''.obs;
  String get punchInMessage => _punchInMessage.value;

  final _punchOutMessage = ''.obs;
  String get punchOutMessage => _punchOutMessage.value;


   @override
  void onInit() async{
  await userPunchIn();
  await userPunchOut(); 
  super.onInit();
  }

    //  user punch in
   userPunchIn() async {
    try {
      final authService = NMSJWTDecoder();
      final decodedToken = await authService.decodeAuthToken();
      if (decodedToken != null) {
        final userId = decodedToken["userId"];

        final request = PunchInRequest(
          empId: userId,
          punchInDateTime: 1720945153,
          punchLocation: "OFFICE",
          projectCode: "NMS",
          task: "Unassigned",
          description: "",
          isOnBreak: false,
          shiftDate: 1720463400
          );

        final response =
            await ApiRepository.to.punchIn(request: request);

        if (response.status == 200) {
          _punchInMessage.value = response.data;
          print(punchInMessage);
       

        } else if (response.message == "Failed") {
          debugPrint(response.errors['errorMessage']);
          showErrorSnackbar(message: errorOccuredText);
        }
      }
    } catch (e) {
      showErrorSnackbar(message: e.toString());
    }
  }

      //  user punch Out
   userPunchOut() async {
    try {
      final authService = NMSJWTDecoder();
      final decodedToken = await authService.decodeAuthToken();
      if (decodedToken != null) {
        final userId = decodedToken["userId"];

        final request = PunchOutRequest(
          empId: userId,
          punchOutDateTime: 1721209425,
          punchLocation: "OFFICE",
          projectCode: "NMS",
          task: "Unassigned",
          description: "",
          isOnBreak: false,
          shiftDate: 1721154600
          );

        final response =
            await ApiRepository.to.punchOut(request: request);

        if (response.status == 200) {
          _punchOutMessage.value = response.data;
          print(punchOutMessage);
       

        } else if (response.message == "Failed") {
          debugPrint(response.errors['errorMessage']);
          showErrorSnackbar(message: errorOccuredText);
        }
      }
    } catch (e) {
      showErrorSnackbar(message: e.toString());
    }
  }
  
}