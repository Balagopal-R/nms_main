import 'package:flutter/material.dart';
import 'package:nms/features/nms_main_layout/punch/approvals/widgets/approvals_widget.dart';
import 'package:nms/widgets/punch_in_request_bottomsheet.dart';

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
    return Scaffold(
      backgroundColor: Color(0xffF1F1F1),
      floatingActionButton: FloatingActionButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return PunchInRequestSheetContent();
                },
              );
            },
            child: Icon(Icons.add),
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
}
