import 'package:flutter/material.dart';

class ApprovalsBottomSheetContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 0.75;
    return Container(
      height: height,
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
                          color: Color(0xFFBEFFE8),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          children: [
                            Container(
                              height: 8,
                              width: 8,
                              decoration: BoxDecoration(
                                color: Color(0xFF2F9680),
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: 4),
                            Text('Approved', style: TextStyle(color: Color(0xFF2F9680))),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text('01 Mar 2024', style: TextStyle(fontSize: 16)),
                  SizedBox(height: 12),
                  Divider(color: Color(0xFFF1F1F1), thickness: 2),
                  SizedBox(height: 12),
                  Column(
                    children: [
                      _buildRow('IN Time', 'Req IN Time', '09:20', '09:00'),
                      _buildRow('Break Time', 'Req Break Time', '13:00', '13:00'),
                      _buildRow('Resume Time', 'Req Resume Time', '13:30', '13:30'),
                      _buildRow('OUT Time', 'Req OUT Time', '18:07', '18:07'),
                      _buildRow('Location', 'Req Location', 'WFO', 'WFO'),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text('Approved By', style: TextStyle(fontSize: 16)),
                  SizedBox(height: 4),
                  Text('HR Admin', style: TextStyle(fontSize: 16)),
                  SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {
                      // Handle cancel leave action
                    },
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
                          style: TextStyle(color: Color(0xffFA5B5B), fontSize: 16),
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
  }

  Widget _buildRow(String leftTitle, String rightTitle, String leftValue, String rightValue) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(leftTitle, style: TextStyle(fontSize: 14, color: Colors.black54)),
              SizedBox(height: 4),
              Text(leftValue, style: TextStyle(fontSize: 16)),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(rightTitle, style: TextStyle(fontSize: 14, color: Colors.black54)),
              SizedBox(height: 4),
              Text(rightValue, style: TextStyle(fontSize: 16)),
            ],
          ),
        ],
      ),
    );
  }
}
