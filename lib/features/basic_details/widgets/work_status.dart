import 'package:flutter/material.dart';

import '../../../utils/utils.dart';

class WorkStatusCard extends StatelessWidget {
  const WorkStatusCard({
    super.key,
    required this.workMode,
    required this.designation,
    required this.department,
    required this.officeLocation,
    required this.employmentStatus,
    required this.shiftTime
  });

  final String workMode;
  final String designation;
  final String department;
  final String officeLocation;
  final String employmentStatus;
  final String shiftTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: replyMessageColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [const Text('Work Mode'), Text(workMode)],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [const Text('Designation'), Text(designation)],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 16, top: 16, right: 16,),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [const Text('Department'), Text(department)],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 16, top: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [const Text('Office Location'), Text(officeLocation)],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 16, top: 16, right: 16,bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [const Text('Employment Status'), Text(employmentStatus)],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 16, top: 16, right: 16,bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [const Text('Shift Time'), Text(shiftTime)],
            ),
          )
        ],
      ),
    );
  }
}
