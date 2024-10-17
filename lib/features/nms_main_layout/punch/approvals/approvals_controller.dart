import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nms/dtos/nms_dtos/last_punch_in_dtos/last_punch_in.dart';
import 'package:nms/managers/sharedpreferences/sharedpreferences.dart';
import 'package:nms/mixins/snackbar_mixin.dart';
import 'package:nms/models/punch_approvals_model/punch_approvals_model.dart';
import 'package:nms/repository/api_repository.dart';
import 'package:nms/utils/helpers/validation.dart';
import 'package:nms/utils/theme/theme.dart';
import '../../../../dtos/nms_dtos/punch_approval_pending_request_dtos/punch_approval_pending_request.dart';
import '../../../../dtos/nms_dtos/punch_approvals_dtos/punch_approvals.dart';
import '../../../../dtos/nms_dtos/punch_request_cancel_dtos/punch_request_cancel.dart';
import '../../../../models/last_punch_in_model/last_punch_in_model.dart';
import '../../../../models/punch_approval_pending_request_model/punch_approval_pending_request_model.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ApprovalsController extends GetxController with SnackbarMixin {
  final _getEmployPunchIn = Rx<LastPunchInModel?>(null);
  LastPunchInModel? get getEmployPunchIn => _getEmployPunchIn.value;

  final _punchApprovals = (List<PunchApprovalsModel>.empty()).obs;
  List<PunchApprovalsModel> get punchApprovals => _punchApprovals;

  final _punchApprovalsViewRequest =
      Rx<PunchApprovalPendingRequestModel?>(null);
  PunchApprovalPendingRequestModel? get punchApprovalsViewRequest =>
      _punchApprovalsViewRequest.value;

  final _punchRequestCancel = ''.obs;
  String get punchRequestCancel => _punchRequestCancel.value;

  static const _pageSize = 10;
  final PagingController<int, PunchApprovalsModel> pagingController =
      PagingController(firstPageKey: 0);

  @override
  void onInit() async {
    super.onInit();
    pagingController.addPageRequestListener((pageKey) {
      userPunchApprovals(pageKey);
    });
    // Trigger the initial page load
    pagingController.refresh();
  }

  String formatDate(String dateString) {
    final DateTime dateTime = DateTime.parse(dateString);
    final DateFormat formatter = DateFormat('MMM dd');
    return formatter.format(dateTime);
  }

  String formatEpochToDateString(int epoch) {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(epoch);
    final formatter = DateFormat('dd MMM yyyy');
    return formatter.format(dateTime);
  }

  String formatEpochToMiniDateString(int epoch) {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(
        epoch * 1000); // Convert epoch to milliseconds
    final formatter = DateFormat('MMM dd');
    return formatter.format(dateTime);
  }

  String formatEpochToTimeStringIN(int epoch, String method) {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(epoch * 1000);
    final formatter = DateFormat('HH:mm');
    return '$method - ${formatter.format(dateTime)}';
  }

  String formatEpochToTimeString(int? epoch) {
    if (epoch == null) {
      return "--:--";
    }

    final dateTime = DateTime.fromMillisecondsSinceEpoch(epoch * 1000);
    final formatter = DateFormat('HH:mm');
    return formatter.format(dateTime);
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

  // listing punch approvals with Pagination
  Future<void> userPunchApprovals(int pageKey) async {
    try {
      final authService = NMSJWTDecoder();
      final decodedToken = await authService.decodeAuthToken();
      if (decodedToken != null) {
        final userId = decodedToken["userId"];
        final request = PunchApprovalsRequest(
          field: "createdAt",
          sortOfOrder: "ASC",
          page: pageKey,
          size: _pageSize,
          userId: userId,
        );

        final response =
            await ApiRepository.to.punchApprovals(request: request);
        if (response.status == 200) {
          final isLastPage = response.pagination.totalPages == pageKey;
          if (isLastPage) {
            pagingController.appendLastPage(response.data);
          } else {
            final nextPageKey = pageKey + 1;
            pagingController.appendPage(response.data, nextPageKey);
          }
          // pagingController.appendPage(response.data , pageKey+1);
          _punchApprovals.addAll(response.data);
          update();
        } else if (response.message == "Failed") {
          pagingController.error = errorOccuredText;
          showErrorSnackbar(message: errorOccuredText);
          update();
        }
      }
    } catch (e) {
      pagingController.error = e.toString();
      showErrorSnackbar(message: e.toString());
      debugPrint(e.toString());
      update();
    }
  }

  //  listing Punch Approvals View Request
  userPunchApprovalViewRequest(int id) async {
    try {
      final request = PunchApprovalPendingRequest(id: id);

      final response =
          await ApiRepository.to.punchApprovalsRequestView(request: request);

      if (response.status == 200) {
        _punchApprovalsViewRequest.value = response.data;

        update();
      } else if (response.message == "Failed") {
        showErrorSnackbar(message: errorOccuredText);
        update();
      }
    } catch (e) {
      showErrorSnackbar(message: e.toString());
      debugPrint(e.toString());
      update();
    }
  }

  // Punch Request Cancel
  userPunchRequestCancel(int id) async {
    try {
      final request = PunchRequestCancelRequest(punchRequestId: id);

      final response =
          await ApiRepository.to.punchRequestCancel(request: request);

      if (response.status == 200) {
        _punchRequestCancel.value = response.data;
        showSuccessSnackbar(
            title: 'Success', message: 'Punch Approval Request Cancelled');

        update();
        onInit();
      } else if (response.message == "Failed") {
        showErrorSnackbar(message: errorOccuredText);
        update();
      }
    } catch (e) {
      showErrorSnackbar(message: e.toString());
      debugPrint(e.toString());
      update();
    }
  }

  String checkPunchLogInOut(
      punchApprovalsViewRequest, int index, bool isPunchIn) {
    if (punchApprovalsViewRequest.punchLog == null ||
        punchApprovalsViewRequest.punchLog.isEmpty) {
      // Return underscore if punchLog is empty or null
      return '_';
    } else {
      // Check whether to return punchInDateTime or punchOutDateTime
      if (isPunchIn) {
        return formatEpochToTimeString(
            punchApprovalsViewRequest.punchLog[index].punchInDateTime);
      } else {
        return formatEpochToTimeString(
            punchApprovalsViewRequest.punchLog[index].punchOutDateTime);
      }
    }
  }

  String checkPunchLogBreakOrResume(
      punchApprovalsViewRequest, bool isBreakStart) {
    if (punchApprovalsViewRequest.punchLog == null ||
        punchApprovalsViewRequest.punchLog.isEmpty) {
      // Return underscore if punchLog is empty or null
      return '_';
    } else {
      // Loop through punchLog to find the entry where isOnBreak is true
      for (var log in punchApprovalsViewRequest.punchLog) {
        if (log.isOnBreak) {
          // Return punchInDateTime if isBreakStart is true, otherwise return punchOutDateTime
          return isBreakStart
              ? formatEpochToTimeString(log.punchInDateTime)
              : formatEpochToTimeString(log.punchOutDateTime);
        }
      }

      // If no entry with isOnBreak is found, return underscore
      return '_';
    }
  }

  String checkPunchLocation(punchApprovalsViewRequest) {
    if (punchApprovalsViewRequest.punchLog == null ||
        punchApprovalsViewRequest.punchLog.isEmpty) {
      // Return underscore if punchLog is empty or null
      return '_';
    } else {
      // Return the punchInDateTime of the first entry
      return punchApprovalsViewRequest!.punchLog[0].punchLocation.toString();
    }
  }

  Color getContainerColorBasedOnApprovalStatus(String condition1) {
    if (condition1 == 'ACCEPTED') {
      return veryLightGreenColor;
    } else if (condition1 == 'PENDING') {
      return lightRed;
    } else if (condition1 == 'REJECTED') {
      return containerYellow;
    } else if (condition1 == 'REGULARIZED') {
      return veryLightGray;
    } else if (condition1 == 'CANCELLED') {
      return veryLightShadeBlue;
    } else if (condition1 == 'REVOKED') {
      return lightRed;
    } else {
      return lightRed;
    }
  }

  Color getColorBasedOnApprovalStatus(String condition1) {
    if (condition1 == 'ACCEPTED') {
      return darkShadeGreen;
    } else if (condition1 == 'PENDING') {
      return primaryRed;
    } else if (condition1 == 'REJECTED') {
      return veryDarkShadeYellow;
    } else if (condition1 == 'REGULARIZED') {
      return primaryGray;
    } else if (condition1 == 'CANCELLED') {
      return lightShadeBlue;
    } else if (condition1 == 'REVOKED') {
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
