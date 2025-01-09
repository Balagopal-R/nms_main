import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nms/features/basic_details/basic_details.dart';
import 'package:nms/features/basic_details/widgets/work_details.dart';
import 'package:nms/utils/theme/theme.dart';
import '../../widgets/appbar_main_widget.dart';
import 'widgets/basic_info_card.dart';
import 'widgets/work_status.dart';

class BasicDetailsScreen extends StatelessWidget {
  const BasicDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BasicDetailsController>(
        init: BasicDetailsController(),
        builder: (controller) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: backgroundColor,
              appBar: appbarMain(context, 'Basic Details'),
              body: controller.getEmployData != null
                  ? Padding(
                      padding: const EdgeInsets.only(left: 32, right: 32),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 24,
                            ),
                            Center(
                                child: CircleAvatar(
                              radius: 44,
                              backgroundColor: backgroundColor,
                              backgroundImage: NetworkImage(
                                  controller.getEmployData!.profileImgUrl!),
                            )),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              ' ${controller.getEmployData!.personalDetails.firstname} ${controller.getEmployData!.personalDetails.lastname}',
                              style: const TextStyle(
                                  color: primaryTextColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700),
                            ),
                            Text(
                              controller.getEmployData!.employeeCode,
                              style: const TextStyle(
                                  color: secondaryTextColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            const Row(
                              children: [
                                Text(
                                  "Basic Information",
                                  style: TextStyle(
                                      color: primaryTextColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            BasicInfoCard(
                              email: controller
                                  .getEmployData!.personalDetails.personalEmail,
                              mobileNumber: controller.getEmployData!
                                  .personalDetails.personalMobileNumber,
                              joiningDate: controller.formatDate(controller
                                  .getEmployData!.corporateDetails.joiningDate
                                  .toString()),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            const Row(
                              children: [
                                Text(
                                  "Work Details",
                                  style: TextStyle(
                                      color: primaryTextColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            WorkDetailsCard(
                                salary: controller.getEmployData?.corporateDetails?.ctc?.toString() ?? '_',
                                project: controller
                                            .getEmployData
                                            ?.corporateDetails
                                            .projects
                                            .isNotEmpty ==
                                        true
                                    ? controller.getEmployData!.corporateDetails
                                        .projects[0].projectName
                                    : '_',
                                buddy: '',
                                manager: controller
                                            .getEmployData
                                            ?.corporateDetails
                                            .managers!
                                            .isNotEmpty == true
                                    ? controller
                                        .getEmployData!
                                        .corporateDetails
                                        .managers![0]
                                        .personalDetailsBuddy
                                        .firstname
                                    : '_'),
                            const SizedBox(
                              height: 16,
                            ),
                            const Row(
                              children: [
                                Text(
                                  "Work Status",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            WorkStatusCard(
                              department: controller.getEmployData?.corporateDetails.department.departmentName ?? '_',
                              designation: controller.getEmployData?.corporateDetails.designation.designationName ?? '_',
                              employmentStatus: controller.getEmployData!
                                      .corporateDetails.employmentStatus ??
                                  'Status Not Updated',
                              officeLocation: controller.getEmployData!
                                      .corporateDetails.officeLocation ??
                                  'Location Not Updated',
                              workMode: controller.getEmployData!
                                      .corporateDetails.workMode ??
                                  'Not Updated',
                              shiftTime: "",
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                          ],
                        ),
                      ),
                    )
                  : const Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      ),
                    ),
            ),
          );
        });
  }
}
