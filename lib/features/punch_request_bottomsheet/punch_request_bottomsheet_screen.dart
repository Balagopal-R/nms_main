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
          padding: const EdgeInsets.all(16.0),
          decoration: const BoxDecoration(
            color: backgroundColor,
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
                      color: secondaryTextColor,
                      borderRadius: BorderRadius.circular(2.0),
                    ),
                  ),
                ),
                const SizedBox(height: 8.0),
        
                // Row 2: Punch Request
                const Center(
                  child: Text(
                    'Punch Request',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 8.0),
        
                // Row 3: Date
                const Text(
                  'Date*',
                  style: TextStyle(
                    color: secondaryTextColor,
                    fontFamily: 'Satoshi',
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 8.0),
        
                // Row 4: Date Picker
                SizedBox(
                  height: componentsHeight, // Increased height for Date Picker
                  child: GestureDetector(
                    onTap: () {
                     controller.selectDate(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        border: Border.all(color: primaryGray),
                        color: backgroundColor,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(DateFormat('dd/MM/yyyy').format(controller.selectedDate),
                            style: const TextStyle(
                              color: primaryTextColor,
                            ),
                          ),
                          const Icon(Icons.calendar_today, color: primaryGray),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8.0),
        
                // Row 5: Location
                const Text(
                  'Location*',
                  style: TextStyle(
                    color: secondaryTextColor,
                    fontFamily: 'Satoshi',
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 8.0),
        
                
                 // Row 6: Location Dropdown

                              Obx(() =>   DropdownButtonFormField2<String>(iconStyleData:const IconStyleData(icon: SizedBox()),
                        
                        dropdownStyleData: const DropdownStyleData(
                          maxHeight: 150
                        ),
                        menuItemStyleData: const MenuItemStyleData(),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(0),
                errorText: controller.isLocationValid.value ? null : 'Please select project',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(color: primaryGray),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(color: primaryGray),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(color: lightGreenTextColor),
                ),
                filled: true,
                fillColor: backgroundColor,
                suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Image.asset(
            'assets/png/arrow_down.png', // Replace with your asset path
            height: 24,
            width: 24,
          ),
        ),
              ),
              isExpanded: true,
              hint: const Padding(
        padding: EdgeInsets.only(left: 2.0),
        child: Text(
          'Select',
          style: TextStyle(fontSize: 16.0,fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w500,color: primaryGray),
        ),
      ),
              items: controller.locations // Replace with your list of locations
                  .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 2.0),
                          child: Text(
                            item,
                            style: const TextStyle(fontSize: 16, color: primaryTextColor),
                          ),
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
              }, 
            ),
                              ),
        
         const SizedBox(height: 8.0),
          
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
        
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Punch In Time*',
                                style: TextStyle(
                                  color: secondaryTextColor,
                                  fontFamily: 'Satoshi',
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              GestureDetector(
                                onTap: () {
                                  controller.showTimePickers(0, context);
                                },
                                child: Container(
                                  height: componentsHeight,
                                  width: screenWidth*0.41,
                                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4.0),
                                    border: Border.all(color: primaryGray),
                                    color: backgroundColor,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                       controller.formatTime24Hour(controller.selectedTimes[0]),
                                        style: const TextStyle(
                                          color: primaryTextColor,
                                        ),
                                      ),
                                      const Icon(Icons.access_time, color: primaryGray),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              const Text(
                                'Break*',
                                style: TextStyle(
                                  color: secondaryTextColor,
                                  fontFamily: 'Satoshi',
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              GestureDetector(
                                onTap: () {
                                 controller.showTimePickers(2, context);
                                },
                                child: Container(
                                  height: componentsHeight,
                                  width: screenWidth*0.41,
                                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4.0),
                                    border: Border.all(color: secondaryTextColor),
                                    color: Colors.white,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        controller.formatTime24Hour(controller.selectedTimes[2]),
                                        style: const TextStyle(
                                          color: primaryTextColor,
                                        ),
                                      ),
                                      const Icon(Icons.access_time, color: primaryGray),
                                    ],
                                  ),
                                ),
                              ),
                              if (controller.breakValidationMessage != null)
      Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: Text(
          controller.breakValidationMessage!,
          style: const TextStyle(color: Colors.red, fontSize: 12.0),
        ),
      ),
                            ],
                          ),
                   
                      const SizedBox(width: 16.0),
                      
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Punch Out Time*',
                                style: TextStyle(
                                  color: secondaryTextColor,
                                  fontFamily: 'Satoshi',
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              GestureDetector(
                                onTap: () {
                                 controller.showTimePickers(1, context);
                                },
                                child: Container(
                                  height: componentsHeight,
                                  width: screenWidth*0.41,
                                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4.0),
                                    border: Border.all(color: primaryGray),
                                    color: Colors.white,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        controller.formatTime24Hour(controller.selectedTimes[1]),
                                        style: const TextStyle(
                                          color: primaryTextColor,
                                        ),
                                      ),
                                      const Icon(Icons.access_time, color: primaryGray),
                                    ],
                                  ),
                                ),
                              ),
                                                            if (controller.punchOutValidationMessage != null)
      Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: Text(
          controller.punchOutValidationMessage!,
          style: const TextStyle(color: Colors.red, fontSize: 12.0),
        ),
      ),

                              const SizedBox(height: 16.0),
                              const Text(
                                'Resume*',
                                style: TextStyle(
                                  color: secondaryTextColor,
                                  fontFamily: 'Satoshi',
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              GestureDetector(
                                onTap: () {
                                controller.showTimePickers(3, context);
                                },
                                child: Container(
                                  height: componentsHeight,
                                  width: screenWidth*0.41,
                                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4.0),
                                    border: Border.all(color: primaryGray),
                                    color: Colors.white,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                         controller.formatTime24Hour(controller.selectedTimes[3]),
                                        style: const TextStyle(
                                          color: primaryTextColor,
                                        ),
                                      ),
                                      const Icon(Icons.access_time, color: primaryGray),
                                    ],
                                  ),
                                ),
                              ),
                               if (controller.resumeValidationMessage != null)
      Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: Text(
          controller.resumeValidationMessage!,
          style: const TextStyle(color: Colors.red, fontSize: 12.0),
        ),
      ),

                            ],
                          ),
                    ],
                  ),
            
                const SizedBox(height: 16.0),

                ReasonInput(controller: controller),
        
                // SizedBox(height: 8.0),
        
                // // Row 10: Characters Remaining
                // Text(
                //   '200/200 characters remaining',
                //   style: TextStyle(
                //     color: Colors.grey,
                //   ),
                // ),
                const SizedBox(height: 16.0),
        
                // Row 11: Submit Button
        
                CorneredButton(
                        height: componentsHeight,
                        color: primaryColor,
                        title: 'Submit',
                        textcolor: backgroundColor,
                        onPress: () async {
                        
                         controller.validateForm();
                    if (controller.isLocationValid.value &&
                        controller.isReasonValid.value) {
                      await controller.userPunchRequest(context);
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

class ReasonInput extends StatelessWidget {
  final PunchRequestBottomSheetController controller;

  const ReasonInput({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Reason*',
          style: TextStyle(
            color: secondaryTextColor,
            fontFamily: 'Satoshi',
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 8.0),
         Obx(() => TextFormField(
          focusNode: controller.reasonFocusNode,
          maxLength: 200,
          maxLines: 5,
          controller: controller.reasonController,
          decoration: InputDecoration(
            hintText: 'Enter task',
            hintStyle: const TextStyle(fontSize: 16.0,fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w500,color: primaryGray),
            errorText: controller.isReasonValid.value ? null : 'Please enter a reason',
            contentPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(color: primaryGray),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(color: primaryGray),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(color: lightGreenTextColor),
            ),
            filled: true,
            fillColor: backgroundColor,
          ),
          onChanged: (value) {
                controller.reason.value = value;
                controller.isReasonValid.value = true;
              },
        ),
         ),
      ],
    );
  }
}


