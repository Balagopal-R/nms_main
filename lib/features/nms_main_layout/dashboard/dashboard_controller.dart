import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nms/dtos/nms_dtos/get_birthdays_dtos/get_birthday_request.dart';
import 'package:nms/dtos/nms_dtos/get_employe_punch_time/get_employe_punch_time_request.dart';
import 'package:nms/dtos/nms_dtos/get_leaves_dtos/get_leaves_request.dart';
import 'package:nms/dtos/nms_dtos/punch_status_dtos/punch_status_request.dart';
import 'package:nms/mixins/snackbar_mixin.dart';
import 'package:nms/models/get_birthdays/get_birthdays_model.dart';
import 'package:nms/models/login_screen/get_employee_model.dart';
import '../../../dtos/nms_dtos/get_attendance/get_attendance_request.dart';
import '../../../dtos/nms_dtos/login/get_employ/get_employ_request.dart';
import '../../../managers/sharedpreferences/sharedpreferences.dart';
import '../../../repository/api_repository.dart';
import '../../../utils/utils.dart';

class DashboardController extends GetxController with SnackbarMixin {
  
  // late List<String> birthdayName;
  // late List<String> daysToBirthday;

  @override
  void onInit() async {
    await getEmployePunchTime();
    await getEmployDetails();
    await getEmployePunchStatus();
    await getEmployeUpcomingBirthdays();
    await getEmployeeLeaves();

    super.onInit();
  }

  final _birthdayName = (List<String>.empty()).obs;
  List<String> get birthdayName => _birthdayName;

  final _daysToBirthday = (List<String>.empty()).obs;
  List<String> get daysToBirthday => _daysToBirthday;
  // final JBSharedPreferences authService = JBSharedPreferences();

  // final _getEmployData = (List<CorporateDetails>.empty()).obs;
  // List<CorporateDetails> get getEmployData => _getEmployData;

  // final _getEmployData = Rx<EmployeeData?>(null);
  // EmployeeData? get getEmployData => _getEmployData.value;

  final _getEmployeBirthday = (List<GetBirthdayModel>.empty()).obs;
  List<GetBirthdayModel> get getEmployeBirthday => _getEmployeBirthday;

  final _getEmployData = Rx<EmployeeData?>(null);
  EmployeeData? get getEmployData => _getEmployData.value;

  // final _getEmployeBirthday = Rx<GetBirthdayModel?>(null);
  // GetBirthdayModel? get getEmployeBirthday => _getEmployeBirthday.value;

  final _isLoadingOverlay = false.obs;
  bool get isLoadingOverlay => _isLoadingOverlay.value;

  final _punchStatus = ''.obs;
  String get punchStatus => _punchStatus.value;

  final _getAttendance = 0.obs;
  int get getAttendance => _getAttendance.value;

// employee punch time , average punch time, clocked working minutes

  Future<void> getEmployePunchTime() async {
    try {
      final authService = NMSJWTDecoder();
      final decodedToken = await authService.decodeAuthToken();
      if (decodedToken != null) {
        final userId = decodedToken["userId"];

        final request = GetEmployePunchTimeRequest(
            userId: userId, startDate: 1717093800, endDate: 1717612200);

        final response =
            await ApiRepository.to.getEmployePunchTime(request: request);

        if (response.status == 200) {
          print(response.data);
        } else if (response.message == "Failed") {
          debugPrint(response.errors['errorMessage']);
          showErrorSnackbar(message: errorOccuredText);
        }
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

  // get employ details

  getEmployDetails() async {
    // _isLoading.value = true;
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

  // employe punch status

  getEmployePunchStatus() async {
    //String platform = (Platform.isAndroid || Platform.isIOS) ? "MOBILE" : "WEB";

    try {
      final authService = NMSJWTDecoder();
      final decodedToken = await authService.decodeAuthToken();
      if (decodedToken != null) {
        final userId = decodedToken["userId"];

        final request = PunchStatusRequest(userId: userId);

        final response =
            await ApiRepository.to.getPunchStatus(request: request);

        if (response.status == 200) {
          print(response.data);
          _punchStatus.value = response.data;
          update();
          print(punchStatus);
        } else if (response.message == "Failed") {
          debugPrint(response.errors['errorMessage']);
          showErrorSnackbar(message: errorOccuredText);
        }
      }
    } catch (e) {
      return catchErrorSection(e);
    }
  }

  getEmployeUpcomingBirthdays() async {
    //String platform = (Platform.isAndroid || Platform.isIOS) ? "MOBILE" : "WEB";

    try {
      final request = GetBirthdayRequest();

      final response =
          await ApiRepository.to.getEmployeBirthdays(request: request);

      if (response.status == 200) {
        print(response.data);
        // _punchStatus.value = response.data ;
        // update();
        // print(punchStatus);
        _getEmployeBirthday.value = response.data;
        print(getEmployeBirthday[0].daysToBirthday);
        print(getEmployeBirthday[1].daysToBirthday);
        print(getEmployeBirthday[2].daysToBirthday);

        _birthdayName.value = [
          getEmployeBirthday[0].employee.firstname,
          getEmployeBirthday[1].employee.firstname,
          getEmployeBirthday[2].employee.firstname
        ];

        _daysToBirthday.value = [
          "In ${getEmployeBirthday[0].daysToBirthday} days",
          "In ${getEmployeBirthday[1].daysToBirthday} days",
          "In ${getEmployeBirthday[2].daysToBirthday} days"
        ];
        update();
        print(birthdayName);
        print(daysToBirthday);
      } else if (response.message == "Failed") {
        debugPrint(response.errors['errorMessage']);
        showErrorSnackbar(message: errorOccuredText);
      }
    } catch (e) {
      return catchErrorSection(e);
    }
  }

// get remaining leaves

  getEmployeeLeaves() async {
    //String platform = (Platform.isAndroid || Platform.isIOS) ? "MOBILE" : "WEB";

    try {
      final request = GetLeavesRequest(
          userId: 'c3f9a1c8-fe21-4c7e-9bae-612afa4a24f9',
          asOfDate: "2024-06-06",
          status: ["ACTIVE"],
          field: "leaveBalance",
          sortOfOrder: "ASC",
          page: 0,
          size: 10);

      final response =
          await ApiRepository.to.getLeaves(request: request);

      if (response.status == 200) {
        print(response.data);
      } else if (response.message == "Failed") {
        debugPrint(response.errors['errorMessage']);
        showErrorSnackbar(message: errorOccuredText);
      }
    } catch (e) {
      return catchErrorSection(e);
    }
  }

  // get employe attendance in carousel
  getEmployeAttendance() async {
    try {
      final authService = NMSJWTDecoder();
      final decodedToken = await authService.decodeAuthToken();
      if (decodedToken != null) {
        final userId = decodedToken["userId"];
        final request = GetEmployeAttendanceRequest(userId: userId);
        final response = await ApiRepository.to.getAttendance(request: request);

        if (response.status == 200) {
          print(response.data);
          _getAttendance.value = response.data;
          update();
          print(getAttendance);
        } else if (response.message == "Failed") {
          debugPrint(response.errors['errorMessage']);
          showErrorSnackbar(message: errorOccuredText);
        }
      }
    } catch (e) {
      return catchErrorSection(e);
    }
  }
}
