import 'package:flutter/material.dart';
import 'package:nms/utils/theme/theme.dart';


class WorkDetailsCard extends StatelessWidget {
  const WorkDetailsCard({
    super.key,
    required this.salary,
    required this.project,
    required this.buddy,
    required this.manager,
  });

  final String salary;
  final String project;
  final String buddy;
  final String manager;

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
              children: [const Text('Salary',style: TextStyle(color: secondaryTextColor,fontSize: 12,fontWeight: FontWeight.w500),), 
              Text(salary,style: const TextStyle(color: primaryTextColor,fontSize: 12,fontWeight: FontWeight.w500),)],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [const Text('Project',style: TextStyle(color: secondaryTextColor,fontSize: 12,fontWeight: FontWeight.w500),), 
              Text(project,style: const TextStyle(color: primaryTextColor,fontSize: 12,fontWeight: FontWeight.w500),)],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 16, top: 16, right: 16,),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [const Text('Buddy',style: TextStyle(color: secondaryTextColor,fontSize: 12,fontWeight: FontWeight.w500),), 
              Text(buddy,style: const TextStyle(color: primaryTextColor,fontSize: 12,fontWeight: FontWeight.w500),)],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 16, top: 16, right: 16,bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [const Text('Manager',style: TextStyle(color: secondaryTextColor,fontSize: 12,fontWeight: FontWeight.w500),), 
              Text(manager,style: const TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.w500),)],
            ),
          )
        ],
      ),
    );
  }
}
