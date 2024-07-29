import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:nms/features/nms_main_layout/punch/approvals/widgets/approvals_bottomsheet.dart';
import 'package:nms/features/nms_main_layout/punch/approvals/widgets/approvals_widget.dart';
import 'package:nms/models/punch_approvals_model/punch_approvals_model.dart';
import 'package:nms/utils/theme/theme_constants.dart';
import 'package:nms/widgets/punch_in_request_bottomsheet.dart';
import 'package:nms/widgets/punch_out_request_bottomsheet.dart';
import 'package:get/get.dart';
import 'approvals_controller.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

// class ApprovalsScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<ApprovalsController>(
//       init: ApprovalsController(),
//       builder: (controller) {
//         return Scaffold(
//           backgroundColor: Color(0xffF1F1F1),
//           floatingActionButton: FloatingActionButton(
//             onPressed: () async {
//               if (controller.getEmployPunchIn!.punchOutDateTime != null) {
//                 await showModalBottomSheet(
//                   context: context,
//                   builder: (context) {
//                     return PunchInRequestSheetContent();
//                   },
//                 );
//               } else {
//                 await showModalBottomSheet(
//                   context: context,
//                   builder: (context) {
//                     return PunchOutRequestSheetContent();
//                   },
//                 );
//               }
//             },
//             child: Image(
//               image: AssetImage('assets/png/plus.png'),
//             ),
//             backgroundColor: Color(0xFF3BBCA0),
//           ),
//           body: PagedListView<int, PunchApprovalsModel>(
//             pagingController: controller.pagingController,
//             builderDelegate: PagedChildBuilderDelegate<PunchApprovalsModel>(
//               itemBuilder: (context, item, index) => ApprovalsWidget(
//                 appliedDate: controller.formatEpochToDateString(item.createdAt),
//                 statusColor: 'Colors.green',
//                 statusText: item.status,
//                 reqDate: controller.formatEpochToMiniDateString(item.shiftDate),
//                 reqTime: controller.formatEpochToTimeStringIN(item.punchInDatetime),
//                 reqWorkMode: item.punchLocation,
//                 onTap: () async {
//                   await controller.userPunchApprovalPendingRequest(item.id);
//                   print(controller.punchApprovalsViewRequest?.status);
//                   showModalBottomSheet(
//                     context: context,
//                     isScrollControlled: true,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
//                     ),
//                     builder: (context) => ApprovalsBottomSheetContent(
//                       appliedDate: controller.formatEpochToDateString(
//                           controller.punchApprovalsViewRequest!.createdAt),
//                       statusColor: Color(0xff2F9680),
//                       statusText: controller.punchApprovalsViewRequest!.status,
//                       inTime: controller.formatEpochToTimeString(
//                           controller.punchApprovalsViewRequest!.punchLog[0]
//                               .punchInDateTime),
//                       breakTime: controller.formatEpochToTimeString(
//                           controller.punchApprovalsViewRequest!.punchLog[0]
//                               .punchInDateTime),
//                       resumeTime: controller.formatEpochToTimeString(
//                           controller.punchApprovalsViewRequest!.punchLog[0]
//                               .punchOutDateTime),
//                       outTime: controller.formatEpochToTimeString(
//                           controller.punchApprovalsViewRequest!
//                               .punchLog[controller.punchApprovalsViewRequest!
//                                   .punchLog.length - 1]
//                               .punchOutDateTime),
//                       location: controller.punchApprovalsViewRequest!.punchLog[0]
//                           .punchLocation.toString(),
//                       by: controller.punchApprovalsViewRequest!.status,
//                       admin: controller.punchApprovalsViewRequest?.managers
//                                   ?.isNotEmpty ==
//                               true
//                           ? controller.punchApprovalsViewRequest!.managers[0]
//                                   .firstname?.toString() ??
//                               '_'
//                           : '_',
//                       reqInTime: "09:00",
//                       reqBreakTime: "13:00",
//                       reqResumeTime: "13:30",
//                       reqOutTime: "18:00",
//                       reqLocation: controller.punchApprovalsViewRequest!
//                           .punchLocation,
//                       onTap: () {
//                         _showCustomDialog(context);
//                       },
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// ignore: use_key_in_widget_constructors
class ApprovalsScreen extends StatelessWidget {

 @override
  Widget build(BuildContext context) {
    return GetBuilder<ApprovalsController>(
      init: ApprovalsController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Color(0xffF1F1F1),
          floatingActionButton: FloatingActionButton(
                onPressed: () async{
                 
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
          // ignore: unnecessary_null_comparison
          body: controller.punchApprovals != null ?
          ListView.builder(
            itemCount: controller.punchApprovals.length,
            itemBuilder: (context, index) {
              final item = controller.punchApprovals[index];
              return ApprovalsWidget(
               appliedDate: controller.formatEpochToDateString(item.createdAt),
               statusColor: 'Colors.green' ,
               statusText: item.status,
               reqDate: controller.formatEpochToMiniDateString(item.shiftDate),
               reqTime: controller.formatEpochToTimeStringIN(item.punchInDatetime),
               reqWorkMode: item.punchLocation,
               onTap: () async{
                await controller.userPunchApprovalPendingRequest(item.id);
                print(controller.punchApprovalsViewRequest?.status);
                showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                builder: (context) => ApprovalsBottomSheetContent(
                  appliedDate: controller.formatEpochToDateString(controller.punchApprovalsViewRequest!.createdAt),
                  statusColor: Color(0xff2F9680),
                  statusText: controller.punchApprovalsViewRequest!.status,
                  inTime: controller.formatEpochToTimeString(controller.punchApprovalsViewRequest!.punchLog[0].punchInDateTime),
                  breakTime: controller.formatEpochToTimeString(controller.punchApprovalsViewRequest!.punchLog[0].punchInDateTime),
                  resumeTime: controller.formatEpochToTimeString(controller.punchApprovalsViewRequest!.punchLog[0].punchOutDateTime),
                  outTime: controller.formatEpochToTimeString(controller.punchApprovalsViewRequest!.punchLog[controller.punchApprovalsViewRequest!.punchLog.length-1].punchOutDateTime),
                  location: controller.punchApprovalsViewRequest!.punchLog[0].punchLocation.toString(),
                  by: controller.punchApprovalsViewRequest!.status,
                  admin: controller.punchApprovalsViewRequest?.managers?.isNotEmpty == true 
                        ? controller.punchApprovalsViewRequest!.managers[0].firstname?.toString() ?? '_' : '_',
                  reqInTime: "09:00",
                  reqBreakTime: "13:00",
                  reqResumeTime: "13:30",
                  reqOutTime: "18:00",
                  reqLocation: controller.punchApprovalsViewRequest!.punchLocation,
                  onTap: () {
                    _showCustomDialog(context);
                  },
                ),
              );
               },
              );
            },
          ) : const Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      ),
                    ),
        );
      }
    );
  }
}

void _showCustomDialog(BuildContext context) {
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
                    // Handle 'Yes, cancel this request' action
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
  
