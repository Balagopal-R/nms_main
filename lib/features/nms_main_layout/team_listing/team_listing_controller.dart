import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:nms/dtos/nms_dtos/last_punch_in_dtos/last_punch_in.dart';
import 'package:nms/managers/refresh_token_api/refresh_token_api.dart';
import 'package:nms/managers/refresh_token_expiry/refresh_token_expiry.dart';
import 'package:nms/managers/sharedpreferences/sharedpreferences.dart';
import 'package:nms/mixins/snackbar_mixin.dart';
import 'package:nms/models/last_punch_in_model/last_punch_in_model.dart';
import 'package:nms/utils/helpers/validation.dart';
import '../../../dtos/nms_dtos/team_listing_dtos/team_listing.dart';
import '../../../models/team_list_model/team_list_model.dart';
import '../../../repository/api_repository.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class TeamListingController extends GetxController with SnackbarMixin {
  final _teamListing = (List<TeamListingModel>.empty()).obs;
  List<TeamListingModel> get teamListing => _teamListing;

  final _getEmployPunchIn = Rx<LastPunchInModel?>(null);
  LastPunchInModel? get getEmployPunchIn => _getEmployPunchIn.value;

  static const _pageSize = 10;
  final PagingController<int, TeamListingModel> pagingController =
      PagingController(firstPageKey: 0);

  @override
  void onInit() async {
    // await teamListingScreen();
    // await getIdFromToken();
    pagingController.addPageRequestListener((pageKey) {
      teamListingScreenPagination(pageKey);
    });
    // Trigger the initial page load
    pagingController.refresh();
    await getLastPunchIn();
    super.onInit();
  }

  // String userId = "";

  RxBool isSearching = false.obs;
  void toggleSearch() {
    isSearching.value = !isSearching.value;
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

  //   getIdFromToken() async {
  //   await RefreshTokenExpiryChecker().refreshTokenExpiryChecker();
  //   await RefreshTokenApiCall().checkTokenExpiration();
  //   final authToken = await NMSSharedPreferences().getTokenFromPrefs();
  //   if (authToken != null) {
  //     Map<String, dynamic> decodedToken = JwtDecoder.decode(authToken);
  //     String uid = decodedToken["userId"];
  //     userId = uid;
  //     debugPrint("user id is ------$userId");
  //   }
  // }

  //  listing team members along with punch in/out information with Pagination
  Future<void> teamListingScreenPagination(int pageKey) async {
    try {
      final request = TeamListingRequest(
        keyword: "",
        field: "",
        sortOfOrder: "ASC",
        page: pageKey,
        size: _pageSize,
      );

      final response = await ApiRepository.to.teamListing(request: request);

      if (response.status == 200) {
        final isLastPage = response.pagination?.totalPages == pageKey;
        if (isLastPage) {
          pagingController.appendLastPage(response.data);
        } else {
          final nextPageKey = pageKey + 1;
          pagingController.appendPage(response.data, nextPageKey);
        }
        // pagingController.appendPage(response.data , pageKey+1);
        _teamListing.addAll(response.data);
        update();
      } else if (response.message == "Failed") {
        debugPrint(response.errors['errorMessage']);
        showErrorSnackbar(message: errorOccuredText);
        update();
      }
    } catch (e) {
      pagingController.error = e.toString();
      showErrorSnackbar(message: e.toString());
      debugPrint(e.toString());
      update();
    }
  }

  //  listing team members along with punch in/out information
  // teamListingScreen() async {

  //   try {
  //     final request = TeamListingRequest(
  //       keyword: "",
  //       field: "",
  //       sortOfOrder: "ASC",
  //       page: 0,
  //       size: 10,
  //     );

  //     final response = await ApiRepository.to.teamListing(request: request);

  //     if (response.status == 200) {
  //       _teamListing.value = response.data;

  //       update();
  //     } else if (response.message == "Failed") {

  //       debugPrint(response.errors['errorMessage']);
  //       showErrorSnackbar(message: errorOccuredText);
  //       update();
  //     }
  //   } catch (e) {

  //     showErrorSnackbar(message: e.toString());
  //     debugPrint(e.toString());
  //     update();
  //   }
  // }

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
    if (condition1 == 'ON_TIME') {
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
    if (condition1 == 'ON_TIME') {
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
      debugPrint(e.toString());
    }
  }
}
