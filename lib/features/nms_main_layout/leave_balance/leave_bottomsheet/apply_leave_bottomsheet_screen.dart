import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nms/utils/theme/theme_constants.dart';
import 'package:nms/widgets/cornered_button.dart';
import 'apply_leave_bottomsheet.dart';

class ApplyLeaveBottomSheetScreen extends StatefulWidget {
  const ApplyLeaveBottomSheetScreen({super.key});

  @override
  State<ApplyLeaveBottomSheetScreen> createState() =>
      _ApplyLeaveBottomSheetScreenState();
}

class _ApplyLeaveBottomSheetScreenState
    extends State<ApplyLeaveBottomSheetScreen> {
  double componentsHeight = 49;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return GetBuilder<ApplyLeaveBottomSheetController>(
        init: ApplyLeaveBottomSheetController(),
        builder: (controller) {
          return Container(
            width: screenWidth,
            height: screenHeight * .80,
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
                      width: 60,
                      height: 4,
                      decoration: BoxDecoration(
                        color: secondaryTextColor,
                        borderRadius: BorderRadius.circular(2.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8.0),

                  // Row 2: Apply Leave/WFH
                  const Center(
                    child: Text(
                      'Apply Leave/WFH',
                      style: TextStyle(
                        color: primaryTextColor,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8.0),

                  Container(
                    height: 1,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withOpacity(0.12),
                          width: 1,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Row 3: Headings

                  const Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Leave From*',
                          style: TextStyle(
                            color: secondaryTextColor,
                            fontFamily: 'Satoshi',
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'To*',
                          style: TextStyle(
                            color: secondaryTextColor,
                            fontFamily: 'Satoshi',
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8.0),

                  // Row 4: Date Picker

                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            border: Border.all(color: primaryGray),
                            color: backgroundColor,
                          ),
                          child: TextField(
                            controller: TextEditingController(
                              text: controller.leaveFromDate != null
                                  ? DateFormat('dd/MM/yyyy')
                                      .format(controller.leaveFromDate!)
                                  : 'Select',
                            ),
                            readOnly:
                                true, // Disable direct editing to force the user to select a date
                            onTap: () async {
                              // Trigger date picker on tap
                              await controller.clearDurationDropdown();
                              await controller.selectLeaveFromDate(context);
                              if (controller.validateDates()) {
                                await controller.getLeaveYearByLeaveDate();
                              }
                            },
                            decoration: const InputDecoration(
                              hintText: 'Select',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              border: InputBorder.none,
                              suffixIcon: Icon(Icons.calendar_today),
                            ),
                            style: TextStyle(
                              color: controller.leaveFromDate != null
                                  ? primaryTextColor
                                  : Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            border: Border.all(color: primaryGray),
                            color: backgroundColor,
                          ),
                          child: TextField(
                            controller: TextEditingController(
                              text: controller.toDate != null
                                  ? DateFormat('dd/MM/yyyy')
                                      .format(controller.toDate!)
                                  : 'Select',
                            ),
                            readOnly:
                                true, // Disable direct editing to force the user to select a date
                            onTap: () async {
                              // Trigger date picker on tap
                              await controller.clearDurationDropdown();
                              await controller.selectToDate(context);
                              if (controller.validateDates()) {
                                await controller.getLeaveYearByLeaveDate();
                              }
                            },
                            decoration: const InputDecoration(
                              hintText: 'Select',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              border: InputBorder.none,
                              suffixIcon: Icon(Icons.calendar_today),
                            ),
                            style: TextStyle(
                              color: controller.toDate != null
                                  ? Colors.black
                                  : Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Validation message below "To" date picker
                  if (controller.validationMessage != null)
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 8.0), // Add some spacing before the message
                      child: Text(
                        controller.validationMessage!,
                        style: const TextStyle(
                          color: Colors
                              .red, // Red color for the validation message
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  const SizedBox(height: 8.0),

                  // Row 5: Location
                  const Text(
                    'Leave Type*',
                    style: TextStyle(
                      color: secondaryTextColor,
                      fontFamily: 'Satoshi',
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 8.0),

                  // Row 6: Leave Dropdown

                  Obx(
                    () => DropdownButtonFormField2<String>(
                      iconStyleData: const IconStyleData(icon: SizedBox()),
                      dropdownStyleData:
                          const DropdownStyleData(maxHeight: 150),
                      menuItemStyleData: const MenuItemStyleData(),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(0),
                        errorText: controller.isLeaveTypeValid.value
                            ? null
                            : 'Please select leave type',
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
                          borderSide:
                              const BorderSide(color: lightGreenTextColor),
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
                          style: TextStyle(
                              fontSize: 16.0,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w500,
                              color: primaryGray),
                        ),
                      ),
                      items: controller
                          .leaveNames // Replace with your list of leaves
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 2.0),
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                        fontSize: 16, color: primaryTextColor),
                                  ),
                                ),
                              ))
                          .toList(),
                      value: controller.selectedLeaveType.value.isEmpty
                          ? null
                          : controller.selectedLeaveType.value,
                      validator: (value) {
                        if (value == null) {
                          return 'Select Leave Type';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        controller.selectedLeaveType.value = value!;
                        controller.isLeaveTypeValid.value = true;
                        controller.clearLeaveDocuments();
                        controller.selectedId.value = controller.getAllMinLeav
                            .firstWhere((element) => element.name == value)
                            .id;
                        controller.isEnforceAdjHoliday.value = controller
                            .getAllMinLeav
                            .firstWhere((element) => element.name == value)
                            .isEnforceAdjHoliday;
                        controller.updateSelectedDays();
                      },
                    ),
                  ),

                  const SizedBox(height: 8.0),

                  // Row 5: Duration
                  const Text(
                    'Duration*',
                    style: TextStyle(
                      color: secondaryTextColor,
                      fontFamily: 'Satoshi',
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 8.0),

                  // Row 6: Duration Dropdown

                  Obx(
                    () => DropdownButtonFormField2<String>(
                      iconStyleData: const IconStyleData(icon: SizedBox()),
                      dropdownStyleData:
                          const DropdownStyleData(maxHeight: 150),
                      menuItemStyleData: const MenuItemStyleData(),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(0),
                        errorText: controller.isDurationValid.value
                            ? null
                            : 'Please select duration',
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
                          borderSide:
                              const BorderSide(color: lightGreenTextColor),
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
                          style: TextStyle(
                              fontSize: 16.0,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w500,
                              color: primaryGray),
                        ),
                      ),
                      items: controller
                          .getDurationList() // Replace with your duration
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 2.0),
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                        fontSize: 16, color: primaryTextColor),
                                  ),
                                ),
                              ))
                          .toList(),
                      value: controller.selectedDuration.value.isEmpty
                          ? null
                          : controller.selectedDuration.value,
                      validator: (value) {
                        if (value == null) {
                          return 'Select Duration';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        controller.selectedDuration.value = value!;
                        controller.isDurationValid.value = true;
                        controller.clearLeaveDocuments();
                        controller.updateSelectedDays();
                      },
                    ),
                  ),

                  // Show selected days container
                  if (controller.selectedDays != null)
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 16.0), // Add spacing above the container
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          color:
                              veryLightGray, // Grey background color (#F1F1F1)
                        ),
                        padding: const EdgeInsets.all(
                            12.0), // Padding inside the container
                        child: Row(
                          children: [
                            SvgPicture.asset(
                                'assets/svg/info.svg'), // Notification icon
                            const SizedBox(
                                width: 8.0), // Spacing between icon and text
                            Text(
                              '${controller.selectedDays} day${controller.selectedDays! > 1 ? 's' : ''} selected', // Show n days selected
                              style: const TextStyle(
                                  color: secondaryTextColor,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                    ),

                  // In case of Compensatory Off
                  // if (controller.selectedLeaveType.value == 'Test Leave')
                  Obx(
                    () => controller.selectedLeaveType.value ==
                            'Compensation leave'
                        ? Padding(
                            padding: const EdgeInsets.only(
                                top: 16.0), // Add spacing above the container
                            child: Column(
                              children: [
                                const Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'In Lieu of*',
                                        style: TextStyle(
                                          color: secondaryTextColor,
                                          fontFamily: 'Satoshi',
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        'To*',
                                        style: TextStyle(
                                          color: secondaryTextColor,
                                          fontFamily: 'Satoshi',
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 8.0),

                                // Lieu Date Picker

                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4.0),
                                          border:
                                              Border.all(color: primaryGray),
                                          color: Colors.white,
                                        ),
                                        child: TextField(
                                          controller: TextEditingController(
                                            text: controller.lieuOfDate != null
                                                ? DateFormat('dd/MM/yyyy')
                                                    .format(
                                                        controller.lieuOfDate!)
                                                : 'Select',
                                          ),
                                          readOnly:
                                              true, // Disable direct editing to force the user to select a date
                                          onTap: () async {
                                            // Trigger date picker on tap
                                            await controller
                                                .selectLieuFromDate(context);
                                          },
                                          decoration: const InputDecoration(
                                            hintText: 'Select',
                                            hintStyle: TextStyle(
                                              color: Colors.grey,
                                            ),
                                            border: InputBorder.none,
                                            suffixIcon:
                                                Icon(Icons.calendar_today),
                                          ),
                                          style: TextStyle(
                                            color: controller.lieuOfDate != null
                                                ? primaryTextColor
                                                : Colors.grey,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4.0),
                                          border: Border.all(
                                              color: primaryGray),
                                          color: backgroundColor,
                                        ),
                                        child: TextField(
                                          controller: TextEditingController(
                                            text: controller.lieuToDate != null
                                                ? DateFormat('dd/MM/yyyy')
                                                    .format(
                                                        controller.lieuToDate!)
                                                : 'Select',
                                          ),
                                          readOnly:
                                              true, // Disable direct editing to force the user to select a date
                                          onTap: () async {
                                            // Trigger date picker on tap
                                            await controller
                                                .selectLieuToDate(context);
                                          },
                                          decoration: const InputDecoration(
                                            hintText: 'Select',
                                            hintStyle: TextStyle(
                                              color: Colors.grey,
                                            ),
                                            border: InputBorder.none,
                                            suffixIcon:
                                                Icon(Icons.calendar_today),
                                          ),
                                          style: TextStyle(
                                            color: controller.lieuToDate != null
                                                ? primaryTextColor
                                                : Colors.grey,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                // Validation message below "To" date picker
                                if (controller.lieuValidationMessage != null)
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top:
                                            8.0), // Add some spacing before the message
                                    child: Text(
                                      controller.lieuValidationMessage!,
                                      style: const TextStyle(
                                        color: Colors
                                            .red, // Red color for the validation message
                                        fontSize: 12.0,
                                      ),
                                    ),
                                  ),
                              ],
                            ))
                        : const SizedBox
                            .shrink(), // Empty widget if "Test Leave" is not selected
                  ),

                  const SizedBox(
                    height: 8,
                  ),

                  CommentsInput(controller: controller),

                  const SizedBox(height: 16.0),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Add File',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                        color: controller.files.length == 3
                            ? Colors.grey.shade400
                            : secondaryTextColor,
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
                            ? veryLightGray
                            : lightestGray, // Use theme color
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
                                  color: primaryTextColor,
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
                            : secondaryTextColor,
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
                        await controller.userLeaveRequest(context);
                      }
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  Widget _buildFileList(ApplyLeaveBottomSheetController controller) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: controller.files.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 5.0),
          decoration: BoxDecoration(
            color: scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(2.0),
          ),
          child: ListTile(
            leading: const Icon(Icons.insert_drive_file),
            title: Text(controller.files[index].name),
            trailing: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  controller.showCustomDialog(context, index);
                }),
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
          'Reason*',
          style: TextStyle(
            color: secondaryTextColor,
            fontFamily: 'Satoshi',
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 8.0),
        Obx(
          () => TextFormField(
            focusNode: controller.commentsFocusNode,
            maxLength: 200,
            maxLines: 5,
            controller: controller.commentController,
            decoration: InputDecoration(
              hintText: 'Enter reason here',
              hintStyle: const TextStyle(
                  fontSize: 16.0,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w500,
                  color: primaryGray),
              errorText: controller.isCommentValid.value
                  ? null
                  : 'Please enter a reason',
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
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
              controller.comment.value = value;
              controller.isCommentValid.value = true;
            },
          ),
        ),
      ],
    );
  }
}
