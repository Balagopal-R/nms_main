import 'package:flutter/material.dart';
import 'package:nms/features/nms_main_layout/punch/approvals/widgets/approvals_bottomsheet.dart';

class ApprovalsWidget extends StatelessWidget {
  final String status;
  final String statusColor;
  final String statusText;

  ApprovalsWidget({
    required this.status,
    required this.statusColor,
    required this.statusText,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

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
                    Text('Applied Date'),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Color(0xFFFEFAF3),
                        borderRadius: BorderRadius.circular(2.667),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 4,
                            backgroundColor: Color(0xFFECB35D),
                          ),
                          SizedBox(width: 4),
                          Text(
                            statusText,
                            style: TextStyle(
                              color: Color(0xFFECB35D),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text('01-Mar-2024',style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500,color: Colors.black),),
                Divider(
                  height: 16,
                  color: Color(0xFFF1F1F1),
                  thickness: 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Req Date'),
                    Text('Req Time'),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Mar 03',style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500,color: Colors.black),),
                    Row(
                      children: [
                        Text('IN-09:00',style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500,color: Colors.black),),
                        SizedBox(width: 4),
                        Text(
                          '+3',
                          style: TextStyle(
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text('Req Work Mode'),
                Text('WFO',style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500,color: Colors.black),),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            builder: (context) => ApprovalsBottomSheetContent(),
          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: Color(0xFF3BBCA0)),
                          ),
                          child: Center(
                            child: Text(
                              'View Request',
                              style: TextStyle(
                                color: Color(0xFF3BBCA0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(width: 8),

                    Expanded(
                      child: GestureDetector(
                        onTap: () {
 _showCustomDialog(context);

                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: Color(0xFFFA5B5B)),
                          ),
                          child: Center(
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                color: Color(0xFFFA5B5B),
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
  }
}


  void _showCustomDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          backgroundColor: Colors.white,
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Are you sure you want to cancel this request?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF212121),
                    fontFamily: 'Satoshi',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    height: 1.4, // 140% line height
                  ),
                ),
                SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    // Handle 'Yes, cancel this request' action
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFFA5B5B),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    alignment: Alignment.center,
                    child: Text(
                      'Yes, cancel this request',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Satoshi',
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                GestureDetector(
                  onTap: () {
                    // Handle 'No, go back' action
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      border: Border.all(
                        color: Color(0xFF3BBCA0),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    alignment: Alignment.center,
                    child: Text(
                      'No, go back',
                      style: TextStyle(
                        color: Color(0xFF3BBCA0),
                        fontFamily: 'Satoshi',
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  