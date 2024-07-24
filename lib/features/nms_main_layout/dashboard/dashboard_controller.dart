import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:core';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nms/dtos/nms_dtos/get_birthdays_dtos/get_birthday_request.dart';
import 'package:nms/dtos/nms_dtos/get_employe_punch_time/get_employe_punch_time_request.dart';
import 'package:nms/dtos/nms_dtos/get_leaves_dtos/get_leaves_request.dart';
import 'package:nms/dtos/nms_dtos/punch_status_dtos/punch_status_request.dart';
import 'package:nms/mixins/snackbar_mixin.dart';
import 'package:nms/models/get_birthdays/get_birthdays_model.dart';
import 'package:nms/models/get_employe_punch_time_model/get_employee_punch_time_model.dart';
import 'package:nms/models/get_remaining_leaves/get_remaining_leaves_model.dart';
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
    await getEmployePunchStatus();
    await getEmployeUpcomingBirthdays();
    await getEmployeeLeaves();
    await getEmployeAttendance();
    await getEmployDetails();
    super.onInit();
  }

  final _birthdayName = (List<String>.empty()).obs;
  List<String> get birthdayName => _birthdayName;

  final _daysToBirthday = (List<String>.empty()).obs;
  List<String> get daysToBirthday => _daysToBirthday;

  final _imageOfBirthdays = (List<String>.empty()).obs;
  List<String> get imageOfBirthdays => _imageOfBirthdays;
  // final JBSharedPreferences authService = JBSharedPreferences();

  // final _getEmployData = (List<CorporateDetails>.empty()).obs;
  // List<CorporateDetails> get getEmployData => _getEmployData;

  // final _getEmployData = Rx<EmployeeData?>(null);
  // EmployeeData? get getEmployData => _getEmployData.value;

  final _getEmployeBirthday = (List<GetBirthdayModel>.empty()).obs;
  List<GetBirthdayModel> get getEmployeBirthday => _getEmployeBirthday;

  final _getEmployeAveragePunchTime = (List<GetEmployeePunchTimeModel>.empty()).obs;
  List<GetEmployeePunchTimeModel> get getEmployeAveragePunchTime => _getEmployeAveragePunchTime;

  final _getEmployeRemainingLeaves = (List<GetRemainingLeavesModel>.empty()).obs;
  List<GetRemainingLeavesModel> get getEmployeRemainingLeaves => _getEmployeRemainingLeaves;

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

 int punchDivisor = 0;
 int breakDivisor = 0;

 double getAvgPunchTime = 0.0 ;
 double getAvgBreakTime = 0.0 ;

 final _avgPunchTime = 0.0.obs;
 double get avgPunchTime => _avgPunchTime.value;
 
  final _avgBreakTime = 0.0.obs;
 double get avgBreakTime => _avgBreakTime.value;


 int getTodaysEpochTime() {
  // Get current date without time
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);

  // Convert to seconds since epoch
  return today.millisecondsSinceEpoch ~/ 1000;
}

String getTodaysDate() {
  final now = DateTime.now();
  final formatter = DateFormat('yyyy-MM-dd');
  final formattedDate = formatter.format(now);
  return formattedDate;
}

String formatDoubleWithTwoDecimals(double value) {
  final formattedValue = value.toStringAsFixed(2);
  return formattedValue;
}





// employee punch time , average punch time, clocked working minutes

  Future<void> getEmployePunchTime() async {
    try {
      final authService = NMSJWTDecoder();
      final decodedToken = await authService.decodeAuthToken();
      final todaysEpoch = getTodaysEpochTime();
      if (decodedToken != null) {
        final userId = decodedToken["userId"];

        final request = GetEmployePunchTimeRequest(
            userId: userId, startDate: todaysEpoch-518400, endDate: todaysEpoch);

        final response =
            await ApiRepository.to.getEmployePunchTime(request: request);

        if (response.status == 200) {
          _getEmployeAveragePunchTime.value = response.data;

        for (int i = 0; i < getEmployeAveragePunchTime.length ; i++) {
          if (getEmployeAveragePunchTime[i].clockedWorkingMinutes != 0){
            punchDivisor++ ;

          }
          else{}
        }
         print('@@@@@@@@$punchDivisor');
            print(getEmployeAveragePunchTime.length);

     getAvgPunchTime = (((getEmployeAveragePunchTime[0].clockedWorkingMinutes+
                                getEmployeAveragePunchTime[1].clockedWorkingMinutes+
                                getEmployeAveragePunchTime[2].clockedWorkingMinutes+
                                getEmployeAveragePunchTime[3].clockedWorkingMinutes+
                                getEmployeAveragePunchTime[4].clockedWorkingMinutes+
                                getEmployeAveragePunchTime[5].clockedWorkingMinutes+
                                getEmployeAveragePunchTime[6].clockedWorkingMinutes)/punchDivisor));
                                print('^^^^^^^^$getAvgPunchTime');

                                _avgPunchTime.value = getAvgPunchTime/3600 ;
  
        for (int i = 0; i < getEmployeAveragePunchTime.length; i++) {
          if (getEmployeAveragePunchTime[i].clockedBreakMinutes != 0){
            breakDivisor++ ;
           
          }
          else{}
        }
         print('%%%%%%%%$breakDivisor');

          getAvgBreakTime = (((getEmployeAveragePunchTime[0].clockedBreakMinutes+
                                getEmployeAveragePunchTime[1].clockedBreakMinutes+
                                getEmployeAveragePunchTime[2].clockedBreakMinutes+
                                getEmployeAveragePunchTime[3].clockedBreakMinutes+
                                getEmployeAveragePunchTime[4].clockedBreakMinutes+
                                getEmployeAveragePunchTime[5].clockedBreakMinutes+
                                getEmployeAveragePunchTime[6].clockedBreakMinutes)/breakDivisor));

                                _avgBreakTime.value = getAvgBreakTime/3600 ;


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

  // get employee details

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
          // print(response.data);
          _punchStatus.value = response.data;
          update();
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
        // print(response.data);
        // _punchStatus.value = response.data ;
        // update();
        // print(punchStatus);
        _getEmployeBirthday.value = response.data;

        _birthdayName.value = [
          getEmployeBirthday[0].employee.firstname  +getEmployeBirthday[0].employee.lastname,
          getEmployeBirthday[1].employee.firstname  +getEmployeBirthday[1].employee.lastname,
          getEmployeBirthday[2].employee.firstname  +getEmployeBirthday[2].employee.lastname,
        ];

        _daysToBirthday.value = [
          "In ${getEmployeBirthday[0].daysToBirthday} days",
          "In ${getEmployeBirthday[1].daysToBirthday} days",
          "In ${getEmployeBirthday[2].daysToBirthday} days"
        ];

       _imageOfBirthdays.value = [
        getEmployeBirthday[0].employee.profileImgUrl,
        getEmployeBirthday[1].employee.profileImgUrl,
        getEmployeBirthday[2].employee.profileImgUrl
       ];

        update();
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
       final authService = NMSJWTDecoder();
      final decodedToken = await authService.decodeAuthToken();
      final userId = decodedToken!["userId"];
      String today = getTodaysDate();

      final request = GetLeavesRequest(
          userId: userId,
          keyword: '',
          page: 0,
          size: 10,
          field: "leaveBalance",
          sortOfOrder: "ASC",
          asOfDate: today,
          status: ["ACTIVE"],
          );

      final response = await ApiRepository.to.getLeaves(request: request);

      if (response.status == 200) {
        print(response.data);
        _getEmployeRemainingLeaves.value = response.data;

        print(getEmployeRemainingLeaves[0].balanceLeaves/getEmployeRemainingLeaves[0].totalLeaves);
         print(getEmployeRemainingLeaves[1].balanceLeaves/getEmployeRemainingLeaves[1].totalLeaves);          
          print(getEmployeRemainingLeaves[2].balanceLeaves/getEmployeRemainingLeaves[2].totalLeaves);
         print(getEmployeRemainingLeaves[3].balanceLeaves/getEmployeRemainingLeaves[3].totalLeaves);
          print(getEmployeRemainingLeaves[4].balanceLeaves/getEmployeRemainingLeaves[4].totalLeaves);
        // print('${getEmployeRemainingLeaves[0].balanceLeaves}');
        update();
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
          // print(response.data);
          _getAttendance.value = response.data;
          update();
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
