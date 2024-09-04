import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:nms/mixins/snackbar_mixin.dart';
import 'package:nms/models/punch_approvals_model/punch_approvals_model.dart';

class ApprovalsLeaveController extends GetxController with SnackbarMixin {

    static const _pageSize = 10;
  final PagingController<int, PunchApprovalsModel> pagingController =
      PagingController(firstPageKey: 0);

      
  @override
  void onInit() async {
    super.onInit();
    // await getIdFromToken();
    pagingController.addPageRequestListener((pageKey) {
      // userPunchApprovals(pageKey);
    });
    // Trigger the initial page load
    pagingController.refresh();
    // await getLastPunchIn();
  }


}