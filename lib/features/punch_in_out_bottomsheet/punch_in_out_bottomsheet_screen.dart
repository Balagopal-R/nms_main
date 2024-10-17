import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:nms/features/punch_in_out_bottomsheet/punch_in_out_bottomsheet.dart';
import 'package:nms/utils/theme/theme_constants.dart';
import 'package:nms/widgets/cornered_button.dart';
import 'package:get/get.dart';

class PunchInOutBottomSheetScreen extends StatelessWidget {
  final String title;

  const PunchInOutBottomSheetScreen({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return GetBuilder<PunchInOutBottomSheetController>(
      init: PunchInOutBottomSheetController(),
      builder: (controller) {
        // return Container(
        return Obx(() => Container(
        // AnimatedContainer(
        //   duration: Duration(milliseconds: 300),
          width: screenWidth,
          // height: screenHeight * 0.80,
          height: controller.isTaskOrDescriptionFocused.value
              ? screenHeight * 1.20 // Adjust the height when task or description is focused
              : screenHeight * 0.80, // Normal height
          padding: const EdgeInsets.all(16.0),
          decoration: const BoxDecoration(
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
                const SizedBox(height: 16.0),
                Center(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: primaryTextColor,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                DateAndTimePicker(controller: controller),
                const SizedBox(height: 8.0),
                LocationDropdown(controller: controller),
                const SizedBox(height: 8.0),
                ProjectDropdown(controller: controller),
                const SizedBox(height: 8.0),
                TaskInput(controller: controller),
                const SizedBox(height: 8.0),
                DescriptionInput(controller: controller),
                const SizedBox(height: 10.0),
                CorneredButton(
                  height: 47,
                  color: primaryColor,
                  title: 'Submit',
                  textcolor: backgroundColor,
                  onPress: () async {

                     controller.validateForm();
                    if (controller.isLocationValid.value &&
                        controller.isProjectValid.value &&
                        controller.isTaskValid.value) {
                      if (title == 'Punch IN') {
                      await controller.userPunchIn(context);
    
                  
                    } else {
                      await controller.userPunchOut(context);
                    }
                    }
                  },
                )
              ],
            ),
          ),
        // )
      )
      );
      },
    );
  }
}

// floatingActionButton: Container(
//                 height: 60,
//                 width: double.maxFinite,
//                 decoration: const BoxDecoration(
//                   color: Colors.white,
//                 ),
//                 child: Padding(
//                   padding:
//                       const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//                   child: CorneredButton(
//                     height: 40,
//                     onPress: () async {
//                       await controller.updateProduct();
//                     },
//                     color: primaryColor,
//                     title: "Update",
//                     textcolor: backgroundColor,
//                   ),
//                 )),
//             floatingActionButtonLocation:
//                 FloatingActionButtonLocation.centerDocked,

class DateAndTimePicker extends StatelessWidget {
  final PunchInOutBottomSheetController controller;

  const DateAndTimePicker({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double componentsHeight = 45;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Date',
              style: TextStyle(
                color: lightestGray,
                fontFamily: 'Satoshi',
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 8.0),
            Container(
              height: componentsHeight,
              width: screenWidth * 0.43,
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                border: Border.all(color: lightestGray),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    controller.formattedDate,
                    style: const TextStyle(
                color: lightestGray,
                fontFamily: 'Satoshi',
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
              ),
                  ),
                  const Icon(Icons.calendar_today, color: lightestGray),
                ],
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Time',
              style: TextStyle(
                color: lightestGray,
                fontFamily: 'Satoshi',
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 8.0),
            Container(
              height: componentsHeight,
              width: screenWidth * 0.43,
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                border: Border.all(color: lightestGray),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    controller.formattedTime,
                    style: const TextStyle(
                color: lightestGray,
                fontFamily: 'Satoshi',
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
              ),
                  ),
                  const Icon(Icons.access_time, color: lightestGray),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}

class LocationDropdown extends StatelessWidget {
  final PunchInOutBottomSheetController controller;

  const LocationDropdown({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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

        Obx(() => DropdownButtonFormField2<String>(
          iconStyleData:const IconStyleData(icon: SizedBox()),
                        
                        dropdownStyleData: const DropdownStyleData(
                          maxHeight: 150
                        ),
                        menuItemStyleData: const MenuItemStyleData(),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(0),
             errorText: controller.isLocationValid.value ? null : 'Please select location',
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
          items: controller.locations
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
      ],
    );
  }
}

class ProjectDropdown extends StatelessWidget {
  final PunchInOutBottomSheetController controller;

  const ProjectDropdown({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select Project*',
          style: TextStyle(
            color: secondaryTextColor,
            fontFamily: 'Satoshi',
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 8.0),

        Obx(() => DropdownButtonFormField2<String>(
           iconStyleData:const IconStyleData(icon: SizedBox()),
                        
                        dropdownStyleData: const DropdownStyleData(
                          maxHeight: 150
                        ),
                        menuItemStyleData: const MenuItemStyleData(),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(0),
            errorText: controller.isProjectValid.value ? null : 'Please select project',
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
          items: controller.projects
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
          value: controller.selectedProject.value.isEmpty ? null : controller.selectedProject.value,
          onChanged: (value) {
                controller.selectedProject.value = value!;
                controller.isProjectValid.value = true;
              },
        ),
        ),
      ],
    );
  }
}

class TaskInput extends StatelessWidget {
  final PunchInOutBottomSheetController controller;

  const TaskInput({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Task*',
          style: TextStyle(
            color: secondaryTextColor,
            fontFamily: 'Satoshi',
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 8.0),
         Obx(() => TextFormField(
          focusNode: controller.taskFocusNode,
          maxLength: 25,
          maxLines: 1,
          controller: controller.taskController,
          decoration: InputDecoration(
            hintText: 'Enter task',
            hintStyle: const TextStyle(fontSize: 16.0,fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w500,color: primaryGray),
            errorText: controller.isTaskValid.value ? null : 'Please enter task',
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
                controller.task.value = value;
                controller.isTaskValid.value = true;
              },
        ),
         ),
      ],
    );
  }
}

class DescriptionInput extends StatelessWidget {
  final PunchInOutBottomSheetController controller;

  const DescriptionInput({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Description',
          style: TextStyle(
            color: secondaryTextColor,
            fontFamily: 'Satoshi',
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 8.0),
        TextFormField(
          focusNode: controller.descriptionFocusNode,
          controller: controller.descriptionController,
           maxLength: 200,         
           maxLines: 4,
          decoration: InputDecoration(
            hintText: 'Enter description',
            hintStyle: const TextStyle(fontSize: 16.0,fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w500,color: primaryGray),
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
        ),
      ],
    );
  }
}
