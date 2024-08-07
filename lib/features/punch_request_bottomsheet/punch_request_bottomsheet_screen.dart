import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nms/features/punch_request_bottomsheet/punch_request_bottomsheet_controller.dart';
import 'package:nms/widgets/cornered_button.dart';
import '../../utils/theme/theme_constants.dart';


class PunchRequestBottomSheetScreen extends StatefulWidget {
  const PunchRequestBottomSheetScreen({super.key});

  @override
  State<PunchRequestBottomSheetScreen> createState() => _PunchRequestBottomSheetScreenState();
}

class _PunchRequestBottomSheetScreenState extends State<PunchRequestBottomSheetScreen> {
  
  // String? selectedLocation;
  // final List<String> locations = ['WFO', 'WFH', 'On-Site', 'Hybrid'];
  // bool isLocationSelected = true;
  double componentsHeight = 49 ;


  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return GetBuilder<PunchRequestBottomSheetController>( 
      init: PunchRequestBottomSheetController(),
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
                  height: componentsHeight, // Increased height for Date Picker
                  child: GestureDetector(
                    onTap: () {
                     controller.selectDate(context);
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
                          Text(DateFormat('dd/MM/yyyy').format(controller.selectedDate),
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

                              Obx(() =>   DropdownButtonFormField2<String>(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(0),
                errorText: controller.isLocationValid.value ? null : 'Please select project',
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
              items: controller.locations // Replace with your list of locations
                  .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ))
                  .toList(),
              value: controller.selectedLocation.value.isEmpty ? null : controller.selectedLocation.value,
              validator: (value) {
            if (value == null) {
              return 'Select Location';
            }
            return null;
          },
              onChanged: (value) {
                controller.selectedLocation.value = value!;
                controller.isLocationValid.value = true;
              }, // Access the controller
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
                                  controller.showTimePickers(0, context);
                                },
                                child: Container(
                                  height: componentsHeight,
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
                                       controller.formatTime24Hour(controller.selectedTimes[0]),
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
                                 controller.showTimePickers(2, context);
                                },
                                child: Container(
                                  height: componentsHeight,
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
                                        controller.formatTime24Hour(controller.selectedTimes[2]),
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
                                 controller.showTimePickers(1, context);
                                },
                                child: Container(
                                  height: componentsHeight,
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
                                        controller.formatTime24Hour(controller.selectedTimes[1]),
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
                                controller.showTimePickers(3, context);
                                },
                                child: Container(
                                  height: componentsHeight,
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
                                         controller.formatTime24Hour(controller.selectedTimes[3]),
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
                  height: componentsHeight*2,
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    border: Border.all(color: Color(0xFFB7B7B7)),
                    color: Colors.white,
                  ),
                  child: TextField(
                    controller: controller.reasonController,
                    maxLength: 200,
                    maxLines: 5,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '',
                    ),
                  ),
                ),
                // SizedBox(height: 8.0),
        
                // // Row 10: Characters Remaining
                // Text(
                //   '200/200 characters remaining',
                //   style: TextStyle(
                //     color: Colors.grey,
                //   ),
                // ),
                SizedBox(height: 16.0),
        
                // Row 11: Submit Button
        
                CorneredButton(
                        height: componentsHeight,
                        color: primaryColor,
                        title: 'Submit',
                        textcolor: backgroundColor,
                        onPress: () async {
                        // await controller.userPunchRequest();
                        
                         controller.validateForm();
                    if (controller.isLocationValid.value) {
                      await controller.userPunchRequest();
                    }


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


