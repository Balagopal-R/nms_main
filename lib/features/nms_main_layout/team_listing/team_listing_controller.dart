import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nms/dtos/nms_dtos/last_punch_in_dtos/last_punch_in.dart';
import 'package:nms/managers/sharedpreferences/sharedpreferences.dart';
import 'package:nms/mixins/snackbar_mixin.dart';
import 'package:nms/models/last_punch_in_model/last_punch_in_model.dart';
import 'package:nms/utils/helpers/validation.dart';
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

  String epochToTimeString(int? epochTime) {
  if (epochTime == null) {
    return '--:--';
  }

  // Convert epoch time to DateTime object
  final dateTime = DateTime.fromMillisecondsSinceEpoch(epochTime);

  // Use DateFormat to format the time string in 24-hour format
  final formattedTime = DateFormat('HH:mm').format(dateTime);

  return formattedTime;
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

Color getColorBasedOnConditions(bool condition1, bool condition2,) {
  if (condition1 && condition2) {
    return Colors.green;
  } else {
    return Colors.red;
  }
}

Color getContainerColorBasedOnPunchStatus(String condition1) {
  if (condition1 == 'ON-TIME') {
    return Color(0XFFBEFFE8);
  } else if (condition1 == 'LATE') {
    return Color(0XFFFFF0F0);
  }
  else if (condition1 == 'BREAK') {
    return Color(0XFFFEFAF3);
  }
  else if (condition1 == 'ABSENT') {
    return Color(0XFFF1F1F1);
  }
  else if (condition1 == 'LEAVE') {
    return Color(0XFFDFDFFB);
  }
  else if (condition1 == 'OUT') {
    return Color(0XFFFFF0F0);
  }
  else {
    return Color(0XFFFFF0F0);
  }
}

Color getColorBasedOnPunchStatus(String condition1) {
  if (condition1 == 'ON-TIME') {
    return Color(0XFF2F9680);
  } else if (condition1 == 'LATE') {
    return Color(0XFFFF4646);
  }
  else if (condition1 == 'BREAK') {
    return Color(0XFFECB35D);
  }
  else if (condition1 == 'ABSENT') {
    return Color(0XFFB7B7B7);
  }
  else if (condition1 == 'LEAVE') {
    return Color(0XFF605DEC);
  }
  else if (condition1 == 'OUT') {
    return Color(0XFFFF4646);
  }
  else {
    return Color(0XFFFF4646);
  }
}

String capitalizeFirstLetter(String text) {
  if (text.isEmpty) return text;

  return text[0].toUpperCase() + text.substring(1).toLowerCase();
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