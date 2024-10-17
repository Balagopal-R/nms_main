import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nms/utils/theme/theme_constants.dart';
import '../approvals_controller.dart';

class ApprovalsBottomSheetContent extends StatelessWidget {
  final String appliedDate;
  final Color statusColor;
  final Color containerColor;
  final String statusText;
  final String inTime;
  final String breakTime;
  final String resumeTime;
  final String outTime;
  final String location;
  final String by;
  final String admin;
  final String reqInTime;
  final String reqBreakTime;
  final String reqResumeTime;
  final String reqOutTime;
  final String reqLocation;
  final VoidCallback onTap;

     const ApprovalsBottomSheetContent({
    Key? key,
    required this.appliedDate,
    required this.statusColor,
    required this.containerColor,
    required this.statusText,
    required this.inTime,
    required this.breakTime,
    required this.resumeTime,
    required this.outTime,
    required this.location,
    required this.by,
    required this.admin,
    required this.reqInTime,
    required this.reqBreakTime,
    required this.reqResumeTime,
    required this.reqOutTime,
    required this.reqLocation,
    required this.onTap, 
  }) : super(key: key); 

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ApprovalsController>(
      init: ApprovalsController(),
      builder: (controller) {
       double dynamicHeight = MediaQuery.of(context).size.height *
            (controller.punchApprovalsViewRequest!.status == 'PENDING'
                ? 0.75 // if button visible
                : 0.65); // if button hidden

        return Container(
          height: dynamicHeight,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 12),
                Container(
                  height: 4,
                  width: 40,
                  color: primaryGray,
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Applied Date', style: TextStyle(fontSize: 16)),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: containerColor,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  height: 8,
                                  width: 8,
                                  decoration: BoxDecoration(
                                    color: statusColor,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Text(statusText, style: TextStyle(color: statusColor),)
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(appliedDate,style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: primaryTextColor),),
                      const SizedBox(height: 12),
                      const Divider(color: veryLightGray, thickness: 2),
                      const SizedBox(height: 12),
                      Column(
                        children: [
                          _buildRow('IN Time', 'Req IN Time', inTime, reqInTime),
                          _buildRow('Break Time', 'Req Break Time', breakTime, reqBreakTime),
                          _buildRow('Resume Time', 'Req Resume Time', resumeTime, reqResumeTime),
                          _buildRow('OUT Time', 'Req OUT Time', outTime, reqOutTime),
                          _buildRow('Location', 'Req Location', location, reqLocation),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text('$by by', style: const TextStyle(fontSize: 16)),
                      const SizedBox(height: 4),
                      Text(admin,style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.black),),
                      const SizedBox(height: 16),

                      if (controller.punchApprovalsViewRequest!.status == 'PENDING')
                      
                      GestureDetector(
                        onTap: onTap,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 16),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: lightRed,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Center(
                            child: Text(
                              'Cancel Leave',
                              style: TextStyle(color: darkRed, fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }

  Widget _buildRow(String leftTitle, String rightTitle, String leftValue, String rightValue) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(leftTitle, style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w400, color: primaryTextColor)),
                const SizedBox(height: 4),
                Text(leftValue,style: const TextStyle(fontSize: 12,fontWeight: FontWeight.w500,color: primaryTextColor),),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(rightTitle, style: const TextStyle(fontSize: 14, color: primaryTextColor)),
                const SizedBox(height: 4),
                Text(rightValue,style: const TextStyle(fontSize: 12,fontWeight: FontWeight.w500,color: primaryTextColor),),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

