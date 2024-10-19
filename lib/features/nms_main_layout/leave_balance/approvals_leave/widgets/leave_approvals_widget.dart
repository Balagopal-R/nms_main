import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nms/utils/theme/theme.dart';
import '../approvals_leave.dart';

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

  const LeaveApprovalsWidget(
      {Key? key,
      required this.date,
      required this.statusColor,
      required this.containerColor,
      required this.statusText,
      required this.leaveType,
      required this.appliedOn,
      required this.approvedRejectedBy,
      required this.index,
      required this.viewRequestTap,
      required this.onCancelTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return GetBuilder<ApprovalsLeaveController>(
        init: ApprovalsLeaveController(),
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
                          const Text('Date'),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
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
                      Text(
                        date,
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: primaryTextColor),
                      ),
                      const Divider(
                        height: 16,
                        color: veryLightGray,
                        thickness: 1,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Leave Type'),
                          Text('Applied on'),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            leaveType,
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: primaryTextColor),
                          ),
                          Row(
                            children: [
                              Text(
                                appliedOn,
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: primaryTextColor),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Text('Approved/Rejected by'),
                      Text(
                        approvedRejectedBy,
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: primaryTextColor),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: viewRequestTap,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  border:
                                      Border.all(color: lightGreenTextColor),
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
                          if (controller.leaveApprovals[index].status ==
                                  'PENDING' ||
                              controller.leaveApprovals[index].status ==
                                  'ACCEPTED')
                            Expanded(
                              child: GestureDetector(
                                onTap: onCancelTap,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
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
        });
  }
}
