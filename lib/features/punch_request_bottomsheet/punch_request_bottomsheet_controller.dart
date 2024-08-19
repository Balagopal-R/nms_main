import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:nms/managers/refresh_token_api/refresh_token_api.dart';
import 'package:nms/managers/refresh_token_expiry/refresh_token_expiry.dart';
import 'package:nms/managers/sharedpreferences/sharedpreferences.dart';
import 'package:nms/mixins/snackbar_mixin.dart';
import 'package:intl/intl.dart';
import 'package:nms/repository/api_repository.dart';
import 'package:nms/utils/helpers/validation.dart';

import '../../dtos/nms_dtos/punch_request_dtos/punch_request.dart';

class PunchRequestBottomSheetController extends GetxController with SnackbarMixin{

  final _punchRequestMessage = ''.obs;
  String get punchRequestMessage => _punchRequestMessage.value;

  final selectedLocation = ''.obs;
  var isLocationValid = true.obs;

    var locations = ['WFO', 'WFH', 'On-Site', 'Hybrid'];

    String userId = "";

    void validateForm() {
   isLocationValid.value = selectedLocation.isNotEmpty;
     }

  void onLocationSelected(String value) {
    selectedLocation.value = value;
    update(); // Update UI whenever selectedLocation changes
  }

  final reasonController = TextEditingController();


   @override
  void onInit() async{
  super.onInit();
  await getIdFromToken();

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

    //  User punch Request
   userPunchRequest() async {
    try {
      final authService = NMSJWTDecoder();
      final decodedToken = await authService.decodeAuthToken();
      if (decodedToken != null) {
        userId = decodedToken["userId"];

        final request = PunchRequestRequest(
          empId: userId,
          shiftDate: dateTimeToEpoch(DateFormat('dd/MM/yyyy').format(selectedDate), '01:00'),
          punchInDateTime: dateTimeToEpoch(DateFormat('dd/MM/yyyy').format(selectedDate), formatTime24Hour(selectedTimes[0])),
          punchOutDateTime: dateTimeToEpoch(DateFormat('dd/MM/yyyy').format(selectedDate), formatTime24Hour(selectedTimes[1])),
          breakDateTime: dateTimeToEpoch(DateFormat('dd/MM/yyyy').format(selectedDate), formatTime24Hour(selectedTimes[2])),
          resumeDateTime: dateTimeToEpoch(DateFormat('dd/MM/yyyy').format(selectedDate), formatTime24Hour(selectedTimes[3])),
          punchLocation: selectedLocation.value,
          projectCode: "NMS",
          task: "Unassigned",
          description: "",
          reasonToChange: reasonController.text ,
          isOnBreak: false
          );

        final response =
            await ApiRepository.to.punchRequest(request: request);

        if (response.status == 200) {
          _punchRequestMessage.value = response.data;
          print(punchRequestMessage);
        showSuccessSnackbar(title: 'Success', message:'You have successfully submitted a new Punch request') ;
       

        } else if (response.message == "Failed") {
          debugPrint(response.errors['errorMessage']);
          showErrorSnackbar(message: errorOccuredText);
        }
      }
    } catch (e) {
      
      showErrorSnackbar(message: e.toString());
      showErrorSnackbar(message: 'Failed to submit a new Punch request');
    }
  }


 DateTime selectedDate = DateTime.now(); 

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2018, 1, 1),
      lastDate: DateTime(2100, 12, 31),
    );
    if (picked != null && picked != selectedDate) {
      
        selectedDate = picked;
    }
    update();
    
  }
  // void updateContext(BuildContext context) {
  //   // You can now use the context here
  // }

     String formatTime24Hour(TimeOfDay time) {
    // Format the time as a two-digit string in 24-hour format
    return "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
  }

   List<TimeOfDay> selectedTimes = [
    TimeOfDay(hour: 9, minute: 0), // Punch In Time
    TimeOfDay(hour: 18, minute: 0), // Punch Out Time
    TimeOfDay(hour: 13, minute: 0), // Break
    TimeOfDay(hour: 14, minute: 0), // Resume
  ];
  
   void showTimePickers(int pickerNumber ,BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTimes[pickerNumber],
    );

    if (pickedTime != null) {
    
        selectedTimes[pickerNumber] = pickedTime;
      
    }
    update();
  }

  
}