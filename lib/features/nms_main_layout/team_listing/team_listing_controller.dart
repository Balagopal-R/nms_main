import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nms/dtos/api_response.dart';
import 'package:nms/dtos/nms_dtos/last_punch_in_dtos/last_punch_in.dart';
import 'package:nms/managers/sharedpreferences/sharedpreferences.dart';
import 'package:nms/mixins/snackbar_mixin.dart';
import 'package:nms/models/last_punch_in_model/last_punch_in_model.dart';
import 'package:nms/utils/helpers/validation.dart';
import '../../../dtos/nms_dtos/team_listing_dtos/team_listing.dart';
import '../../../models/team_list_model/team_list_model.dart';
import '../../../repository/api_repository.dart';

class TeamListingController extends GetxController with SnackbarMixin {
  
  final TextEditingController searchEmployeeController =
      TextEditingController();

  final _teamListingRes = Rx<TeamListingResponse?>(null);
  TeamListingResponse? get teamListingRes => _teamListingRes.value;

  final _teamListing = (List<TeamListingModel>.empty()).obs;
  List<TeamListingModel> get teamListing => _teamListing;

   final _teamListingContent = (List<TeamListingModel>.empty()).obs;
  List<TeamListingModel> get teamListingContent => _teamListingContent;

  final _getEmployPunchIn = Rx<LastPunchInModel?>(null);
  LastPunchInModel? get getEmployPunchIn => _getEmployPunchIn.value;

  final _getTeamPagination = Rx<Pagination?>(null);
  Pagination? get getTeamPagination => _getTeamPagination.value;

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  int isPageno = 0;

  final teamListingScrollController = ScrollController();

  @override
  void onInit() async {

    await initialFetching();
    teamListingScrollController.addListener(() {
      if (!isLoading &&
          teamListingScrollController.position.pixels ==
              teamListingScrollController.position.maxScrollExtent) {
        print('here');
        fetchNextPage();
      }
    });
    await getLastPunchIn();
    super.onInit();
  }

  String epochToTimeString(int? epochTime) {
    if (epochTime == null) {
      return '--:--';
    }

    // Convert epoch time to DateTime object
    final dateTime = DateTime.fromMillisecondsSinceEpoch(epochTime * 1000);

    // Use DateFormat to format the time string in 24-hour format
    final formattedTime = DateFormat('HH:mm').format(dateTime);

    return formattedTime;
  }

  //  listing team members along with punch in/out information
  teamListingScreen() async {
    print('page:${isPageno}');
    _isLoading.value = true;
    _teamListing.value = [];
    try {
      final request = TeamListingRequest(
        keyword: "",
        field: "",
        sortOfOrder: "ASC",
        page: isPageno,
        size: 10,
      );

      final response = await ApiRepository.to.teamListing(request: request);

      if (response.status == 200) {
        print(isPageno);
        _teamListing.value = response.data;
        _getTeamPagination.value = response.pagination;
        isPageno = isPageno+1;
        debugPrint('pagination:${getTeamPagination}');
        if (response.pagination == null) {
          print('Pagination is null');
        } else {
          print('Total pages: ${response.pagination?.totalPages}');
        }

        if (teamListing.isNotEmpty) {
          for (int i = 0; i < teamListing.length; i++) {
            _teamListingContent.add(teamListing[i]);
          }
          debugPrint(teamListingContent.toString());
        } else {}
        _isLoading.value = false;
        update();
      } else if (response.message == "Failed") {
        _isLoading.value = false;
        debugPrint(response.errors['errorMessage']);
        showErrorSnackbar(message: errorOccuredText);
        update();
      }
    } catch (e) {
      _isLoading.value = false;
      showErrorSnackbar(message: e.toString());
      debugPrint(e.toString());
      update();
    }
  }

  @override
  void dispose() {
    // _isPageno.value = 0;
    teamListingScrollController.dispose();
    super.dispose();
  }

  initialFetching() async {
    _teamListing.clear();
    // _isPageno.value = 0;
    await teamListingScreen();
  }

  fetchNextPage() async {
    debugPrint(getTeamPagination!.totalPages.toString());
    if (isPageno <= 4) {
      await teamListingScreen();
    } else {}
  }

  Color getColorBasedOnConditions(
    bool condition1,
    bool condition2,
  ) {
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
    } else if (condition1 == 'BREAK') {
      return Color(0XFFFEFAF3);
    } else if (condition1 == 'ABSENT') {
      return Color(0XFFF1F1F1);
    } else if (condition1 == 'LEAVE') {
      return Color(0XFFDFDFFB);
    } else if (condition1 == 'OUT') {
      return Color(0XFFFFF0F0);
    } else {
      return Color(0XFFFFF0F0);
    }
  }

  Color getColorBasedOnPunchStatus(String condition1) {
    if (condition1 == 'ON-TIME') {
      return Color(0XFF2F9680);
    } else if (condition1 == 'LATE') {
      return Color(0XFFFF4646);
    } else if (condition1 == 'BREAK') {
      return Color(0XFFECB35D);
    } else if (condition1 == 'ABSENT') {
      return Color(0XFFB7B7B7);
    } else if (condition1 == 'LEAVE') {
      return Color(0XFF605DEC);
    } else if (condition1 == 'OUT') {
      return Color(0XFFFF4646);
    } else {
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
        final response = await ApiRepository.to.lastPunchIn(request: request);
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
