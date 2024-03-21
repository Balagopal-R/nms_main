import 'package:flutter/material.dart';

import '../../../utils/utils.dart';

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
        color: replyMessageColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [const Text('salary'), Text(salary)],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [const Text('project'), Text(project)],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 16, top: 16, right: 16,),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [const Text('buddy'), Text(buddy)],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 16, top: 16, right: 16,bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [const Text('manager'), Text(manager)],
            ),
          )
        ],
      ),
    );
  }
}
