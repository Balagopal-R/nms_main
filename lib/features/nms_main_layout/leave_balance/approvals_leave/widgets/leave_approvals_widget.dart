import 'package:flutter/material.dart';
import 'package:nms/features/nms_main_layout/punch/approvals/approvals_controller.dart';
import 'package:get/get.dart';

class LeaveApprovalsWidget extends StatelessWidget {

  final Color statusColor;
  final Color containerColor;
  final String statusText;
  final String date;
  final String leaveType;
  final String appliedOn;
  final String approvedRejectedBy;
  final int index;
  final VoidCallback viewRequestTap;
  final VoidCallback onCancelTap;


   const LeaveApprovalsWidget({
    Key? key,
    required this.date,
    required this.statusColor,
    required this.containerColor,
    required this.statusText,
    required this.leaveType,
    required this.appliedOn,
    required this.approvedRejectedBy,
    required this.index,
    required this.viewRequestTap, 
    required this.onCancelTap
  }) : super(key: key); 

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return GetBuilder<ApprovalsController>(
      init: ApprovalsController(),
      builder: (controller) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: screenWidth,
              height: screenHeight * 0.33,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Date'),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: containerColor,
                            borderRadius: BorderRadius.circular(2.667),
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 4,
                                backgroundColor: statusColor,
                              ),
                              SizedBox(width: 4),
                              Text(
                                statusText,
                                style: TextStyle(
                                  color: statusColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(date,style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500,color: Colors.black),),
                    Divider(
                      height: 16,
                      color: Color(0xFFF1F1F1),
                      thickness: 1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Leave Type'),
                        Text('Applied on'),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(leaveType,style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500,color: Colors.black),),
                        Row(
                          children: [
                            Text(appliedOn,style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500,color: Colors.black),),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text('Approved/Rejected by'),
                    Text(approvedRejectedBy,style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500,color: Colors.black),),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: GestureDetector(
                          onTap: viewRequestTap,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(color: Color(0xFF3BBCA0)),
                              ),
                              child: Center(
                                child: Text(
                                  'View Request',
                                  style: TextStyle(
                                    color: Color(0xFF3BBCA0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
        
                        SizedBox(width: 8),

                      // if (controller.punchApprovals[index].status == 'PENDING')
                      //   Expanded(
                      //     child: GestureDetector(
                      //       onTap: onCancelTap,
                      //       child: Container(
                      //         padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      //         decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.circular(4),
                      //           border: Border.all(color: Color(0xFFFA5B5B)),
                      //         ),
                      //         child: Center(
                      //           child: Text(
                      //             'Cancel',
                      //             style: TextStyle(
                      //               color: Color(0xFFFA5B5B),
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ),

                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}