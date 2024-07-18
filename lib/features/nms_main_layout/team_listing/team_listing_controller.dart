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

  

   @override
  void onInit() async{

  await teamListingScreen();
  await getLastPunchIn();
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
          update();


       

        } else if (response.message == "Failed") {
          debugPrint(response.errors['errorMessage']);
          showErrorSnackbar(message: errorOccuredText);
          update();
        }
      
    } catch (e) {
      showErrorSnackbar(message: e.toString());
      debugPrint(e.toString());
      update();
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

  

   

}