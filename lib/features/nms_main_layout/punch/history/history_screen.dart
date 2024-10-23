import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nms/features/nms_main_layout/punch/history/history.dart';
import 'package:timeline_tile/timeline_tile.dart';
import '../../../../utils/theme/theme_constants.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HistoryController>(
      init: HistoryController(),
      builder: (controller) {
        return Scaffold(
          body: Center(
            child: Column(
              children: [
                // Header with dates and navigation buttons
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Back button
                      Container(
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          border: const Border.fromBorderSide(
                            BorderSide(
                              color: veryLightGray, // Use your color
                              width: 0.75,
                            ),
                          ),
                          color: backgroundColor, // Use your color
                        ),
                        child: GestureDetector(
                          onTap: () {},
                          child: SvgPicture.asset(
                            'assets/svg/chevron_left.svg',
                          ),
                        ),
                      ),

                      // Date Range Text
                      const Text(
                        '01 Apr 2023 to 31 Mar 2024',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: secondaryTextColor,
                        ),
                      ),

                      // Forward button
                      Container(
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          border: const Border.fromBorderSide(
                            BorderSide(
                              color: veryLightGray, // Use your color
                              width: 0.75,
                            ),
                          ),
                          color: backgroundColor, // Use your color
                        ),
                        child: GestureDetector(
                          onTap: () {},
                          child: SvgPicture.asset(
                            'assets/svg/chevron_right.svg',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Timeline Section (fills remaining space)
                Expanded(
                  child: ListView.builder(
                    itemCount: 7,  // Fixed to 7 tiles
                    itemBuilder: (context, index) {
                      return Flexible(
                        child: DayProgress(
                          day: controller.weekData[index]['day'],
                          date: controller.weekData[index]['date'],
                          inTime: controller.weekData[index]['inTime'],
                          outTime: controller.weekData[index]['outTime'],
                          isLate: controller.weekData[index]['isLate'],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class DayProgress extends StatelessWidget {
  final String day;
  final String date;
  final String inTime;
  final String outTime;
  final bool isLate;

  const DayProgress({
    super.key,
    required this.day,
    required this.date,
    required this.inTime,
    required this.outTime,
    this.isLate = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 11, // Reduce the height by dividing by 12
      child: TimelineTile(
        alignment: TimelineAlign.start,
        isFirst: day == 'Sat', // Adjust the first and last tiles accordingly
        isLast: day == 'Fri',
        indicatorStyle: IndicatorStyle(
          width: 10,
          color: isLate ? darkRed : lightGreenTextColor,
          indicatorXY: 0.3, // This ensures proper alignment with text
        ),
        beforeLineStyle: const LineStyle(
          color: lightGreenTextColor,
          thickness: 2.5,
        ),
        afterLineStyle: const LineStyle(
          color: lightGreenTextColor,
          thickness: 2.5,
        ),
        endChild: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const SizedBox(width: 20),
              // Day and Date Column (placed to the left)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                
                  Text(
                    day,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: secondaryTextColor,
                    ),
                  ),
                  const SizedBox(height: 2), // Add some spacing between day and date
                  Text(
                    date,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: secondaryTextColor,
                    ),
                  ),
                ],
              ),

              // Add more space between day/date and IN/OUT times
              const SizedBox(width: 50), // Increased spacing here

              // IN and OUT Times Columns aligned vertically and moved to the left
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'IN',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: secondaryTextColor,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            inTime,
                            style: TextStyle(
                              color: isLate ? darkRed : primaryTextColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      // Add more space between IN and OUT
                      const SizedBox(width: 60), // Increased spacing here

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'OUT',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: secondaryTextColor,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            outTime,
                            style: const TextStyle(
                              color: primaryTextColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
