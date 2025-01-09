import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nms/mixins/snackbar_mixin.dart';
import 'package:nms/utils/helpers/validation.dart';
import 'package:nms/utils/theme/theme_constants.dart';
import '../../../dtos/nms_dtos/team_listing_dtos/team_listing.dart';
import '../../../models/team_list_model/team_list_model.dart';
import '../../../repository/api_repository.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class TeamListingController extends GetxController with SnackbarMixin {
  final _teamListing = (List<TeamListingModel>.empty()).obs;
  List<TeamListingModel> get teamListing => _teamListing;

  static const _pageSize = 10;
  final PagingController<int, TeamListingModel> pagingController =
      PagingController(firstPageKey: 0);

  @override
  void onInit() async {
    pagingController.addPageRequestListener((pageKey) {
      teamListingScreenPagination(pageKey);
    });
    // Trigger the initial page load
    pagingController.refresh();
    super.onInit();
  }

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
      return lightGreenTextColor;
    } else {
      return darkRed;
    }
  }

  Color getContainerColorBasedOnPunchStatus(String condition1) {
    if (condition1 == 'ON_TIME') {
      return veryLightGreenColor;
    } else if (condition1 == 'LATE') {
      return lightRed;
    } else if (condition1 == 'BREAK') {
      return containerYellow;
    } else if (condition1 == 'ABSENT') {
      return veryLightGray;
    } else if (condition1 == 'LEAVE') {
      return veryLightShadeBlue;
    } else if (condition1 == 'OUT') {
      return lightRed;
    } else {
      return lightRed;
    }
  }

  Color getColorBasedOnPunchStatus(String condition1) {
    if (condition1 == 'ON_TIME') {
      return darkShadeGreen;
    } else if (condition1 == 'LATE') {
      return primaryRed;
    } else if (condition1 == 'BREAK') {
      return veryDarkShadeYellow;
    } else if (condition1 == 'ABSENT') {
      return primaryGray;
    } else if (condition1 == 'LEAVE') {
      return lightShadeBlue;
    } else if (condition1 == 'OUT') {
      return primaryRed;
    } else {
      return primaryRed;
    }
  }

  String capitalizeFirstLetter(String text) {
    if (text.isEmpty) return text;

    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

}
