import 'package:flutter/material.dart';
import 'package:nms/utils/theme/theme_constants.dart';

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
        color: veryLightGray,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [const Text('Work Mode',style: TextStyle(color: secondaryTextColor,fontSize: 12,fontWeight: FontWeight.w500),), 
              Text(workMode,style: const TextStyle(color: primaryTextColor,fontSize: 12,fontWeight: FontWeight.w500),)],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [const Text('Designation',style: TextStyle(color: secondaryTextColor,fontSize: 12,fontWeight: FontWeight.w500),), 
              Text(designation,style: const TextStyle(color: primaryTextColor,fontSize: 12,fontWeight: FontWeight.w500),)],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 16, top: 16, right: 16,),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [const Text('Department',style: TextStyle(color: secondaryTextColor,fontSize: 12,fontWeight: FontWeight.w500),), 
              Text(department,style: const TextStyle(color: primaryTextColor,fontSize: 12,fontWeight: FontWeight.w500),)],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 16, top: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [const Text('Office Location',style: TextStyle(color: secondaryTextColor,fontSize: 12,fontWeight: FontWeight.w500),), 
              Text(officeLocation,style: const TextStyle(color: primaryTextColor,fontSize: 12,fontWeight: FontWeight.w500),)],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 16, top: 16, right: 16,bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [const Text('Employment Status',style: TextStyle(color: secondaryTextColor,fontSize: 12,fontWeight: FontWeight.w500),), 
              Text(employmentStatus,style: const TextStyle(color: primaryTextColor,fontSize: 12,fontWeight: FontWeight.w500),)],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 16, top: 16, right: 16,bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [const Text('Shift Time',style: TextStyle(color: secondaryTextColor,fontSize: 12,fontWeight: FontWeight.w500),), 
              Text(shiftTime,style: const TextStyle(color: primaryTextColor,fontSize: 12,fontWeight: FontWeight.w500),)],
            ),
          )
        ],
      ),
    );
  }
}
