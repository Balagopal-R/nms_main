import 'package:flutter/material.dart';
import 'package:nms/utils/theme/theme.dart';
import '../features/punch_in_out_bottomsheet/punch_in_out_bottomsheet.dart';
import '../features/punch_request_bottomsheet/punch_request_bottomsheet.dart';

class PunchInRequestSheetContent extends StatelessWidget {
  const PunchInRequestSheetContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      height: 150.0, // Increased height for the bottom sheet
      child: Column(
        children: [
          Container(
            height: 6.0,
            width: 70.0, // Increased length for the gray line
            decoration: BoxDecoration(
              color: secondaryTextColor,
              borderRadius: BorderRadius.circular(3.0), // Rounded edges
            ),
            margin: const EdgeInsets.only(bottom: 16.0),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) {
                  return const PunchInOutBottomSheetScreen(title: 'Punch IN');
                },
              );
            },
            child: Row(
              children: [
                Image.asset('assets/png/punch_in_green.png'),
                // Icon(Icons.arrow_back, color: Colors.teal),
                const SizedBox(width: 16.0),
                const Text('Punch In',
                    style: TextStyle(color: primaryTextColor)), // Black text
              ],
            ),
          ),
          const SizedBox(height: 16.0),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) {
                  return const PunchRequestBottomSheetScreen();
                },
              );
            },
            child: Row(
              children: [
                Image.asset('assets/png/edit.png'),
                // Icon(Icons.arrow_back, color: Colors.teal),
                const SizedBox(width: 16.0),
                const Text('Punch Request',
                    style: TextStyle(color: primaryTextColor)), // Black text
              ],
            ),
          ),
        ],
      ),
    );
  }
}
