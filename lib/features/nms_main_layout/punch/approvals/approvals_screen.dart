import 'package:flutter/material.dart';
import 'package:nms/features/nms_main_layout/punch/approvals/widgets/approvals_bottomsheet.dart';
import 'package:nms/features/nms_main_layout/punch/approvals/widgets/approvals_widget.dart';
import 'package:nms/models/punch_approvals_model/punch_approvals_model.dart';
import 'package:nms/widgets/punch_in_request_bottomsheet.dart';
import 'package:nms/widgets/punch_out_request_bottomsheet.dart';
import 'package:get/get.dart';
import 'approvals_controller.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ApprovalsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ApprovalsController>(
      init: ApprovalsController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Color(0xffFFAFAFA),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              if (controller.getEmployPunchIn!.punchOutDateTime != null) {
                await showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return PunchInRequestSheetContent();
                  },
                );
              } else {
                await showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return PunchOutRequestSheetContent();
                  },
                );
              }
            },
            child: Image(
              image: AssetImage('assets/png/plus.png'),
            ),
            backgroundColor: Color(0xFF3BBCA0),
          ),
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
                reqDate: controller.formatEpochToMiniDateString(item.shiftDate),
                reqTime:
                    controller.formatEpochToTimeStringIN(item.punchInDatetime),
                reqTimeOne:
                    controller.formatEpochToTimeStringIN(item.punchOutDatetime),
                reqTimeTwo:
                    controller.formatEpochToTimeStringIN(item.resumeDateTime),
                reqTimeThree:
                    controller.formatEpochToTimeStringIN(item.breakDateTime),
                reqWorkMode: item.punchLocation,
                onCancelTap: () async {
                  _showCustomDialog(context, controller, item.id);
                },
                viewRequestTap: () async {
                  await controller.userPunchApprovalPendingRequest(item.id);
                  await Get.bottomSheet(
                    ApprovalsBottomSheetContent(
                      appliedDate: controller.formatEpochToDateString(
                          controller.punchApprovalsViewRequest!.createdAt),
                      statusColor: controller.getColorBasedOnApprovalStatus(
                          controller.punchApprovalsViewRequest!.status),
                      containerColor:
                          controller.getContainerColorBasedOnApprovalStatus(
                              controller.punchApprovalsViewRequest!.status),
                      statusText: controller.punchApprovalsViewRequest!.status,
                      inTime: controller.formatEpochToTimeString(controller
                          .punchApprovalsViewRequest!
                          .punchLog[0]
                          .punchInDateTime),
                      breakTime: controller.formatEpochToTimeString(controller
                          .punchApprovalsViewRequest!
                          .punchLog[1]
                          .punchInDateTime),
                      resumeTime: controller.formatEpochToTimeString(controller
                          .punchApprovalsViewRequest!
                          .punchLog[1]
                          .punchOutDateTime),
                      outTime: controller.formatEpochToTimeString(controller
                          .punchApprovalsViewRequest!
                          .punchLog[controller
                                  .punchApprovalsViewRequest!.punchLog.length -
                              1]
                          .punchOutDateTime),
                      location: controller
                          .punchApprovalsViewRequest!.punchLog[0].punchLocation
                          .toString(),
                      by: controller.capitalizeFirstLetter(
                          controller.punchApprovalsViewRequest!.status),
                      admin: controller.punchApprovalsViewRequest?.managers
                                  ?.isNotEmpty ==
                              true
                          ? controller.punchApprovalsViewRequest!.managers[0]
                                  .firstname
                                  ?.toString() ??
                              '_'
                          : '_',
                      reqInTime: "09:00",
                      reqBreakTime: "13:00",
                      reqResumeTime: "13:30",
                      reqOutTime: "18:00",
                      reqLocation:
                          controller.punchApprovalsViewRequest!.punchLocation,
                      onTap: () {
                        _showCustomDialog(context, controller,
                            controller.punchApprovalsViewRequest!.id);
                      },
                    ),
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                  );
                },
              ),
              firstPageErrorIndicatorBuilder: (context) => Center(
                child: Text('Error occurred, please try again.'),
              ),
              noItemsFoundIndicatorBuilder: (context) => Center(
                child: Text('No punch approvals found.'),
              ),
              newPageProgressIndicatorBuilder: (context) => Center(
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
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Are you sure you want to cancel this request?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF212121),
                    fontFamily: 'Satoshi',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    height: 1.4, // 140% line height
                  ),
                ),
                SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    controller.userPunchRequestCancel(id);
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFFA5B5B),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    alignment: Alignment.center,
                    child: Text(
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
                SizedBox(height: 8),
                GestureDetector(
                  onTap: () {
                    // Handle 'No, go back' action
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      border: Border.all(
                        color: Color(0xFF3BBCA0),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    alignment: Alignment.center,
                    child: Text(
                      'No, go back',
                      style: TextStyle(
                        color: Color(0xFF3BBCA0),
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
