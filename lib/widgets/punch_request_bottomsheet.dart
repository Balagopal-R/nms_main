
import 'package:flutter/material.dart';
import 'package:nms/widgets/cornered_button.dart';

import '../utils/theme/theme_constants.dart';

class PunchRequestBottomSheetContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth,
      height: screenHeight*.80,
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(24, 39, 75, 0.08),
            offset: Offset(0, -5),
            blurRadius: 8,
            spreadRadius: -6,
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row 1: Grey line
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Color(0xFF7A7A7A),
                  borderRadius: BorderRadius.circular(2.0),
                ),
              ),
            ),
            SizedBox(height: 8.0),
    
            // Row 2: Punch Request
            Center(
              child: Text(
                'Punch Request',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: 8.0),
    
            // Row 3: Date
            Text(
              'Date*',
              style: TextStyle(
                color: Color(0xFF7A7A7A),
                fontFamily: 'Satoshi',
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 8.0),
    
            // Row 4: Date Picker
            Container(
              height: 50.0, // Increased height for Date Picker
              child: GestureDetector(
                onTap: () {
                  // Date Picker Logic
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    border: Border.all(color: Color(0xFFB7B7B7)),
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '25/09/2023',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      Icon(Icons.calendar_today, color: Colors.grey),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 8.0),
    
            // Row 5: Location
            Text(
              'Location*',
              style: TextStyle(
                color: Color(0xFF7A7A7A),
                fontFamily: 'Satoshi',
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 8.0),
    
            // Row 6: Location Dropdown
            Container(
              height: 50.0, // Increased height for Location Dropdown
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  border: Border.all(color: Color(0xFFB7B7B7)),
                  color: Colors.white,
                ),
                child: DropdownButton<String>(
                  isExpanded: true,
                  hint: Text('Select'),
                  underline: SizedBox(),
                  icon: Icon(Icons.arrow_drop_down, color: Colors.grey),
                  items: <String>['Location 1', 'Location 2', 'Location 3'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (_) {},
                ),
              ),
            ),
            SizedBox(height: 8.0),
  
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Punch In Time*',
                            style: TextStyle(
                              color: Color(0xFF7A7A7A),
                              fontFamily: 'Satoshi',
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          GestureDetector(
                            onTap: () {
                              // Time Picker Logic
                            },
                            child: Container(
                              height: 50,
                              width: screenWidth*0.41,
                              padding: EdgeInsets.symmetric(horizontal: 12.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.0),
                                border: Border.all(color: Color(0xFFB7B7B7)),
                                color: Colors.white,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '09:00',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  Icon(Icons.access_time, color: Colors.grey),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 16.0),
                          Text(
                            'Break*',
                            style: TextStyle(
                              color: Color(0xFF7A7A7A),
                              fontFamily: 'Satoshi',
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          GestureDetector(
                            onTap: () {
                              // Time Picker Logic
                            },
                            child: Container(
                              height: 50,
                              width: screenWidth*0.41,
                              padding: EdgeInsets.symmetric(horizontal: 12.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.0),
                                border: Border.all(color: Color(0xFFB7B7B7)),
                                color: Colors.white,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '13:00',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  Icon(Icons.access_time, color: Colors.grey),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
               
                  SizedBox(width: 16.0),
                  
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Punch Out Time*',
                            style: TextStyle(
                              color: Color(0xFF7A7A7A),
                              fontFamily: 'Satoshi',
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          GestureDetector(
                            onTap: () {
                              // Time Picker Logic
                            },
                            child: Container(
                              height: 50,
                              width: screenWidth*0.41,
                              padding: EdgeInsets.symmetric(horizontal: 12.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.0),
                                border: Border.all(color: Color(0xFFB7B7B7)),
                                color: Colors.white,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '18:00',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  Icon(Icons.access_time, color: Colors.grey),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 16.0),
                          Text(
                            'Resume*',
                            style: TextStyle(
                              color: Color(0xFF7A7A7A),
                              fontFamily: 'Satoshi',
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          GestureDetector(
                            onTap: () {
                              // Time Picker Logic
                            },
                            child: Container(
                              height: 50,
                              width: screenWidth*0.41,
                              padding: EdgeInsets.symmetric(horizontal: 12.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.0),
                                border: Border.all(color: Color(0xFFB7B7B7)),
                                color: Colors.white,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '14:00',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  Icon(Icons.access_time, color: Colors.grey),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                ],
              ),
        
            SizedBox(height: 16.0),
    
            // Row 8: Reason
            Text(
              'Reason*',
              style: TextStyle(
                color: Color(0xFF7A7A7A),
                fontFamily: 'Satoshi',
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 8.0),
    
            // Row 9: Reason Text Field
            Container(
              height: 100.0,
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                border: Border.all(color: Color(0xFFB7B7B7)),
                color: Colors.white,
              ),
              child: TextField(
                maxLength: 200,
                maxLines: 5,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter reason...',
                ),
              ),
            ),
            SizedBox(height: 8.0),
    
            // Row 10: Characters Remaining
            Text(
              '200/200 characters remaining',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 16.0),
    
            // Row 11: Submit Button

            CorneredButton(
                    height: 50,
                    color: primaryColor,
                    title: 'Submit',
                    textcolor: backgroundColor,
                    onPress: () async {

                    },
                  )
          ],
        ),
      ),
    );
  }
}
