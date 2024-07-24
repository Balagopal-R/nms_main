import 'package:flutter/material.dart';
import 'package:nms/features/nms_main_layout/punch/approvals/widgets/approvals_widget.dart';
import 'package:nms/widgets/punch_in_request_bottomsheet.dart';
import 'package:nms/widgets/punch_out_request_bottomsheet.dart';
import 'package:get/get.dart';
import 'approvals_controller.dart';

// ignore: use_key_in_widget_constructors
class ApprovalsScreen extends StatelessWidget {
  
  final List<Map<String, String>> items = [
    {
      'status': 'Pending',
      'statusColor': '#ECB35D',
      'statusText': 'For Approval',
    },
    {
      'status': 'Approved',
      'statusColor': '#4CAF50',
      'statusText': 'Approved',
    },
    {
      'status': 'Rejected',
      'statusColor': '#F44336',
      'statusText': 'Rejected',
    },
    {
      'status': 'Completed',
      'statusColor': '#3F51B5',
      'statusText': 'Completed',
    },
  ];

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
          body: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return ApprovalsWidget(
                status: item['status']!,
                statusColor: item['statusColor']!,
                statusText: item['statusText']!,
              );
            },
          ),
        );
      }
    );
  }
}
