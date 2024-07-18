import 'package:flutter/material.dart';
import '../features/punch_in_out_bottomsheet/punch_in_out_bottomsheet.dart';
import '../features/punch_request_bottomsheet/punch_request_bottomsheet.dart';

class PunchOutRequestSheetContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      height: 150.0, // Increased height for the bottom sheet
      child: Column(
        children: [
          Container(
            height: 6.0,
            width: 70.0, // Increased length for the gray line
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(3.0), // Rounded edges
            ),
            margin: EdgeInsets.only(bottom: 16.0),
          ),

          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) {
                  return PunchInOutBottomSheetScreen(title: 'Punch Out');
                },
              );
            },
            child: Row(
              children: [
                // Icon(Icons.arrow_back, color: Colors.teal),
                Image.asset('assets/png/punch_out_green.png'),
                SizedBox(width: 16.0),
                Text('Punch Out', style: TextStyle(color: Colors.black)), // Black text
              ],
            ),
          ),

          SizedBox(height: 16.0),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) {
                  return PunchRequestBottomSheetScreen();
                },
              );
            },
            child: Row(
              children: [
                Image.asset('assets/png/edit.png'),
                // Icon(Icons.arrow_back, color: Colors.teal),
                SizedBox(width: 16.0),
                Text('Punch Request', style: TextStyle(color: Colors.black)), // Black text
              ],
            ),
          ),
        ],
      ),
    );
  }
}