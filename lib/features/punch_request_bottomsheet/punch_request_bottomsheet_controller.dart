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

  final FocusNode reasonFocusNode = FocusNode();
  final reasonController = TextEditingController();
  var isReasonValid = true.obs;
  var reason = ''.obs;

    var locations = ['WFO', 'WFH', 'On-Site', 'Hybrid'];

    String userId = "";

    void validateForm() {
   isLocationValid.value = selectedLocation.isNotEmpty;
   isReasonValid.value = reason.isNotEmpty;
     }

  void onLocationSelected(String value) {
    selectedLocation.value = value;
    update(); // Update UI whenever selectedLocation changes
  }


   @override
  void onInit() async{
  super.onInit();
  await getIdFromToken();
  print(DateFormat('yyyy-MM-dd').format(selectedDate));

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
   userPunchRequest(BuildContext context) async {
    try {
      final authService = NMSJWTDecoder();
      final decodedToken = await authService.decodeAuthToken();
      if (decodedToken != null) {
        userId = decodedToken["userId"];

        final request = PunchRequestRequest(
          empId: userId,
          shiftDate: DateFormat('yyyy-MM-dd').format(selectedDate),
          // shiftDate: dateTimeToEpoch(DateFormat('dd/MM/yyyy').format(selectedDate), '01:00'),
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
        await Future.delayed(Duration(seconds: 4));
        Navigator.pop(context);
        
       

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

DateTime selectedDate = DateTime.now().subtract(Duration(days: 1)); // Set initial date to yesterday

Future<void> selectDate(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: selectedDate,
    firstDate: DateTime(2018, 1, 1), // Earliest selectable date (you can adjust this)
    lastDate: DateTime.now().subtract(Duration(days: 1)), // Restrict to dates before today
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: ThemeData.light().copyWith(
          colorScheme: ColorScheme.light(
            primary: Colors.green, // Selection color (e.g., selected date circle)
            onPrimary: Colors.white, // Text color inside the selected date circle
            surface: Colors.white, // Background color of the date picker
            onSurface: Colors.black, // Text color for dates
          ),
          dialogBackgroundColor: Colors.white, // Background color of the dialog
        ),
        child: child!,
      );
    },
  );

  if (picked != null && picked != selectedDate) {
    selectedDate = picked;
  }
  update();
}

Future<void> selectDateTwo(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: selectedDate,
    firstDate: DateTime(2018, 1, 1),
    lastDate: DateTime.now().subtract(Duration(days: 1)), // Restrict to dates before today
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: ThemeData.light().copyWith(
          // Customizing the overall color scheme
          colorScheme: ColorScheme.light(
            primary: Colors.green, // Header background color, selection color (e.g., selected date circle)
            onPrimary: Colors.white, // Text color inside the selected date circle
            surface: Colors.white, // Background color of the calendar
            onSurface: Colors.black, // Text color for unselected dates
        
          ),
          // Customizing the dialog background color
          dialogBackgroundColor: Colors.white, // Background color of the dialog
          
          // Customizing the header (e.g., the title bar at the top)
          textTheme: TextTheme(
            headline4: TextStyle(color: Colors.green), // Year selector text color
            subtitle1: TextStyle(color: Colors.black), // Month and day text color in the header
          ),
          
          // Customizing the buttons (OK/Cancel)
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
             
            ),
          ),

          // Customizing the day text style
          datePickerTheme: DatePickerThemeData(
            dayStyle: TextStyle(color: Colors.black), // Default day text color
            todayForegroundColor: MaterialStateProperty.all(Colors.white), // Today date text color
            todayBackgroundColor: MaterialStateProperty.all(Colors.green), // Today date background color
            rangeSelectionBackgroundColor: Colors.green.withOpacity(0.2), // Background color for range selection
          ),

          // Customizing the calendar grid
          
        ),
        child: child!,
      );
    },
  );

  if (picked != null && picked != selectedDate) {
    selectedDate = picked;
  }
  update();
}

String? punchOutValidationMessage;
String? breakValidationMessage;
String? resumeValidationMessage;

void validateTimes() {
  punchOutValidationMessage = null;
  breakValidationMessage = null;
  resumeValidationMessage = null;

  TimeOfDay punchInTime = selectedTimes[0];
  TimeOfDay punchOutTime = selectedTimes[1];
  TimeOfDay breakTime = selectedTimes[2];
  TimeOfDay resumeTime = selectedTimes[3];

  if (punchOutTime.hour < punchInTime.hour || (punchOutTime.hour == punchInTime.hour && punchOutTime.minute <= punchInTime.minute)) {
    punchOutValidationMessage = "Enter a valid Punch-Out time";
  }

  if ((breakTime.hour < punchInTime.hour || (breakTime.hour == punchInTime.hour && breakTime.minute <= punchInTime.minute)) ||
      (breakTime.hour > punchOutTime.hour || (breakTime.hour == punchOutTime.hour && breakTime.minute >= punchOutTime.minute))) {
    breakValidationMessage = "Enter a valid break time";
  }

  if ((resumeTime.hour < breakTime.hour || (resumeTime.hour == breakTime.hour && resumeTime.minute <= breakTime.minute)) ||
      (resumeTime.hour > punchOutTime.hour || (resumeTime.hour == punchOutTime.hour && resumeTime.minute >= punchOutTime.minute))) {
    resumeValidationMessage = "Enter a valid resume time";
  }

  update(); // Notify the UI to update
}




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
  
  //  void showTimePickers(int pickerNumber ,BuildContext context) async {
  //   TimeOfDay? pickedTime = await showTimePicker(
  //     context: context,
  //     initialTime: selectedTimes[pickerNumber],
  //   );

  //   if (pickedTime != null) {
    
  //       selectedTimes[pickerNumber] = pickedTime;
  //          validateTimes();
      
  //   }
  //   update();
  // }

  void showTimePickers(int pickerNumber, BuildContext context) async {
  TimeOfDay? pickedTime = await showTimePicker(
    context: context,
    initialTime: selectedTimes[pickerNumber],
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: ThemeData.light().copyWith(
          timePickerTheme: TimePickerThemeData(
            backgroundColor: Colors.white, // Background color
            hourMinuteShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(color: Color(0xff3BBCA0)), // Border color around hour/minute
            ),
            hourMinuteColor: MaterialStateColor.resolveWith((states) =>
                states.contains(MaterialState.selected)
                    ? Color(0xff3BBCA0) // Selected hour/minute background color
                    : Colors.white), // Unselected hour/minute background color
            dialBackgroundColor: Colors.white, // Dial background color
            dayPeriodColor: MaterialStateColor.resolveWith((states) =>
                states.contains(MaterialState.selected)
                    ? Color(0xff3BBCA0) // Selected AM/PM background color
                    : Colors.white), // Unselected AM/PM background color
            dayPeriodTextColor: MaterialStateColor.resolveWith((states) =>
                states.contains(MaterialState.selected)
                    ? Colors.white // Selected AM/PM text color
                    : Colors.black), // Unselected AM/PM text color
            dialHandColor: Color(0xff3BBCA0), // Dial hand color
            dialTextColor: MaterialStateColor.resolveWith((states) =>
                states.contains(MaterialState.selected)
                    ? Colors.white // Selected dial text color
                    : Colors.black), // Unselected dial text color
            entryModeIconColor: Color(0xff3BBCA0), // Icon color in entry mode
          ),
          textTheme: const TextTheme(
            headlineMedium: TextStyle(color: Colors.black), // Text color
            titleLarge: TextStyle(color: Color(0xff3BBCA0)), // AM/PM selector text color
          ),
          colorScheme: const ColorScheme.light(
            primary: Color(0xff3BBCA0), // Selection color
            onPrimary: Colors.white, // Text color on selection
            surface: Colors.white, // Background color
            onSurface: Colors.black, // Text color
          ),
        ),
        child: child!,
      );
    },
  );

  if (pickedTime != null) {
    selectedTimes[pickerNumber] = pickedTime;
    validateTimes();
  }
  update();
}


  
}