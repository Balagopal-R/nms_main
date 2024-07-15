import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nms/dtos/nms_dtos/last_punch_in_dtos/last_punch_in.dart';
import 'package:nms/dtos/nms_dtos/punch_in_dtos/punch_in.dart';
import 'package:nms/managers/sharedpreferences/sharedpreferences.dart';
import 'package:nms/mixins/snackbar_mixin.dart';
import 'package:nms/models/last_punch_in_model/last_punch_in_model.dart';
import 'package:nms/utils/helpers/validation.dart';
import '../../../dtos/nms_dtos/punch_out_dtos/punch_out.dart';
import '../../../dtos/nms_dtos/punch_request_dtos/punch_request.dart';
import '../../../dtos/nms_dtos/team_listing_dtos/team_listing.dart';
import '../../../models/team_list_model/team_list_model.dart';
import '../../../repository/api_repository.dart';

class TeamListingController extends GetxController with SnackbarMixin{

  final TextEditingController searchEmployeeController = TextEditingController();

  final _teamListing = (List<TeamListingModel>.empty()).obs;
  List<TeamListingModel> get teamListing => _teamListing;

    final _getEmployPunchIn = Rx<LastPunchInModel?>(null);
  LastPunchInModel? get getEmployPunchIn => _getEmployPunchIn.value;

    final _punchInMessage = ''.obs;
  String get punchInMessage => _punchInMessage.value;

  final _punchOutMessage = ''.obs;
  String get punchOutMessage => _punchOutMessage.value;

  final _punchRequestMessage = ''.obs;
  String get punchRequestMessage => _punchRequestMessage.value;

   @override
  void onInit() async{

  await teamListingScreen();
  await getLastPunchIn();
  // await userPunchIn();
  await userPunchOut(); 
  // await userPunchRequest();

  // await dateTimeToEpoch('14/07/2024', '15:00');
  super.onInit();
  }


  int dateTimeToEpoch(String dateString, String timeString) {
  // Validate date format
  if (!RegExp(r"^\d{2}/\d{2}/\d{4}$").hasMatch(dateString)) {
    throw ArgumentError('Invalid date format. Expected dd/mm/yyyy');
  }

  // Validate time format
  if (!RegExp(r"^\d{2}:\d{2}$").hasMatch(timeString)) {
    throw ArgumentError('Invalid time format. Expected HH:mm');
  }

  // Parse the date parts
  List<int> date = dateString.split('/').map(int.parse).toList();

  // Parse the time parts
  List<int> time = timeString.split(':').map(int.parse).toList();

  // Create a DateTime object
  DateTime parsedDateTime = DateTime(date[2], date[1], date[0], time[0], time[1]);
  
  print(parsedDateTime.millisecondsSinceEpoch ~/ 1000);
  // Convert to milliseconds since epoch and return seconds (divide by 1000)
  return parsedDateTime.millisecondsSinceEpoch ~/ 1000;
  
}

String unixEpochTimeTo24HourString(int epochTime) {
  // Create a DateTime object from the epoch time
  final dateTime = DateTime.fromMillisecondsSinceEpoch(epochTime * 1000);

  // Use intl package to format the time in 24-hour format
  final formatter = DateFormat('HH:mm');
  return formatter.format(dateTime);
}


     
    //  listing team members along with punch in/out information
   teamListingScreen() async {
    try {

        final request = TeamListingRequest(
          keyword: "",
          field: "",
          sortOfOrder:"ASC" ,
          page: 0,
          size: 10,);

        final response =
            await ApiRepository.to.teamListing(request: request);

        if (response.status == 200) {
          _teamListing.value = response.data;
          print(response.data);


       

        } else if (response.message == "Failed") {
          debugPrint(response.errors['errorMessage']);
          showErrorSnackbar(message: errorOccuredText);
        }
      
    } catch (e) {
      showErrorSnackbar(message: e.toString());
      debugPrint(e.toString());
    }
  }

   // last punch in

  getLastPunchIn() async {
    try {
      final authService = NMSJWTDecoder();
      final decodedToken = await authService.decodeAuthToken();
      if (decodedToken != null) {
        final userId = decodedToken["userId"];
        final request = LastPunchInRequest(userId: userId);
        final response =
            await ApiRepository.to.lastPunchIn(request: request);
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
          punchOutDateTime: 1720945467,
          punchLocation: "OFFICE",
          projectCode: "NMS",
          task: "Unassigned",
          description: "",
          isOnBreak: false,
          shiftDate: 1720463400
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

     //  User punch Request
   userPunchRequest() async {
    try {
      final authService = NMSJWTDecoder();
      final decodedToken = await authService.decodeAuthToken();
      if (decodedToken != null) {
        final userId = decodedToken["userId"];

        final request = PunchRequestRequest(
          empId: userId,
          shiftDate: 1719081000,
          punchInDateTime: 1719113400,
          punchOutDateTime: 1719145800,
          breakDateTime: 1719127800,
          resumeDateTime: 1719131400,
          punchLocation: "OFFICE",
          projectCode: "NMS",
          task: "Unassigned",
          description: "",
          reasonToChange: "" ,
          isOnBreak: false
          );

        final response =
            await ApiRepository.to.punchRequest(request: request);

        if (response.status == 200) {
          _punchRequestMessage.value = response.data;
          print(punchRequestMessage);
       

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