import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:nms/features/punch_request_bottomsheet/punch_request_bottomsheet_controller.dart';
import 'package:nms/utils/theme/theme_constants.dart';
import 'package:nms/widgets/cornered_button.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart'; 

class PunchInOutBottomSheetScreen extends StatefulWidget {
   
   final String title;
    PunchInOutBottomSheetScreen(
      {Key? key,
      required this.title,})
      : super(key: key);

  @override
  State<PunchInOutBottomSheetScreen> createState() => _PunchInOutBottomSheetScreenState();
}

class _PunchInOutBottomSheetScreenState extends State<PunchInOutBottomSheetScreen> {

   String? selectedLocation;
   final List<String> locations = ['WFO', 'WFH', 'On-Site', 'Hybrid'];
   bool isLocationSelected = true;

   String? selectedProject;
   final List<String> project = ['NMS', 'KESHER', 'Premium Shop', 'NMS Chat','Winemonger','Quotely','Just Borrow','Cakesys','Unassigned','Trybond'];
   bool isProjectSelected = true;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    final today = DateTime.now(); // Get the current date
    final formattedDate = DateFormat('dd/MM/yyyy').format(today); // Format the date

    final now = DateTime.now();
    final formattedTime = DateFormat('HH:mm').format(now); // Format in 24-hour format

    String? selectedValue = '';

    return GetBuilder<PunchRequestBottomSheetController>(
      init : PunchRequestBottomSheetController(),
      builder: (controller) {
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
                    widget.title,
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
      
                          DropdownButtonFormField2<String>(
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(color: Color(0xFFB7B7B7)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(color: Color(0xFFB7B7B7)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(color: Color(0xFF3BBCA0)),
            ),
            filled: true,
            fillColor: const Color(0xFFFFFFFF),
          ),
          isExpanded: true,
          hint: const Text(
            'Select',
            style: TextStyle(fontSize: 16),
          ),
          // icon: Padding(
          //   padding: const EdgeInsets.only(right: 10),
          //   child: Image.asset(
          //     'assets/images/chevron_down.png', // Replace with your asset image path
          //     height: 20,
          //     width: 20,
          //   ),
          // ),
          // iconSize: 30,
          // buttonHeight: 50,
          // buttonWidth: MediaQuery.of(context).size.width,
          items: locations
              .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ))
              .toList(),
          validator: (value) {
            if (value == null) {
              return 'Select Category';
            }
            return null;
          },
          onChanged: (value) {
            setState(() {
              selectedLocation = value as String?;
              isLocationSelected = true;
            });
          },
          onSaved: (value) {
            setState(() {
              selectedLocation = value as String?;
            });
          },
        ),
        if (!isLocationSelected)
         const Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              'Select Location',
              style: TextStyle(
                color: Colors.red,
                fontSize: 12,
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

              //  Select Project Dropdown
                  DropdownButtonFormField2<String>(
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(color: Color(0xFFB7B7B7)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(color: Color(0xFFB7B7B7)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(color: Color(0xFF3BBCA0)),
            ),
            filled: true,
            fillColor: const Color(0xFFFFFFFF),
          ),
          isExpanded: true,
          hint: const Text(
            'Select',
            style: TextStyle(fontSize: 16),
          ),
          // icon: Padding(
          //   padding: const EdgeInsets.only(right: 10),
          //   child: Image.asset(
          //     'assets/images/chevron_down.png', // Replace with your asset image path
          //     height: 20,
          //     width: 20,
          //   ),
          // ),
          // iconSize: 30,
          // buttonHeight: 50,
          // buttonWidth: MediaQuery.of(context).size.width,
          items: project
              .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ))
              .toList(),
          validator: (value) {
            if (value == null) {
              return 'Select Category';
            }
            return null;
          },
          onChanged: (value) {
            setState(() {
              selectedProject = value as String?;
              isProjectSelected = true;
            });
          },
          onSaved: (value) {
            setState(() {
              selectedProject = value as String?;
            });
          },
        ),
        if (!isProjectSelected)
         const Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              'Select Project',
              style: TextStyle(
                color: Colors.red,
                fontSize: 12,
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
                      hintText: '',
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
                      hintText: '',
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
    );
  }
}
