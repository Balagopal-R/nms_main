import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:nms/dtos/nms_dtos/last_punch_in_dtos/last_punch_in.dart';
import 'package:nms/dtos/nms_dtos/punch_in_dtos/punch_in.dart';
import 'package:nms/dtos/nms_dtos/punch_out_dtos/punch_out.dart';
import 'package:nms/managers/refresh_token_api/refresh_token_api.dart';
import 'package:nms/managers/refresh_token_expiry/refresh_token_expiry.dart';
import 'package:nms/managers/sharedpreferences/sharedpreferences.dart';
import 'package:nms/models/last_punch_in_model/last_punch_in_model.dart';
import 'package:nms/repository/api_repository.dart';
import '../../dtos/nms_dtos/project_search_dtos/project_search.dart';
import '../../mixins/snackbar_mixin.dart';
import '../../models/project_search_model/project_search_model.dart';
import '../../utils/helpers/validation.dart';

class PunchInOutBottomSheetController extends GetxController with SnackbarMixin{

  var selectedLocation = ''.obs;
  var selectedProject = ''.obs;
  var task = ''.obs;

  var isLocationValid = true.obs;
  var isProjectValid = true.obs;
  var isTaskValid = true.obs;

   RxBool isTaskOrDescriptionFocused = false.obs;
  final FocusNode taskFocusNode = FocusNode();
  final FocusNode descriptionFocusNode = FocusNode();

  String userId = "";


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

    final _getEmployPunchIn = Rx<LastPunchInModel?>(null);
  LastPunchInModel? get getEmployPunchIn => _getEmployPunchIn.value;

  final _projectSearch = (List<ProjectSearchModel>.empty()).obs;
  List<ProjectSearchModel> get projectSearch => _projectSearch;

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
  await getIdFromToken();
  await getLastPunchIn();
  await getProjectSearch();
   clearErrors();
 
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
          // print(getEmployPunchIn?.projectId);
          // print(getEmployPunchIn?.taskId);
          // print(getEmployPunchIn?.punchLocation);
        }
      }
    } catch (e) {
      showErrorSnackbar(message: e.toString());
      debugPrint(e.toString());
    }
  }

    getProjectSearch() async {
    try {
      final authService = NMSJWTDecoder();
      final decodedToken = await authService.decodeAuthToken();
      if (decodedToken != null) {
        final userId = decodedToken["userId"];

        final request = ProjectSearchRequest(
          field: "createdAt",
          sortOfOrder: "ASC",
          page: 0,
          size: 100,
          isArchived: false,
          isDeleted: false,
          userId: userId,
          );

        final response = await ApiRepository.to.projectSearch(request: request);
        if (response.status == 200) {
          _projectSearch.value = response.data;
          print('Baluuu');

        }
      }
    } catch (e) {
      showErrorSnackbar(message: e.toString());
      debugPrint(e.toString());
    }
  }




    //  user punch in
   userPunchIn(BuildContext context) async {
    try {
      final authService = NMSJWTDecoder();
      final decodedToken = await authService.decodeAuthToken();
      if (decodedToken != null) {
         userId = decodedToken["userId"];
        
        final request = PunchInRequest(
          empId: userId,
          punchInDateTime: dateTimeToEpoch(formattedDate, formattedTime),
          punchLocation: selectedLocation.value,
          projectCode: selectedProject.value,
          task: taskController.text,
          description: descriptionController.text,
          isOnBreak: false,
          shiftDate: '2024-09-03',
          );

        final response =
            await ApiRepository.to.punchIn(request: request);

        if (response.status == 200) {
        
        showSuccessSnackbar(title: 'Success', message:'You have successfully Punched IN') ;
          _punchInMessage.value = response.data;
         await Future.delayed(const Duration(seconds: 4));
        // ignore: use_build_context_synchronously
        Navigator.pop(context);

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
   userPunchOut(BuildContext context) async {
    try {
      final authService = NMSJWTDecoder();
      final decodedToken = await authService.decodeAuthToken();
      if (decodedToken != null) {
        userId = decodedToken["userId"];

        final request = PunchOutRequest(
          empId: userId,
          punchOutDateTime: dateTimeToEpoch(formattedDate, formattedTime),
          punchLocation: selectedLocation.value,
          projectCode: selectedProject.value,
          task: "Unassigned",
          description: "",
          isOnBreak: false,
          shiftDate: '2024-09-03',
          );

        final response =
            await ApiRepository.to.punchOut(request: request);

        if (response.status == 200) {
          _punchOutMessage.value = response.data;
          showSuccessSnackbar(title: 'Success', message:'You have successfully Punched OUT') ;
       await Future.delayed(const Duration(seconds: 4));
        // ignore: use_build_context_synchronously
        Navigator.pop(context); 

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