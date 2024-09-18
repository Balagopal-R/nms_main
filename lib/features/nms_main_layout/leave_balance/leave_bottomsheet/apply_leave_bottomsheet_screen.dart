import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nms/features/punch_request_bottomsheet/punch_request_bottomsheet_controller.dart';
import 'package:nms/utils/theme/theme_constants.dart';
import 'package:nms/widgets/cornered_button.dart';

import 'apply_leave_bottomsheet.dart';


class ApplyLeaveBottomSheetScreen extends StatefulWidget {
  const ApplyLeaveBottomSheetScreen({super.key});

  @override
  State<ApplyLeaveBottomSheetScreen> createState() => _ApplyLeaveBottomSheetScreenState();
}

class _ApplyLeaveBottomSheetScreenState extends State<ApplyLeaveBottomSheetScreen> {
  
  double componentsHeight = 49 ;


  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return GetBuilder<ApplyLeaveBottomSheetController>( 
      init: ApplyLeaveBottomSheetController(),
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
        
                // Row 2: Apply Leave/WFH
                Center(
                  child: Text(
                    'Apply Leave/WFH',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 8.0),
        
                // Row 3: Headings

              Row(
                children: [

                  Expanded(
                    child: Text(
                    'Leave From',
                    style: TextStyle(
                      color: Color(0xFF7A7A7A),
                      fontFamily: 'Satoshi',
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                    ),
                                    ),
                  ),

                  SizedBox(width: 10),

                Expanded(
                  child: Text(
                    'To',
                    style: TextStyle(
                      color: Color(0xFF7A7A7A),
                      fontFamily: 'Satoshi',
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),


                ],
              ),

                
                SizedBox(height: 8.0),
        
                // Row 4: Date Picker
                
                 Row(
                children: [

                  Expanded(
                    child: Container(
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
                  ),

                  SizedBox(width: 10),

                Expanded(
                  child: Container(
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
                ),


                ],
              ),

                SizedBox(height: 8.0),
        
                // Row 5: Location
                Text(
                  'Leave Type*',
                  style: TextStyle(
                    color: Color(0xFF7A7A7A),
                    fontFamily: 'Satoshi',
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 8.0),
        
                
                 // Row 6: Location Dropdown

                              Obx(() =>   DropdownButtonFormField2<String>(iconStyleData:const IconStyleData(icon: const SizedBox()),
                        
                        dropdownStyleData: DropdownStyleData(
                          maxHeight: 150
                        ),
                        menuItemStyleData: MenuItemStyleData(),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(0),
                errorText: controller.isLeaveTypeValid.value ? null : 'Please select leave type',
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
          fontWeight: FontWeight.w500,color: Color(0xffB7B7B7)),
        ),
      ),
              items: controller.leaveTypes // Replace with your list of leaves
                  .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 2.0),
                          child: Text(
                            item,
                            style: const TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ),
                      ))
                  .toList(),
              value: controller.selectedLeaveType.value.isEmpty ? null : controller.selectedLeaveType.value,
              validator: (value) {
            if (value == null) {
              return 'Select Leave Type';
            }
            return null;
          },
              onChanged: (value) {
                controller.selectedLeaveType.value = value!;
                controller.isLeaveTypeValid.value = true;
              }, 
            ),
                              ),
        
         SizedBox(height: 8.0),

                // Row 5: Location
                Text(
                  'Duration',
                  style: TextStyle(
                    color: Color(0xFF7A7A7A),
                    fontFamily: 'Satoshi',
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 8.0),

                  // Row 6: Duration

                              Obx(() =>   DropdownButtonFormField2<String>(iconStyleData:const IconStyleData(icon: const SizedBox()),
                        
                        dropdownStyleData: DropdownStyleData(
                          maxHeight: 150
                        ),
                        menuItemStyleData: MenuItemStyleData(),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(0),
                errorText: controller.isDurationValid.value ? null : 'Please select duration',
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
          fontWeight: FontWeight.w500,color: Color(0xffB7B7B7)),
        ),
      ),
              items: controller.duration // Replace with your duration
                  .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 2.0),
                          child: Text(
                            item,
                            style: const TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ),
                      ))
                  .toList(),
              value: controller.selectedDuration.value.isEmpty ? null : controller.selectedDuration.value,
              validator: (value) {
            if (value == null) {
              return 'Select Duration';
            }
            return null;
          },
              onChanged: (value) {
                controller.selectedDuration.value = value!;
                controller.isDurationValid.value = true;
              }, 
            ),
                              ),

                              SizedBox(height: 8,),
        


                CommentsInput(controller: controller),
 
                SizedBox(height: 16.0),


                Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Add File',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                          color: controller.files.length == 3
                              ? Colors.grey.shade400
                              : const Color(0xff7A7A7A),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    GestureDetector(
                      onTap: controller.files.length == 3
                          ? null
                          : controller.pickFiles,
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          color: controller.files.length == 3
                              ? Color(0xFFF1F1F1)
                              : Color(0xFFD9D9D9), // Use theme color
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/png/export.png', // Replace with actual image path
                                width: 24.0, // Adjust icon size as needed
                                height: 24.0, // Adjust icon size as needed
                              ),
                              const SizedBox(
                                  width:
                                      10.0), // Add spacing between icon and text
                              const Text(
                                'Choose File',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'JPEG, JPG or PDF, file size no more than 5MB',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: controller.files.length == 3
                              ? Colors.grey.shade400
                              : const Color(0xFF7A7A7A),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    _buildFileList(controller),
                    const SizedBox(height: 10.0),
        
                // Row 11: Submit Button
        
                CorneredButton(
                        height: componentsHeight,
                        color: primaryColor,
                        title: 'Submit',
                        textcolor: backgroundColor,
                        onPress: () async {
                        
                         controller.validateForm();
                    if (controller.isLeaveTypeValid.value &&
                        controller.isDurationValid.value &&
                        controller.isCommentValid.value) {
                      await controller.uploadFiles(controller.files);
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

   Widget _buildFileList(ApplyLeaveBottomSheetController controller) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: controller.files.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 5.0),
          decoration: BoxDecoration(
            color: const Color(0xFFFAFAFA),
            borderRadius: BorderRadius.circular(2.0),
          ),
          child: ListTile(
            leading: const Icon(Icons.insert_drive_file),
            title: Text(controller.files[index].name),
            trailing: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                controller.showCustomDialog(context,index);
              }
            ),
          ),
        );
      },
    );
  }
}

class CommentsInput extends StatelessWidget {
  final ApplyLeaveBottomSheetController controller;

  const CommentsInput({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Comments',
          style: TextStyle(
            color: Color(0xFF7A7A7A),
            fontFamily: 'Satoshi',
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 8.0),
         Obx(() => TextFormField(
          focusNode: controller.commentsFocusNode,
          maxLength: 200,
          maxLines: 5,
          controller: controller.commentController,
          decoration: InputDecoration(
            hintText: 'Enter comments',
            hintStyle: const TextStyle(fontSize: 16.0,fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w500,color: Color(0xffB7B7B7)),
            errorText: controller.isCommentValid.value ? null : 'Please enter a comment',
            contentPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
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
          onChanged: (value) {
                controller.comment.value = value;
                controller.isCommentValid.value = true;
              },
        ),
         ),
      ],
    );
  }
}


