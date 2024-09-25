import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:nms/dtos/nms_dtos/leave_request_cancel_dtos/leave_request_cancel.dart';
import 'package:nms/managers/sharedpreferences/sharedpreferences.dart';
import 'package:nms/mixins/snackbar_mixin.dart';
import 'package:nms/models/leave_approvals_model/leave_approvals_model.dart';
import 'package:nms/repository/api_repository.dart';
import 'package:nms/utils/helpers/validation.dart';
import '../../../../dtos/nms_dtos/leave_approvals_dtos/leave_approvals.dart';

class ApprovalsLeaveController extends GetxController with SnackbarMixin {

  static const _pageSize = 10;
  final PagingController<int, LeaveApprovalsModel> pagingController =
      PagingController(firstPageKey: 0);

    final _leaveApprovals = (List<LeaveApprovalsModel>.empty()).obs;
  List<LeaveApprovalsModel> get leaveApprovals => _leaveApprovals;

    final _leaveRequestCancel = ''.obs;
  String get leaveRequestCancel => _leaveRequestCancel.value;

      
  @override
  void onInit() async {
    super.onInit();
    // await getIdFromToken();
    pagingController.addPageRequestListener((pageKey) {
      userLeaveApprovals(pageKey);
    });
    pagingController.refresh();
  }

  String getStatusText(String status, String nameOne, String nameTwo) {
  if (status == 'PENDING') {
    return '-';
  } else {
    return '$nameOne $nameTwo';
  }
}

  

  // listing leave approvals with Pagination
  Future<void> userLeaveApprovals(int pageKey) async {
    try {
      final authService = NMSJWTDecoder();
      final decodedToken = await authService.decodeAuthToken();
      if (decodedToken != null) {
        final userId = decodedToken["userId"];
        final request = LeaveApprovalsRequest(
          field: "createdAt",
          sortOfOrder: "ASC",
          page: pageKey,
          size: _pageSize,
          userId: userId,
        );

        final response =
            await ApiRepository.to.leaveApprovals(request: request);
        if (response.status == 200) {
          final isLastPage = response.pagination?.totalPages == pageKey;
          if (isLastPage) {
            pagingController.appendLastPage(response.data);
          } else {
            final nextPageKey = pageKey + 1;
            pagingController.appendPage(response.data, nextPageKey);
          }
          // pagingController.appendPage(response.data , pageKey+1);
          _leaveApprovals.addAll(response.data);
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

    // Leave Request Cancel
  userLeaveRequestCancel(int id) async {
    try {
      final request = LeaveRequestCancelRequest(leaveRequestId: id);

      final response =
          await ApiRepository.to.leaveRequestCancel(request: request);

      if (response.status == 200) {
        _leaveRequestCancel.value = response.data;
        showSuccessSnackbar(
            title: 'Success', message: 'Leave Request Cancelled');

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

    String formatEpochToDateString(int epoch) {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(epoch);
    final formatter = DateFormat('dd MMM yyyy');
    return formatter.format(dateTime);
  }

  String formatDate(String dateString) {
  DateTime dateTime = DateTime.parse(dateString);
  DateFormat format = DateFormat('d MMM yyyy');
  return format.format(dateTime);
}
   Color getContainerColorBasedOnApprovalStatus(String condition1) {
    if (condition1 == 'ACCEPTED') {
      return Color(0XFFBEFFE8);
    } else if (condition1 == 'PENDING') {
      return Color(0XFFFFF0F0);
    } else if (condition1 == 'REJECTED') {
      return Color(0XFFFEFAF3);
    } else if (condition1 == 'REGULARIZED') {
      return Color(0XFFF1F1F1);
    } else if (condition1 == 'CANCELLED') {
      return Color(0XFFDFDFFB);
    } else if (condition1 == 'REVOKED') {
      return Color(0XFFFFF0F0);
    } else {
      return Color(0XFFFFF0F0);
    }
  }

  Color getColorBasedOnApprovalStatus(String condition1) {
    if (condition1 == 'ACCEPTED') {
      return Color(0XFF2F9680);
    } else if (condition1 == 'PENDING') {
      return Color(0XFFFF4646);
    } else if (condition1 == 'REJECTED') {
      return Color(0XFFECB35D);
    } else if (condition1 == 'REGULARIZED') {
      return Color(0XFFB7B7B7);
    } else if (condition1 == 'CANCELLED') {
      return Color(0XFF605DEC);
    } else if (condition1 == 'REVOKED') {
      return Color(0XFFFF4646);
    } else {
      return Color(0XFFFF4646);
    }
  }


}