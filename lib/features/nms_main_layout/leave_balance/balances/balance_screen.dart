import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:nms/features/nms_main_layout/leave_balance/balances/balances.dart';
import 'package:nms/utils/theme/theme.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../models/get_remaining_leaves/get_remaining_leaves_model.dart';

class BalancesScreen extends StatelessWidget {
  const BalancesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BalancesController>(
        init: BalancesController(),
        builder: (controller) {
          return Scaffold(
            body: Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // IconButton(
                        //   icon: Icon(Icons.chevron_left),
                        //   onPressed: () {},
                        // ),

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
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Leave Type',
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: secondaryTextColor),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 16),
                        child: Text(
                          'Taken',
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: secondaryTextColor),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 16),
                        child: Text(
                          'Remaining',
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: secondaryTextColor),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: PagedListView<int, GetRemainingLeavesModel>(
                      pagingController: controller.pagingController,
                      builderDelegate:
                          PagedChildBuilderDelegate<GetRemainingLeavesModel>(
                        itemBuilder: (context, item, index) => _leaveContainer(
                            controller.processLeaveType(controller
                                .getEmployeRemainingLeaves[index]
                                .leaveTypeName),
                            [4, 6, 5],
                            controller.getEmployeRemainingLeaves[index]
                                        .totalLeaves ==
                                    0
                                ? 0.0
                                : controller.getEmployeRemainingLeaves[index]
                                        .balanceLeaves /
                                    controller.getEmployeRemainingLeaves[index]
                                        .totalLeaves,
                            controller
                                .getEmployeRemainingLeaves[index].totalLeaves),
                        firstPageErrorIndicatorBuilder: (context) =>
                            const Center(
                          child: Text('Error occurred, please try again.'),
                        ),
                        noItemsFoundIndicatorBuilder: (context) => const Center(
                          child: Text('No team listing found.'),
                        ),
                        newPageProgressIndicatorBuilder: (context) =>
                            const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget _leaveContainer(String leaveType, List<int> barValues, double percent, double totalLeaves) {
  return Container(
    height: 100,
    width: double.infinity,
    margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 6.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Row(
      children: [
        // Leave type text on the left side with limited width
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 80, // Adjust this width according to your design
            child: Text(
              leaveType,
              maxLines: 2, // Allow wrapping or truncation
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: primaryTextColor,
                fontFamily: 'Satoshi',
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        
        // Spacer to manage layout distribution
        const Spacer(),

        // Bar chart in the center
        Center(
          child: SizedBox(
            width: 100, // Adjust width to fit centrally
            height: 75,
            child: SfCartesianChart(
              primaryXAxis: const CategoryAxis(
                majorGridLines: MajorGridLines(width: 0),
                axisLine: AxisLine(width: 0),
                majorTickLines: MajorTickLines(size: 0),
                labelStyle: TextStyle(fontSize: 8),
                labelPlacement: LabelPlacement.onTicks,
                interval: 1,
                plotOffset: 10,
              ),
              primaryYAxis: const NumericAxis(
                isVisible: false,
                majorGridLines: MajorGridLines(width: 0),
              ),
              plotAreaBorderWidth: 0,
              series: <CartesianSeries>[
                ColumnSeries<ChartData, String>(
                  dataSource: [
                    ChartData('Jun', barValues[0]),
                    ChartData('Jul', barValues[1]),
                    ChartData('Aug', barValues[2]),
                  ],
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y,
                  color: lightGreenTextColor,
                  borderRadius: BorderRadius.zero,
                  width: 0.5,
                  spacing: 0.2,
                ),
              ],
            ),
          ),
        ),

        // Spacer to manage layout distribution
        const Spacer(),

        // Percentage indicator on the right
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.centerRight, // Align it to the right
            child: _buildCircularPercentIndicator(percent, totalLeaves),
          ),
        ),
      ],
    ),
  );
}


  Widget _buildCircularPercentIndicator(double percent, double totalLeaves) {
    return CircularPercentIndicator(
      radius: 35.0, // Reduced the radius size
      lineWidth: 8.0, // Reduced the line width
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
        ],
      ),
      progressColor: primaryColor,
      backgroundColor: lightGray,
      circularStrokeCap: CircularStrokeCap.round, // This makes the ends rounded
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final int y;
}
