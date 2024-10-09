import 'package:flutter/material.dart';
import 'package:nms/features/nms_main_layout/leave_balance/approvals_leave/approvals_leave_controller.dart';
import 'package:nms/features/nms_main_layout/leave_balance/approvals_leave/widgets/leave_approvals_bottomsheet.dart';
import 'package:nms/features/nms_main_layout/leave_balance/approvals_leave/widgets/leave_approvals_widget.dart';
import 'package:nms/models/leave_approvals_model/leave_approvals_model.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ApprovalsLeaveScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ApprovalsLeaveController>(
      init: ApprovalsLeaveController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Color(0xffFFAFAFA),
          body: PagedListView<int, LeaveApprovalsModel>(
            pagingController: controller.pagingController,
            builderDelegate: PagedChildBuilderDelegate<LeaveApprovalsModel>(
              itemBuilder: (context, item, index) => LeaveApprovalsWidget(
                date: '${controller.formatDate(item.leaveStartDate)} - ${controller.formatDate(item.leaveEndDate)}',
                statusText: item.status,
                statusColor: controller.getContainerColorBasedOnApprovalStatus(item.status),
                containerColor: controller.getColorBasedOnApprovalStatus(item.status),
                leaveType: '${item.leaveType.name}/${item.duration}',
                appliedOn: controller.formatEpochToDateString(item.createdAt),
                approvedRejectedBy: controller.getStatusText(item.status, item.updatedBy.firstname, item.updatedBy.lastname),
                index: index,
                onCancelTap: () async {
                  _showCustomDialog(context, controller, item.id);
                },

                viewRequestTap: () async {
                  await Get.bottomSheet(
                    LeaveApprovalsBottomSheet(
                      appliedDate: controller.formatEpochToDateString(item.createdAt),
                      statusColor: controller.getContainerColorBasedOnApprovalStatus(item.status),
                      containerColor: controller.getColorBasedOnApprovalStatus(item.status),
                      statusText: item.status,
                      dateFrom: controller.formatDate(item.leaveStartDate),
                      leaveType: '${item.leaveType.name}/${item.duration}' ,
                      by: 'Approved',
                      admin: controller.getStatusText(item.status, item.updatedBy.firstname, item.updatedBy.lastname),
                      dateTo: controller.formatDate(item.leaveEndDate),
                      reqBreakTime: '',
                      comments: item.comments,
                      onTap: () {
                         if (item.status == 'PENDING' || item.status == 'ACCEPTED') {
                          _showCustomDialog(context, controller,item.id);
                          // Navigator.pop(context);
                            }
                            else {
                              
                            }
                        
                      },
                      index: index,
                    documentLength: item.leaveDocuments?.length ?? 0,
                    documentName: (item.leaveDocuments != null && 
                 item.leaveDocuments!.isNotEmpty && 
                 index >= 0 && 
                 index < item.leaveDocuments!.length)
      ? item.leaveDocuments![index].displayName
      : null,
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
      BuildContext context, ApprovalsLeaveController controller, int id) {
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
                    controller.userLeaveRequestCancel(id);
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
