// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:nms/features/nms_main_layout/punch/approvals/widgets/approvals_bottomsheet.dart';
import 'package:nms/features/nms_main_layout/punch/approvals/widgets/approvals_widget.dart';
import 'package:nms/models/punch_approvals_model/punch_approvals_model.dart';
import 'package:nms/utils/theme/theme.dart';
import 'package:get/get.dart';
import 'approvals_controller.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ApprovalsScreen extends StatelessWidget {
  const ApprovalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ApprovalsController>(
      init: ApprovalsController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: scaffoldBackgroundColor,
          body: PagedListView<int, PunchApprovalsModel>(
            pagingController: controller.pagingController,
            builderDelegate: PagedChildBuilderDelegate<PunchApprovalsModel>(
              itemBuilder: (context, item, index) => ApprovalsWidget(
                appliedDate: controller.formatEpochToDateString(item.createdAt),
                statusText: controller.capitalizeFirstLetter(item.status),
                statusColor:
                    controller.getColorBasedOnApprovalStatus(item.status),
                containerColor: controller
                    .getContainerColorBasedOnApprovalStatus(item.status),
                reqDate: controller.formatDate(item.shiftDate),
                reqTime: controller.formatEpochToTimeStringIN(
                    item.punchInDatetime, 'IN'),
                reqTimeOne: controller.formatEpochToTimeStringIN(
                    item.punchOutDatetime, 'OUT'),
                reqTimeTwo: controller.formatEpochToTimeStringIN(
                    item.resumeDateTime, 'RES'),
                reqTimeThree: controller.formatEpochToTimeStringIN(
                    item.breakDateTime, 'BRK'),
                reqWorkMode:
                    controller.capitalizeFirstLetter(item.punchLocation),
                index: index,
                onCancelTap: () async {
                  _showCustomDialog(context, controller, item.id);
                },
                viewRequestTap: () async {
                  await controller.userPunchApprovalViewRequest(item.id);
                  await Get.bottomSheet(
                    ApprovalsBottomSheetContent(
                      appliedDate: controller.formatEpochToDateString(
                          controller.punchApprovalsViewRequest!.createdAt),
                      statusColor: controller.getColorBasedOnApprovalStatus(
                          controller.punchApprovalsViewRequest!.status),
                      containerColor:
                          controller.getContainerColorBasedOnApprovalStatus(
                              controller.punchApprovalsViewRequest!.status),
                      statusText: controller.capitalizeFirstLetter(
                          controller.punchApprovalsViewRequest!.status),
                      inTime: controller.checkPunchLogInOut(
                          controller.punchApprovalsViewRequest, 0, true),
                      breakTime: controller.checkPunchLogBreakOrResume(
                          controller.punchApprovalsViewRequest, true),
                      resumeTime: controller.checkPunchLogBreakOrResume(
                          controller.punchApprovalsViewRequest, false),
                      outTime: controller.checkPunchLogInOut(
                          controller.punchApprovalsViewRequest,
                          controller
                                  .punchApprovalsViewRequest!.punchLog.length -
                              1,
                          false),
                      location: controller.capitalizeFirstLetter(
                          controller.checkPunchLocation(
                              controller.punchApprovalsViewRequest)),
                      by: controller.capitalizeFirstLetter(
                          controller.punchApprovalsViewRequest!.status),
                      admin: controller.punchApprovalsViewRequest?.managers
                                  .isNotEmpty ==
                              true
                          ? controller
                              .punchApprovalsViewRequest!.managers[0].firstname
                              .toString()
                          : '_',
                      reqInTime: "09:00",
                      reqBreakTime: "13:00",
                      reqResumeTime: "13:30",
                      reqOutTime: "18:00",
                      reqLocation: controller.capitalizeFirstLetter(
                          controller.punchApprovalsViewRequest!.punchLocation),
                      onTap: () {
                        if (controller.punchApprovals[index].status ==
                            'PENDING') {
                          _showCustomDialog(context, controller,
                              controller.punchApprovalsViewRequest!.id);
                        } else {}
                      },
                    ),
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                  );
                },
              ),
              firstPageErrorIndicatorBuilder: (context) => const Center(
                child: Text('Error occurred, please try again.'),
              ),
              noItemsFoundIndicatorBuilder: (context) => const Center(
                child: Text('No punch approvals found.'),
              ),
              newPageProgressIndicatorBuilder: (context) => const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        );
      },
    );
  }

  void _showCustomDialog(
      BuildContext context, ApprovalsController controller, int id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          backgroundColor: Colors.white,
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text(
                  'Are you sure you want to cancel this request?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: primaryTextColor,
                    fontFamily: 'Satoshi',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    height: 1.4, // 140% line height
                  ),
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    controller.userPunchRequestCancel(id);
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: darkRed,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    alignment: Alignment.center,
                    child: const Text(
                      'Yes, cancel this request',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Satoshi',
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () {
                    // Handle 'No, go back' action
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      border: Border.all(
                        color: lightGreenTextColor,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    alignment: Alignment.center,
                    child: const Text(
                      'No, go back',
                      style: TextStyle(
                        color: lightGreenTextColor,
                        fontFamily: 'Satoshi',
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
