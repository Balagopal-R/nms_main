import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nms/dtos/nms_dtos/punch_in_dtos/punch_in.dart';
import 'package:nms/dtos/nms_dtos/punch_out_dtos/punch_out.dart';
import 'package:nms/managers/sharedpreferences/sharedpreferences.dart';
import 'package:nms/repository/api_repository.dart';
import '../../mixins/snackbar_mixin.dart';
import '../../utils/helpers/validation.dart';

class PunchInOutBottomSheetController extends GetxController with SnackbarMixin{

  var selectedLocation = ''.obs;
  var selectedProject = ''.obs;
  var task = ''.obs;

  var isLocationValid = true.obs;
  var isProjectValid = true.obs;
  var isTaskValid = true.obs;


  var locations = ['WFO', 'WFH', 'On-Site', 'Hybrid'];
  var projects = ['NMS', 'KESHER', 'Premium Shop', 'NMS Chat','Winemonger','Quotely','Just Borrow','Cakesys','Unassigned','Trybond'];

  void validateForm() {
    isLocationValid.value = selectedLocation.isNotEmpty;
    isProjectValid.value = selectedProject.isNotEmpty;
    isTaskValid.value = task.isNotEmpty;
  }
  void onProjectSelected(String value) {
    selectedProject.value = value;
    update(); // Update the UI whenever selectedProject changes
  }

  

  void onLocationSelected(String value) {
    selectedLocation.value = value;
    update(); // Update UI whenever selectedLocation changes
  }

    final _punchInMessage = ''.obs;
  String get punchInMessage => _punchInMessage.value;

  final _punchOutMessage = ''.obs;
  String get punchOutMessage => _punchOutMessage.value;

  final taskController = TextEditingController();
  final descriptionController = TextEditingController();

  String get formattedDate {
    final today = DateTime.now();
    return DateFormat('dd/MM/yyyy').format(today);
  }

  String get formattedTime {
    final now = DateTime.now();
    return DateFormat('HH:mm').format(now);
  }

  final locationError = RxString('');
  final projectError = RxString('');
  final taskError = RxString('');

  // Method to show validation error
  void showValidationError(String errorMessage) {
    if (errorMessage == 'Select Location') {
      locationError.value = errorMessage;
    } else if (errorMessage == 'Select Project') {
      projectError.value = errorMessage;
    } else if (errorMessage == 'Enter a Task') {
      taskError.value = errorMessage;
    }
  }

  // Clear error messages when fields are valid
  void clearErrors() {
    locationError.value = '';
    projectError.value = '';
    taskError.value = '';
  }
  



   @override
  void onInit() async{
  super.onInit();
   clearErrors();
 
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


    //  user punch in
   userPunchIn() async {
    try {
      final authService = NMSJWTDecoder();
      final decodedToken = await authService.decodeAuthToken();
      if (decodedToken != null) {
        final userId = decodedToken["userId"];

        final request = PunchInRequest(
          empId: userId,
          punchInDateTime: dateTimeToEpoch(formattedDate, formattedTime),
          punchLocation: selectedLocation.value,
          projectCode: selectedProject.value,
          task: taskController.text,
          description: descriptionController.text,
          isOnBreak: false,
          shiftDate: dateTimeToEpoch(formattedDate, "01:00"),
          );

        final response =
            await ApiRepository.to.punchIn(request: request);

        if (response.status == 200) {
        showSuccessSnackbar(title: 'Success', message:'You have successfully Punched IN') ;
       
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
          punchOutDateTime: dateTimeToEpoch(formattedDate, formattedTime),
          punchLocation: selectedLocation.value,
          projectCode: selectedProject.value,
          task: "Unassigned",
          description: "",
          isOnBreak: false,
          shiftDate: dateTimeToEpoch(formattedDate, "01:00"),
          );

        final response =
            await ApiRepository.to.punchOut(request: request);

        if (response.status == 200) {
          _punchOutMessage.value = response.data;
          print(punchOutMessage);
          showSuccessSnackbar(title: 'Success', message:'You have successfully Punched OUT') ;
       

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