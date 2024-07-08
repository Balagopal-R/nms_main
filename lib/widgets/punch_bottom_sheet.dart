import 'package:flutter/material.dart';
import 'package:nms/widgets/cornered_button.dart';
import '../utils/theme/theme_constants.dart';
import 'package:intl/intl.dart'; 

class PunchBottomSheetContent extends StatelessWidget {

   final String title;
   const PunchBottomSheetContent(
      {Key? key,
      required this.title,})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    final today = DateTime.now(); // Get the current date
    final formattedDate = DateFormat('dd/MM/yyyy').format(today); // Format the date

    final now = DateTime.now();
    final formattedTime = DateFormat('HH:mm').format(now); // Format in 24-hour format



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
            SizedBox(height: 16.0),
    
            // Row 2: Punch Request
            Center(
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: 16.0),
    
           
    
            // Row 4: Date Picker
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Text(
              'Date*',
              style: TextStyle(
                color: Color(0xffD9D9D9),
                fontFamily: 'Satoshi',
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 8.0),

               Container(
                 height: 50,
                         width: screenWidth*0.43,
                 padding: EdgeInsets.symmetric(horizontal: 12.0),
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(4.0),
                   border: Border.all(color: Color(0xffD9D9D9)),
                   color: Colors.white,
                 ),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Text(
                       formattedDate,
                       style: TextStyle(
                         color: Colors.black,
                       ),
                     ),
                     Icon(Icons.calendar_today, color: Colors.grey),
                   ],
                 ),
               ),

                  ],
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   Text(
                            'Time*',
                            style: TextStyle(
                              color: Color(0xffD9D9D9),
                              fontFamily: 'Satoshi',
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 8.0),

                          Container(
                            height: 50,
                            width: screenWidth*0.43,
                            padding: EdgeInsets.symmetric(horizontal: 12.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.0),
                              border: Border.all(color: Color(0xffD9D9D9)),
                              color: Colors.white,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  formattedTime,
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                Icon(Icons.access_time, color: Colors.grey),
                              ],
                            ),
                          ),
                  ],
                )

                 // Row 3: Date
            

                                          
              ],
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

                        Text(
              'Select Project',
              style: TextStyle(
                color: Color(0xFF7A7A7A),
                fontFamily: 'Satoshi',
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
              ),
            ),

            SizedBox(height: 8.0),
           
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

             Text(
              'Task',
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
              height: 50.0,
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                border: Border.all(color: Color(0xFFB7B7B7)),
                color: Colors.white,
              ),
              child: TextField(
                maxLength: 25,
                maxLines: 1,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter a task',
                ),
              ),
            ),
            SizedBox(height: 8.0),
    
            // Row 10: Characters Remaining
            Text(
              '2/25 characters remaining',
              style: TextStyle(
                color: Colors.grey,
              ),
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
