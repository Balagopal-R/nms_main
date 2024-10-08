import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../approvals_leave_controller.dart';


class LeaveApprovalsBottomSheet extends StatelessWidget {
  final String appliedDate;
  final Color statusColor;
  final Color containerColor;
  final String statusText;
  final String dateFrom;
  final String leaveType;
  final String by;
  final String admin;
  final String dateTo;
  final String reqBreakTime;
  final String comments;
  final VoidCallback onTap;
  final int index;
  final int? documentLength;
  final String? documentName;
  final String? fileName;

  const LeaveApprovalsBottomSheet({
    Key? key,
    required this.appliedDate,
    required this.statusColor,
    required this.containerColor,
    required this.statusText,
    required this.dateFrom,
    required this.leaveType,
    required this.by,
    required this.admin,
    required this.dateTo,
    required this.reqBreakTime,
    required this.comments,
    required this.onTap,
    required this.index,
    this.documentLength,
    this.documentName,
    this.fileName
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Calculate the maximum allowable height for the bottom sheet (e.g., 90% of screen height)
    double maxHeight = MediaQuery.of(context).size.height * 0.9;

    return GetBuilder<ApprovalsLeaveController>(
      init: ApprovalsLeaveController(),
      builder: (controller) {
        return LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              constraints: BoxConstraints(
                // Dynamically set the height with max constraint
                maxHeight: maxHeight,
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 12),
                    Container(
                      height: 4,
                      width: 40,
                      color: Color(0xFFB7B7B7),
                    ),
                    SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Applied Date', style: TextStyle(fontSize: 16)),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                                    SizedBox(width: 4),
                                    Text(statusText, style: TextStyle(color: statusColor)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Text(
                            appliedDate,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 12),
                          Divider(color: Color(0xFFF1F1F1), thickness: 2),
                          SizedBox(height: 12),
                          Column(
                            children: [
                              _buildRow('Date From', 'Date To', dateFrom, dateTo),
                              _buildRow('Leave Type', '', leaveType, ''),
                            ],
                          ),
                          SizedBox(height: 16),
                          Text('$by by', style: TextStyle(fontSize: 16)),
                          SizedBox(height: 4),
                          Text(
                            admin,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 16),
                          Text('Comments', style: TextStyle(fontSize: 16)),
                          SizedBox(height: 4),
                          Text(
                            comments,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 16),

                          // Adjust height dynamically based on _buildFileList content
                          if (documentLength != null && documentLength != 0 && documentName != null)
                            _buildFileList(documentLength!, documentName!,  onTapDownload: (int index) {
    // Handle the tap action here
                            //  print('Tapped file at index $index');
                            //  print('-------------@@@@ $fileName');
                             controller.downloadFile(fileName!);
  },),

                          if (controller.leaveApprovals[index].status == 'PENDING' ||
                              controller.leaveApprovals[index].status == 'ACCEPTED')
                            GestureDetector(
                              onTap: onTap,
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 16),
                                padding: EdgeInsets.symmetric(vertical: 12),
                                decoration: BoxDecoration(
                                  color: Color(0xFFFFF0F0),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Center(
                                  child: Text(
                                    'Cancel Leave',
                                    style: TextStyle(
                                      color: Color(0xffFA5B5B),
                                      fontSize: 16,
                                    ),
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
          },
        );
      },
    );
  }

  // Widget _buildFileList(int length, String? name) {
  //   if (name == null || name.isEmpty) {
  //     return SizedBox.shrink(); // If no documents, return an empty SizedBox
  //   }

  //   return ListView.builder(
  //     shrinkWrap: true,
  //     physics: NeverScrollableScrollPhysics(), // Disable internal scrolling
  //     itemCount: length,
  //     itemBuilder: (context, index) {
  //       return Container(
  //         margin: const EdgeInsets.symmetric(vertical: 5.0),
  //         decoration: BoxDecoration(
  //           color: const Color(0xFFFAFAFA),
  //           borderRadius: BorderRadius.circular(2.0),
  //         ),
  //         child: ListTile(
  //           leading: const Icon(Icons.insert_drive_file),
  //           title: Text(name), // Use the provided name directly
  //         ),
  //       );
  //     },
  //   );
  // }

    Widget _buildFileList(int length, String? name, {required void Function(int) onTapDownload}) {
    if (name == null || name.isEmpty) {
      return SizedBox.shrink(); // If no documents, return an empty SizedBox
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(), // Disable internal scrolling
      itemCount: length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => onTapDownload(index), // Trigger the provided onTap function
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 5.0),
            decoration: BoxDecoration(
              color: const Color(0xFFFAFAFA),
              borderRadius: BorderRadius.circular(2.0),
            ),
            child: ListTile(
              leading: const Icon(Icons.insert_drive_file),
              title: Text(name), // Use the provided name directly
            ),
          ),
        );
      },
    );
  }




  Widget _buildRow(String leftTitle, String rightTitle, String leftValue, String rightValue) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(leftTitle, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black54)),
                SizedBox(height: 4),
                Text(leftValue, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black)),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(rightTitle, style: TextStyle(fontSize: 14, color: Colors.black54)),
                SizedBox(height: 4),
                Text(rightValue, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
