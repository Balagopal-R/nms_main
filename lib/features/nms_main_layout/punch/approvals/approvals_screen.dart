import 'package:flutter/material.dart';
import 'package:nms/features/nms_main_layout/punch/approvals/widgets/approvals_widget.dart';
import 'package:nms/utils/theme/theme_constants.dart';
import 'package:nms/widgets/punch_in_request_bottomsheet.dart';
import 'package:nms/widgets/punch_out_request_bottomsheet.dart';
import 'package:get/get.dart';
import 'approvals_controller.dart';

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
               appliedDate: item.createdAt.toString(),
               statusColor: 'Colors.green' ,
               statusText: item.status,
               reqDate: item.shiftDate.toString(),
               reqTime: item.punchInDatetime.toString(),
               reqWorkMode: item.punchLocation
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
