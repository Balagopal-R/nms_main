import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nms/features/timesheet/timesheet.dart';
import 'package:nms/utils/theme/theme_constants.dart';
import 'package:nms/widgets/appbar_main_widget.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class TimesheetScreen extends StatelessWidget {
  const TimesheetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TimesheetController>(
        init: TimesheetController(),
        builder: (controller) {
          return Scaffold(
            appBar: appbarMain(context, "Timesheet"),
            body: Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 25,
                          height: 25,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            border: const Border.fromBorderSide(
                              BorderSide(
                                color:
                                    veryLightGray, // Replace with your actual --Grey-Grey-200 color
                                width: 0.75,
                              ),
                            ),
                            color:
                                backgroundColor, // Replace with your actual --White color
                          ),
                          child: GestureDetector(
                            onTap: () {},
                            child:
                                SvgPicture.asset('assets/svg/chevron_left.svg'),
                          ),
                        ),
                        const Text(
                          '01 Apr 2023 to 31 Mar 2024',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: secondaryTextColor),
                        ),
                        Container(
                          width: 25,
                          height: 25,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),

                            border: const Border.fromBorderSide(
                              BorderSide(
                                color:
                                    veryLightGray, // Replace with your actual --Grey-Grey-200 color
                                width: 0.75,
                              ),
                            ),
                            color:
                                backgroundColor, // Replace with your actual --White color
                          ),
                          child: GestureDetector(
                            onTap: () {},
                            child: SvgPicture.asset(
                                'assets/svg/chevron_right.svg'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8, 4, 3, 4),
                          child: Container(
                            height: 100,
                            padding: const EdgeInsets.all(
                                10), // Add padding to the container
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: scaffoldBackgroundColor,
                              // color: Colors.blue
                            ),
                            child: const Align(
                              alignment: Alignment.centerLeft,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Total Working Hours',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: secondaryTextColor),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    '40:34',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                        color: primaryTextColor),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(3, 4, 8, 4),
                          child: Container(
                            height: 100,
                            padding: const EdgeInsets.all(
                                10), // Add padding to the container
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: scaffoldBackgroundColor,
                              // color: Colors.red
                            ),
                            child: const Align(
                              alignment: Alignment.centerLeft,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Avg Working Hours',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: secondaryTextColor),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    '08:04',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                        color: primaryTextColor),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(4),
                        bottomRight: Radius.circular(4),
                      ),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Row for Days of the Week
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: List.generate(controller.daysOfWeek.length,
                              (index) {
                            bool isToday =
                                controller.date[index] == controller.todayDate;

                            return GestureDetector(
                              onTap: () {
                                controller.updateUserSelectDay(index);
                              },
                              child: Column(
                                children: [
                                  // Display CircleAvatar only for the selected day; otherwise, show a placeholder
                                  controller.selectedDayIndex == index
                                      ? CircleAvatar(
                                          radius: 18,
                                          backgroundColor: veryLightGreenColor,
                                          child: Text(
                                            controller.daysOfWeek[index],
                                            style: const TextStyle(
                                              color: primaryGray,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        )
                                      : SizedBox(
                                          height:
                                              36, // Same height as CircleAvatar to keep alignment
                                          child: Center(
                                            child: Text(
                                              controller.daysOfWeek[index],
                                              style: const TextStyle(
                                                color: primaryGray,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                        ),

                                  const SizedBox(height: 8),

                                  _buildCircularPercentIndicator(
                                    controller.dateProgress[index],
                                    controller.date[index],
                                    isToday, // Set isToday based on today's date
                                  ),
                                ],
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),

        Container(
  width: double.infinity, // Ensure the container takes up the full width
  decoration: const BoxDecoration(
    color: backgroundColor,
    borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(4),
      bottomRight: Radius.circular(4),
    ),
  ),
  padding: const EdgeInsets.all(8),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start, // Align children to the left
    children: [
      const Text(
        'Overview',
        style: TextStyle(
          color: primaryTextColor,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
      const SizedBox(height: 8), // Add space between text and indicator
      Row(
        mainAxisAlignment: MainAxisAlignment.start, // Align the row to the left
        children: [
          _buildCircularPercentIndicatorLarge(0.65, '8h 23m'),
          const SizedBox(width: 10), // Add space between the indicator and the text
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: const EdgeInsets.only(bottom: 25), // Add bottom margin
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Wednesday, April 13',
                    style: TextStyle(
                      color: secondaryTextColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 4), // Space between date and punch-in row
                  Row(
                    children: [
                      Image(
                        image: AssetImage('assets/png/punch_in.png'),
                        height: 20.0,
                        width: 20.0,
                      ),
                      SizedBox(width: 4.0),
                      Text(
                        '09:00',
                        style: TextStyle(
                          color: darkGray,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 8.0),
                      Image(
                        image: AssetImage('assets/png/punch_out.png'),
                        height: 20.0,
                        width: 20.0,
                      ),
                      SizedBox(width: 4.0),
                      Text(
                        '17:23',
                        style: TextStyle(
                          color: darkGray,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                   SizedBox(height: 6),
                  Row(
                    children: [
                      Image(
                        image: AssetImage('assets/png/location.png'),
                        height: 20.0,
                        width: 20.0,
                      ),
                      SizedBox(width: 4.0),
                      Text(
                        'WFO',
                        style: TextStyle(
                          color: darkGray,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      const SizedBox(height: 16),

      const Text(
        'Task List',
        style: TextStyle(
          color: primaryTextColor,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    ],
  ),
),
Expanded(
  child: ListView.builder(
        itemCount: controller.tasks.length,
        itemBuilder: (context, index) {
          final task = controller.tasks[index];
          return TaskWidget(
            startTime: task['startTime'] ?? '',
            title: task['title'] ?? '',
            description: task['description'] ?? '',
            endTime: task['endTime'] ?? '',
          );
        },
      ),
)





                ],
              ),
            ),
          );
        });
  }

//   Widget _buildCircularPercentIndicator(double progress, String date, bool isToday) {
//   return Stack(
//     alignment: Alignment.center,
//     children: [
//       CircularPercentIndicator(
//         radius: 18.0, // Matching CircleAvatar's radius
//         lineWidth: 4.0, // Adjusted line width for smaller size
//         percent: progress,
//         center: Text(
//           date.toString(),
//           style: const TextStyle(
//             fontSize: 10.0, // Adjusted font size for smaller circle
//             fontWeight: FontWeight.w400,
//             color: secondaryTextColor,
//           ),
//         ),
//         progressColor: primaryLightColor,
//         backgroundColor: lightestGray,
//         circularStrokeCap: CircularStrokeCap.round,
//       ),
//       if (isToday)
//         Positioned(
//           bottom: -6, // Adjusted to fit the smaller circle
//           child: Container(
//             width: 36, // Reduced width to fit smaller circle
//             height: 6,  // Reduced height to fit smaller circle
//             decoration: BoxDecoration(
//               color: veryLightGreenColor,
//               borderRadius: BorderRadius.circular(3),
//             ),
//           ),
//         ),
//     ],
//   );
// }

  Widget _buildCircularPercentIndicatorLarge(double progress, String date) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CircularPercentIndicator(
          radius: 55.0, // Matching CircleAvatar's radius
          lineWidth: 10.0, // Adjusted line width for smaller size
          percent: progress,
          center: Text(
            date.toString(),
            style: const TextStyle(
              fontSize: 16.0, // Adjusted font size for smaller circle
              fontWeight: FontWeight.w700,
              color: secondaryTextColor,
            ),
          ),
          progressColor: primaryLightColor,
          backgroundColor: lightestGray,
          circularStrokeCap: CircularStrokeCap.round,
        ),
      ],
    );
  }

  Widget _buildCircularPercentIndicator(
      double progress, String date, bool isToday) {
    return Container(
      padding: const EdgeInsets.only(
          bottom: 16), // Extra padding for marker visibility
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularPercentIndicator(
            radius: 18.0, // Matching CircleAvatar's radius
            lineWidth: 4.0, // Adjusted line width for smaller size
            percent: progress,
            center: Text(
              date.toString(),
              style: const TextStyle(
                fontSize: 10.0, // Adjusted font size for smaller circle
                fontWeight: FontWeight.w400,
                color: secondaryTextColor,
              ),
            ),
            progressColor: primaryLightColor,
            backgroundColor: lightestGray,
            circularStrokeCap: CircularStrokeCap.round,
          ),
          if (isToday)
            Positioned(
              bottom: -16, // Further offset adjustment
              child: Container(
                width: 50, // Increased width for visibility
                height: 10, // Increased height for visibility
                decoration: BoxDecoration(
                  color: Colors.red
                      .withOpacity(0.5), // Visible color for debugging
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
        ],
      ),
    );
  }
}


class TaskWidget extends StatelessWidget {
  final String startTime;
  final String title;
  final String description;
  final String endTime;

  const TaskWidget({
    Key? key,
    required this.startTime,
    required this.title,
    required this.description,
    required this.endTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Start Time

          const SizedBox(width: 10),

          Text(
            startTime,
            style: const TextStyle(
              color: primaryTextColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(width: 20),
          
          // Task Details (Title and Description)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: primaryTextColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: const TextStyle(
                    color: secondaryTextColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          
          // End Time
          Text(
            endTime,
            style: const TextStyle(
              color: primaryTextColor,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(width: 12),
        ],
      ),
    );
  }
}
