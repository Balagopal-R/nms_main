import 'package:flutter/material.dart';
import 'package:nms/features/nms_main_layout/punch/approvals/approvals_controller.dart';
import 'package:get/get.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:nms/utils/theme/theme.dart';

class ApprovalsWidget extends StatelessWidget {

  final Color statusColor;
  final Color containerColor;
  final String statusText;
  final String appliedDate;
  final String reqDate;
  final String reqTime;
  final String reqTimeOne;
  final String reqTimeTwo;
  final String reqTimeThree;
  final String reqWorkMode;
  final int index;
  final VoidCallback viewRequestTap;
  final VoidCallback onCancelTap;


   const ApprovalsWidget({
    Key? key,
    required this.appliedDate,
    required this.statusColor,
    required this.containerColor,
    required this.statusText,
    required this.reqDate,
    required this.reqTime,
    required this.reqTimeOne,
    required this.reqTimeTwo,
    required this.reqTimeThree,
    required this.reqWorkMode,
    required this.index,
    required this.viewRequestTap, 
    required this.onCancelTap
  }) : super(key: key); 

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final tooltipController = JustTheController();

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
                color: backgroundColor,
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
                        const Text('Applied Date'),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                              const SizedBox(width: 4),
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
                    const SizedBox(height: 8),
                    Text(appliedDate,style: const TextStyle(fontSize: 12,fontWeight: FontWeight.w500,color: primaryTextColor),),
                   const Divider(
                      height: 16,
                      color: veryLightGray,
                      thickness: 1,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Req Date'),
                        Text('Req Time'),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(reqDate,style: const TextStyle(fontSize: 12,fontWeight: FontWeight.w500,color: primaryTextColor),),
                        Row(
                          children: [
                            Text(reqTime,style: const TextStyle(fontSize: 12,fontWeight: FontWeight.w500,color: primaryTextColor),),
                            const SizedBox(width: 4),

                           JustTheTooltip(
          controller: tooltipController,
          content: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  reqTimeOne,
                  style: const TextStyle(color: primaryTextColor),
                ),
                Text(
                  reqTimeTwo,
                  style: const TextStyle(color: primaryTextColor),
                ),
                Text(
                  reqTimeThree,
                  style: const TextStyle(color: primaryTextColor),
                ),
              ],
            ),
          ),
          child: GestureDetector(
            onTap: () {
              tooltipController.showTooltip();
            },
            child: const Text(
              '+3',
              style: TextStyle(
                color: lightGreenTextColor,
              ),
            ),
          ),
        ),


                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text('Req Work Mode'),
                    Text(reqWorkMode,style: const TextStyle(fontSize: 12,fontWeight: FontWeight.w500,color: primaryTextColor),),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: GestureDetector(
                          onTap: viewRequestTap,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(color: lightGreenTextColor),
                              ),
                              child: const Center(
                                child: Text(
                                  'View Request',
                                  style: TextStyle(
                                    color: lightGreenTextColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
        
                        const SizedBox(width: 8),

                      if (controller.punchApprovals[index].status == 'PENDING')
                        Expanded(
                          child: GestureDetector(
                            onTap: onCancelTap,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(color: darkRed),
                              ),
                              child: const Center(
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(
                                    color: darkRed,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

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