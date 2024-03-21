import 'package:flutter/material.dart';

import '../../../utils/utils.dart';

class BasicInfoCard extends StatelessWidget {
  const BasicInfoCard({
    super.key,
    required this.mobileNumber,
    required this.email,
    required this.joiningDate,
  });

  final String mobileNumber;
  final String email;
  final String joiningDate;

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
              children: [const Text('Mobile Number'), Text(mobileNumber)],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [const Text('Email'), Text(email)],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [const Text('Joining Date'), Text(joiningDate)],
            ),
          )
        ],
      ),
    );
  }
}
