import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nms/utils/theme/theme_constants.dart';
import 'package:nms/widgets/cornered_button.dart';
import 'package:nms/widgets/punch_in_request_bottomsheet.dart';
import 'package:nms/widgets/punch_out_request_bottomsheet.dart';
import 'dashboard_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'dart:math';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool isExpanded = false;
  bool isFullyExpanded = false;

  void toggleExpanded() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
        init: DashboardController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: scaffoldBackgroundColor,
            appBar: AppBar(
              backgroundColor: scaffoldBackgroundColor,
              title: InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.only(left: 1.0),
                  child: controller.getEmployData != null
                      ? Row(
                          children: [
                            const Text(
                              'Hello',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              '${controller.getEmployData!.personalDetails.firstname} ${controller.getEmployData!.personalDetails.lastname}!',
                              style: const TextStyle(
                                  color: primaryTextColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700),
                            )
                          ],
                        )
                      : const Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        ),
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: InkWell(
                      onTap: () async {
                        // await controller.searchDisplay();
                      },
                      child: SvgPicture.asset(
                        'assets/svg/notification.svg',
                        height: 24,
                        width: 24,
                      )),
                ),
              ],
            ),
            body: controller.getEmployData != null
                ? SingleChildScrollView(
                    child: Column(
                      children: [
                        // First Container
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: backgroundColor,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(
                                      0.05), // Slight grey shadow with 5% opacity
                                  offset: const Offset(
                                      0, 4), // Shadow offset 4px down
                                  blurRadius: 18.0, // Blur radius of the shadow
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        controller.punchStatus == "ON_TIME" ||
                                                controller.punchStatus == "LATE"
                                            ? "You're Punched IN"
                                            : "You're Punched OUT",
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                          color: primaryTextColor,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(2.667),
                                              color: controller
                                                  .getContainerColorBasedOnPunchStatus(
                                                      controller.punchStatus),
                                            ),
                                            child: Row(
                                              children: [
                                                CircleAvatar(
                                                  radius: 4,
                                                  backgroundColor: controller
                                                      .getColorBasedOnPunchStatus(
                                                          controller
                                                              .punchStatus),
                                                ),
                                                const SizedBox(width: 4),
                                                Text(
                                                  controller.punchStatus,
                                                  style: TextStyle(
                                                      color: controller
                                                          .getColorBasedOnPunchStatus(
                                                              controller
                                                                  .punchStatus)),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                LinearPercentIndicator(
                                  lineHeight: 8.0,
                                  percent: 0.7, // Example value
                                  backgroundColor: Colors.grey[300]!,
                                  linearGradient: const LinearGradient(
                                    colors: [
                                      primaryLightColor,
                                      primaryLightColor,
                                      darkShadeYellow,
                                      darkShadeYellow,
                                      primaryLightColor
                                    ],
                                    stops: [
                                      0.0,
                                      0.30,
                                      0.3,
                                      0.6,
                                      0.60
                                    ], // Adjust the stops for the amber section
                                  ),
                                  barRadius: const Radius.circular(20),
                                  // clipLinearGradient: true,
                                ),
                                const SizedBox(height: 8),
                                const Padding(
                                  padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                          radius: 3,
                                          backgroundColor: lightGreenTextColor),
                                      SizedBox(width: 4),
                                      Text('5 hours 25 minutes'),
                                      SizedBox(width: 16),
                                      CircleAvatar(
                                          radius: 3,
                                          backgroundColor: darkShadeYellow),
                                      SizedBox(width: 4),
                                      Text('23 minutes'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Second Container
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            padding: const EdgeInsets.all(0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: backgroundColor,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(
                                      0.05), // Slight grey shadow with 5% opacity
                                  offset: const Offset(
                                      0, 4), // Shadow offset 4px down
                                  blurRadius: 18.0, // Blur radius of the shadow
                                ),
                              ],
                            ),
                            child: Expanded(
                              child: CarouselSlider(
                                options: CarouselOptions(
                                  viewportFraction: 1.0,
                                  height: 300.0,
                                  //  autoPlay: true
                                ),
                                items: [
                                  // _buildChartPage(
                                  //     'Avg Break Time',
                                  //     [
                                  //       controller.getEmployeAveragePunchTime[3]
                                  //               .clockedBreakMinutes
                                  //               .toDouble() /
                                  //           3600,
                                  //       controller.getEmployeAveragePunchTime[4]
                                  //               .clockedBreakMinutes
                                  //               .toDouble() /
                                  //           3600,
                                  //       controller.getEmployeAveragePunchTime[5]
                                  //               .clockedBreakMinutes
                                  //               .toDouble() /
                                  //           3600,
                                  //       controller.getEmployeAveragePunchTime[6]
                                  //               .clockedBreakMinutes
                                  //               .toDouble() /
                                  //           3600,
                                  //       controller.getEmployeAveragePunchTime[0]
                                  //               .clockedBreakMinutes
                                  //               .toDouble() /
                                  //           3600,
                                  //       controller.getEmployeAveragePunchTime[1]
                                  //               .clockedBreakMinutes
                                  //               .toDouble() /
                                  //           3600,
                                  //       controller.getEmployeAveragePunchTime[2]
                                  //               .clockedBreakMinutes
                                  //               .toDouble() /
                                  //           3600,
                                  //     ],
                                  //     '${controller.formatDoubleWithTwoDecimals(controller.avgBreakTime)} hrs',
                                  //     'Last 7 days',
                                  //     'assets/svg/ph_coffee_bold.svg',
                                  //     lightShadeYellow,
                                  //     darkShadeYellow,
                                  //     controller.daysOfWeek),
                                  _buildChartPage(
                                      'Avg Punch Time',
                                      [
                                        controller.getEmployeAveragePunchTime[0]
                                                .clockedWorkingMinutes
                                                .toDouble() /
                                            3600,
                                        controller.getEmployeAveragePunchTime[1]
                                                .clockedWorkingMinutes
                                                .toDouble() /
                                            3600,
                                        controller.getEmployeAveragePunchTime[2]
                                                .clockedWorkingMinutes
                                                .toDouble() /
                                            3600,
                                        controller.getEmployeAveragePunchTime[3]
                                                .clockedWorkingMinutes
                                                .toDouble() /
                                            3600,
                                        controller.getEmployeAveragePunchTime[4]
                                                .clockedWorkingMinutes
                                                .toDouble() /
                                            3600,
                                        controller.getEmployeAveragePunchTime[5]
                                                .clockedWorkingMinutes
                                                .toDouble() /
                                            3600,
                                        controller.getEmployeAveragePunchTime[6]
                                                .clockedWorkingMinutes
                                                .toDouble() /
                                            3600,
                                      ],
                                      '${controller.formatDoubleWithTwoDecimals(controller.avgPunchTime)} hrs',
                                      // '8.6 Hrs',
                                      ' Last 7 days',
                                      'assets/svg/clock.svg',
                                      veryLightGreenColor,
                                      primaryLightColor,
                                      controller.daysOfWeek),
                                  // _buildChartPage(
                                  //     'Attendance',
                                  //     [17, 18, 16, 19, 20, 21, 17],
                                  //     controller.getAttendance.toString(),
                                  //     'This Month',
                                  //     'assets/svg/attendance.svg',
                                  //     veryLightShadeBlue,
                                  //     primaryblue,
                                  //     controller.monthsInYear),
                                  // _buildTextPage(
                                  //     'Birthdays',
                                  //     controller.birthdayName,
                                  //     controller.daysToBirthday,
                                  //     'assets/svg/cake.svg',
                                  //     lightShadeYellow,
                                  //     controller.imageOfBirthdays),
                                  // _buildTextPage(
                                  //     'Upcoming Leaves',
                                  //     [
                                  //       'Sick Leave',
                                  //       'Casual Leave',
                                  //       'Privilege Leave'
                                  //     ],
                                  //     [
                                  //       'Tomorrow',
                                  //       'May 19, 2024',
                                  //       'May 17, 2024'
                                  //     ],
                                  //     'assets/svg/upcoming_leaves.svg',
                                  //     veryLightGreenColor,
                                  //     ['', '', '']),
                                  // _buildTextPage(
                                  //     'Leave History',
                                  //     [
                                  //       'Sick Leave',
                                  //       'Casual Leave',
                                  //       'Privilege Leave'
                                  //     ],
                                  //     [
                                  //       'Yesterday',
                                  //       'Feb 19, 2024',
                                  //       'Feb 17, 2024'
                                  //     ],
                                  //     'assets/svg/calendar_remove.svg',
                                  //     veryLightShadeBlue,
                                  //     ['', '', '']),
                                ].map((i) {
                                  return Builder(
                                    builder: (BuildContext context) {
                                      return i;
                                    },
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),

                        // Third Container
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: backgroundColor,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(
                                      0.05), // Slight grey shadow with 5% opacity
                                  offset: const Offset(
                                      0, 4), // Shadow offset 4px down
                                  blurRadius: 18.0, // Blur radius of the shadow
                                ),
                              ],
                            ),
                            child: buildRemainingLeavesCard(controller),
                          ),
                        ),
                      ],
                    ),
                  )
                : const Center(
                    child: CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  ),

                            floatingActionButton: FloatingActionButton(
            onPressed: () async {
              await controller.getLastPunchIn();
              if (controller.getEmployPunchIn?.punchOutDateTime != null) {
                await showModalBottomSheet(
                  // ignore: use_build_context_synchronously
                  context: context,
                  builder: (context) {
                    return const PunchInRequestSheetContent();
                  },
                );
              } else {
                await showModalBottomSheet(
                  // ignore: use_build_context_synchronously
                  context: context,
                  builder: (context) {
                    return const PunchOutRequestSheetContent();
                  },
                );
              }
            },
            backgroundColor: lightGreenTextColor,
            child: const Image(
              image: AssetImage('assets/png/plus.png'),
            ),
          ),
          
            // floatingActionButton: SpeedDial(
            //   shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(7)),
            //   buttonSize: const Size(48, 48),
            //   //animatedIcon: AnimatedIcons.add_event,
            //   icon: Icons.arrow_upward_rounded,
            //   childPadding: const EdgeInsets.only(right: 5, left: 5),
            //   activeIcon: Icons.close,
            //   childrenButtonSize: const Size(48, 38),
            //   overlayColor: Colors.black,
            //   overlayOpacity: 0.8,
            //   spacing: 5,
            //   spaceBetweenChildren: 8,
            //   iconTheme: const IconThemeData(
            //     color: Colors.white,
            //     size: 24,
            //   ),
            //   backgroundColor: primaryColor,
            //   children: [
            //     SpeedDialChild(
            //         shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(7)),
            //         backgroundColor: Colors.white,
            //         labelBackgroundColor: Colors.transparent,
            //         labelShadow: [],
            //         labelStyle: const TextStyle(
            //             color: Colors.white,
            //             fontSize: 16,
            //             fontWeight: FontWeight.w700),
            //         child: SvgPicture.asset(
            //           'assets/svg/edit.svg',
            //           height: 16,
            //           width: 16,
            //         ),
            //         label: 'Punch In',
            //         onTap: () {
            //           // Get.toNamed('new_group_screen');
            //         }),
            //     SpeedDialChild(
            //         onTap: () {
            //           // Get.toNamed('/new_chat_screen');
            //         },
            //         shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(7)),
            //         backgroundColor: Colors.white,
            //         child: SvgPicture.asset(
            //           'assets/svg/received.svg',
            //           height: 16,
            //           width: 16,
            //         ),
            //         labelBackgroundColor: Colors.transparent,
            //         labelShadow: [],
            //         labelStyle: const TextStyle(
            //             color: Colors.white,
            //             fontSize: 16,
            //             fontWeight: FontWeight.w700),
            //         label: 'Edit Punch'),
            //   ],
            // ),
          );
        });
  }

  Widget _buildChartPage(
      String title,
      List<double> data,
      String time,
      String period,
      String imageName,
      Color avatarColor,
      Color lineColor,
      List<String> xAxis) {
    // final List<String> daysOfWeek = ['SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT'];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // Equivalent to #FFF
        borderRadius: BorderRadius.circular(8.0), // 8px rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05), // Slight gray shadow
            offset: const Offset(0, 4), // Shadow slightly below the container
            blurRadius: 18.0, // Blur the shadow for a softer effect
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: primaryTextColor),
                ),
                CircleAvatar(
                  radius: 20,
                  backgroundColor: avatarColor,
                  child: SvgPicture.asset(
                    imageName,
                    height: 24,
                    width: 24,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2),
            Text(
              time,
              style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: primaryTextColor),
            ),
            Text(
              period,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: secondaryTextColor),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 150,
              child: SfCartesianChart(
                plotAreaBorderWidth: 0,
                borderWidth: 0,
                primaryXAxis: const CategoryAxis(
                  majorGridLines: MajorGridLines(width: 0), // Disable gridlines
                  axisLine: AxisLine(width: 0), // Hide the x-axis line
                  majorTickLines:
                      MajorTickLines(size: 0), // Hide the tick marks
                ),
                primaryYAxis: const NumericAxis(
                  majorGridLines: MajorGridLines(width: 0), // Disable gridlines
                  axisLine: AxisLine(width: 0), // Hide the y-axis line
                  isVisible: false, // Hide y-axis labels
                ),
                series: <CartesianSeries>[
                  SplineSeries<ChartData, String>(
                    color: lineColor, // Set the line color to avatarColor
                    width: 2, // Line thickness
                    dataSource: List.generate(
                      data.length,
                      (index) =>
                          ChartData(xAxis[index % xAxis.length], data[index]),
                    ),
                    xValueMapper: (ChartData sales, _) => sales.x,
                    yValueMapper: (ChartData sales, _) => sales.y,
                    markerSettings: const MarkerSettings(
                        isVisible: false), // Hide data markers
                    dataLabelSettings: const DataLabelSettings(
                      isVisible: false, // Hide data labels
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

  Widget _buildTextPage(String title, List<String> items, List<String> subtexts,
      String eventImageName, Color avatarColor, List<String?> networkImage) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor, // Equivalent to #FFF
        borderRadius: BorderRadius.circular(8.0), // 8px rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05), // Slight gray shadow
            offset: const Offset(0, 4), // Shadow slightly below the container
            blurRadius: 18.0, // Blur the shadow for a softer effect
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Text(
                    title,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: primaryTextColor),
                  ),
                ),
                CircleAvatar(
                  radius: 16,
                  backgroundColor: avatarColor,
                  child: SvgPicture.asset(
                    eventImageName,
                    height: 24,
                    width: 24,
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                // itemCount: controller.getEmployeBirthday.length,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(items[index]),
                    subtitle: Text(subtexts[index]),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(networkImage[index]!),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRemainingLeavesCard(DashboardController controller) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // Equivalent to #FFF
        borderRadius: BorderRadius.circular(8.0), // 8px rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05), // Slight gray shadow
            offset: const Offset(0, 4), // Shadow slightly below the container
            blurRadius: 18.0, // Blur the shadow for a softer effect
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Remaining leaves',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: primaryTextColor),
            ),
            const SizedBox(height: 8),
            //         GridView.count(
            //           crossAxisCount: 3,
            //           shrinkWrap: true,
            //           physics: const NeverScrollableScrollPhysics(),
            //           children: <Widget>[
            //              _buildCircularPercentIndicator(controller.getEmployeRemainingLeaves[0].nameAbbr,  controller.getEmployeRemainingLeaves[0].totalLeaves == 0
            // ? 0.0  // Set the quotient to 0 if totalLeaves is 0
            // : controller.getEmployeRemainingLeaves[0].balanceLeaves / controller.getEmployeRemainingLeaves[0].totalLeaves, controller.getEmployeRemainingLeaves[0].totalLeaves),
            //             _buildCircularPercentIndicator(controller.getEmployeRemainingLeaves[1].nameAbbr,  controller.getEmployeRemainingLeaves[1].totalLeaves == 0
            // ? 0.0  // Set the quotient to 0 if totalLeaves is 0
            // : controller.getEmployeRemainingLeaves[1].balanceLeaves / controller.getEmployeRemainingLeaves[1].totalLeaves, controller.getEmployeRemainingLeaves[1].totalLeaves),
            //             _buildCircularPercentIndicator(controller.getEmployeRemainingLeaves[2].nameAbbr,  controller.getEmployeRemainingLeaves[2].totalLeaves == 0
            // ? 0.0  // Set the quotient to 0 if totalLeaves is 0
            // : controller.getEmployeRemainingLeaves[2].balanceLeaves / controller.getEmployeRemainingLeaves[2].totalLeaves, controller.getEmployeRemainingLeaves[2].totalLeaves),
            //             _buildCircularPercentIndicator(controller.getEmployeRemainingLeaves[3].nameAbbr,  controller.getEmployeRemainingLeaves[3].totalLeaves == 0
            // ? 0.0  // Set the quotient to 0 if totalLeaves is 0
            // : controller.getEmployeRemainingLeaves[3].balanceLeaves / controller.getEmployeRemainingLeaves[3].totalLeaves, controller.getEmployeRemainingLeaves[3].totalLeaves),
            //             _buildCircularPercentIndicator(controller.getEmployeRemainingLeaves[4].nameAbbr,  controller.getEmployeRemainingLeaves[4].totalLeaves == 0
            // ? 0.0  // Set the quotient to 0 if totalLeaves is 0
            // : controller.getEmployeRemainingLeaves[4].balanceLeaves / controller.getEmployeRemainingLeaves[4].totalLeaves, controller.getEmployeRemainingLeaves[4].totalLeaves),
            //             _buildCircularPercentIndicator(controller.getEmployeRemainingLeaves[5].nameAbbr,  controller.getEmployeRemainingLeaves[5].totalLeaves == 0
            // ? 0.0  // Set the quotient to 0 if totalLeaves is 0
            // : controller.getEmployeRemainingLeaves[5].balanceLeaves / controller.getEmployeRemainingLeaves[5].totalLeaves, controller.getEmployeRemainingLeaves[5].totalLeaves),
            //           ],
            //         ),

            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: List.generate(
                // Ensure not to exceed 6 elements
                min(controller.getEmployeRemainingLeaves.length, 6),
                (index) => _buildCircularPercentIndicator(
                  controller.getEmployeRemainingLeaves[index].nameAbbr,
                  controller.getEmployeRemainingLeaves[index].totalLeaves == 0
                      ? 0.0
                      : controller
                              .getEmployeRemainingLeaves[index].balanceLeaves /
                          controller
                              .getEmployeRemainingLeaves[index].totalLeaves,
                  controller.getEmployeRemainingLeaves[index].totalLeaves,
                ),
              ),
            ),

            if (!isExpanded)
              Column(
                children: [
                  Center(
                    child: IconButton(
                      icon: const Icon(Icons.expand_more),
                      onPressed: toggleExpanded,
                    ),
                  ),
                  // CorneredButton(
                  //   height: 40,
                  //   color: primaryColor,
                  //   title: 'Apply for Leave',
                  //   textcolor: backgroundColor,
                  //   onPress: () async {},
                  // )
                ],
              ),
            if (isExpanded)
              Column(
                children: [
//                  Column(
//   children: controller.getEmployeRemainingLeaves
//       .asMap()
//       .entries
//       .map((entry) {
//         final index = entry.key;
//         final leave = entry.value;

//         return _buildLinearPercentIndicator(
//           controller.processLeaveType(leave.leaveTypeName),
//           leave.totalLeaves == 0
//               ? 0.0
//               : leave.balanceLeaves / leave.totalLeaves,
//           leave.totalLeaves,
//         );
//       })
//       .toList(),
// ),

Column(
  children: controller.getEmployeRemainingLeaves
      .map((leave) {
        return _buildLinearPercentIndicator(
          controller.processLeaveType(leave.leaveTypeName),
          leave.totalLeaves == 0
              ? 0.0
              : leave.balanceLeaves / leave.totalLeaves,
          leave.totalLeaves,
        );
      })
      .toList(),
),


                  Column(
                    children: [

                      IconButton(
                    icon: const Icon(Icons.expand_less),
                    onPressed: toggleExpanded,
                  ),

                  CorneredButton(
                    height: 40,
                    color: backgroundColor,
                    textcolor: primaryColor,
                    buttonBorder: Border.all(
                      color: primaryColor,
                      width: 1,
                    ),
                    title: 'View All',
                    onPress: () async {},
                  )
                    ],
                  )

//                   Expanded(
//   child: PagedListView<int, GetRemainingLeavesModel>(
//     pagingController: controller.pagingController,
//     builderDelegate: PagedChildBuilderDelegate<GetRemainingLeavesModel>(
//       itemBuilder: (context, item, index) {
//         return _buildLinearPercentIndicator(
//           controller.processLeaveType(controller.getEmployeRemainingLeaves[index].leaveTypeName),
//           controller.getEmployeRemainingLeaves[index].totalLeaves == 0
//               ? 0.0
//               : controller.getEmployeRemainingLeaves[index].balanceLeaves /
//                   controller.getEmployeRemainingLeaves[index].totalLeaves,
//           controller.getEmployeRemainingLeaves[index].totalLeaves,
//         );
//       },
//       // Display when an error occurs during pagination
//       firstPageErrorIndicatorBuilder: (context) => Center(
//         child: Text('Error occurred, please try again.'),
//       ),
//       // Display when there are no items found
//       noItemsFoundIndicatorBuilder: (context) => Center(
//         child: Text('No leave records found.'),
//       ),
//       // Display progress indicator for loading the next page
//       newPageProgressIndicatorBuilder: (context) => Center(
//         child: CircularProgressIndicator(),
//       ),
//     ),
//   ),
// ),

                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCircularPercentIndicator(
      String leaveType, double percent, double totalLeaves) {
    return CircularPercentIndicator(
      radius: 40.0, // Reduced the radius size
      lineWidth: 10.0, // Reduced the line width
      percent: percent,
      center: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            '${(percent * totalLeaves).toDouble()}',
            style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: primaryTextColor), // Adjusted the font size
          ),
          Text(
            leaveType,
            style: const TextStyle(
                fontSize: 12.0,
                color: lightGreenTextColor), // Adjusted the font size
          ),
        ],
      ),
      progressColor: primaryColor,
      backgroundColor: lightGray,
      circularStrokeCap: CircularStrokeCap.round, // This makes the ends rounded
    );
  }

  Widget _buildLinearPercentIndicator(
      String leaveType, double percent, double totalLeaves) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Text(
              leaveType,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          Expanded(
            flex: 3,
            child: LinearPercentIndicator(
              barRadius:
                  const Radius.circular(20), // Adjust the radius as needed
              clipLinearGradient: true,
              lineHeight: 10.0,
              percent: percent,
              backgroundColor: lightGray,
              progressColor: primaryColor,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              '${(percent * totalLeaves).toDouble()}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double y;
}
