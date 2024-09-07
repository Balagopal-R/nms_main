import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:nms/dtos/nms_dtos/get_leaves_dtos/get_leaves_request.dart';
import 'package:nms/managers/sharedpreferences/sharedpreferences.dart';
import 'package:nms/mixins/snackbar_mixin.dart';
import 'package:nms/models/get_remaining_leaves/get_remaining_leaves_model.dart';
import 'package:nms/repository/api_repository.dart';
import 'package:nms/utils/helpers/validation.dart';

class BalancesController extends GetxController with SnackbarMixin {

  String userId = "";

  
    final _getEmployeRemainingLeaves = (List<GetRemainingLeavesModel>.empty()).obs;
  List<GetRemainingLeavesModel> get getEmployeRemainingLeaves => _getEmployeRemainingLeaves;

    static const _pageSize = 10;
  final PagingController<int, GetRemainingLeavesModel> pagingController =
      PagingController(firstPageKey: 0);




@override
  void onInit() async {
    super.onInit();
    // await getIdFromToken();
     pagingController.addPageRequestListener((pageKey) {
      getEmployeeLeavesPagination(pageKey);
    });
    pagingController.refresh();

  }

  String getTodaysDate() {
  final now = DateTime.now();
  final formatter = DateFormat('yyyy-MM-dd');
  final formattedDate = formatter.format(now);
  return formattedDate;
}



  
// get remaining leaves

  getEmployeeLeavesPagination(int pageKey) async {
    //String platform = (Platform.isAndroid || Platform.isIOS) ? "MOBILE" : "WEB";

    try {
       final authService = NMSJWTDecoder();
      final decodedToken = await authService.decodeAuthToken();
      userId = decodedToken!["userId"];
      String today = getTodaysDate();

      final request = GetLeavesRequest(
          userId: userId,
          keyword: '',
          page: pageKey,
          size: _pageSize,
          field: "leaveBalance",
          sortOfOrder: "ASC",
          asOfDate: today,
          status: ["ACTIVE"],
          );

      final response = await ApiRepository.to.getLeaves(request: request);

      if (response.status == 200) {

        final isLastPage = response.pagination?.totalPages == pageKey;
        if (isLastPage) {
          pagingController.appendLastPage(response.data);
        } else {
          final nextPageKey = pageKey + 1;
          pagingController.appendPage(response.data, nextPageKey);
        }
        _getEmployeRemainingLeaves.addAll(response.data);
        update();
      } 
      else if (response.message == "Failed") {
        debugPrint(response.errors['errorMessage']);
        showErrorSnackbar(message: errorOccuredText);
      }
    } catch (e) {
      showErrorSnackbar(message: e.toString());
      debugPrint(e.toString());
    }
  }
  
}

