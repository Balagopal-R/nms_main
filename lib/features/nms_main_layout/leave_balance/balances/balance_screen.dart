import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:nms/features/nms_main_layout/leave_balance/balances/balances.dart';
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
            child:  Column(
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
                      
                              border: Border.fromBorderSide(
                                BorderSide(
                                  color: Color(0xFFF1F1F1), // Replace with your actual --Grey-Grey-200 color
                                  width: 0.75,
                                ),
                              ),
                              color: Color(0xFFFFFFFF), // Replace with your actual --White color
                            ),
                            child: GestureDetector(
                              onTap: () {
                              },
                              child: SvgPicture.asset('assets/svg/chevron_left.svg'),
                            ),
                          ),
                          Text('01 Apr 2023 to 31 Mar 2024',style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500,color: Color(0xff7A7A7A)),),
                         Container(
                            width: 25,
                            height: 25,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                      
                              border: Border.fromBorderSide(
                                BorderSide(
                                  color: Color(0xFFF1F1F1), // Replace with your actual --Grey-Grey-200 color
                                  width: 0.75,
                                ),
                              ),
                              color: Color(0xFFFFFFFF), // Replace with your actual --White color
                            ),
                            child: GestureDetector(
                              onTap: () {
                              },
                              child: SvgPicture.asset('assets/svg/chevron_right.svg'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Leave Type',style: TextStyle(fontSize: 10,fontWeight: FontWeight.w500,color: Color(0xff7A7A7A)),),
                        Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: Text('Taken',style: TextStyle(fontSize: 10,fontWeight: FontWeight.w500,color: Color(0xff7A7A7A)),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: Text('Remaining',style: TextStyle(fontSize: 10,fontWeight: FontWeight.w500,color: Color(0xff7A7A7A)),),
                        ),
                      ],
                    ),
                    Expanded(
                      child: PagedListView<int, GetRemainingLeavesModel>(
            pagingController: controller.pagingController,
            builderDelegate: PagedChildBuilderDelegate<GetRemainingLeavesModel>(
              itemBuilder: (context, item, index) =>  _leaveContainer(controller.processLeaveType(controller.getEmployeRemainingLeaves[index].leaveTypeName),
                                                                     [4, 6, 5],  
                                                                     controller.getEmployeRemainingLeaves[index].totalLeaves == 0
    ? 0.0 : controller.getEmployeRemainingLeaves[index].balanceLeaves / controller.getEmployeRemainingLeaves[index].totalLeaves,
                                                                     controller.getEmployeRemainingLeaves[index].totalLeaves),

                                                                     
              
              firstPageErrorIndicatorBuilder: (context) => Center(
                child: Text('Error occurred, please try again.'),
              ),
              noItemsFoundIndicatorBuilder: (context) => Center(
                child: Text('No team listing found.'),
              ),
              newPageProgressIndicatorBuilder: (context) => Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
                      
                    ),
                  ],
                ),
          ),
        );
      }
    );
  }

  
Widget _leaveContainer(String leaveType, List<int> barValues, double percent, double totalLeaves) {
  return Container(
    height: 100,
    width: double.infinity,
    margin: EdgeInsets.symmetric(vertical: 6.0, horizontal: 6.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            leaveType,
            style: TextStyle(
              color: Color(0xFF212121),
              fontFamily: 'Satoshi',
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Container(
          color: Colors.white, // Background for better contrast
          height: 75, // 75% of the Container height
          width: 100, // Adjust this width according to your UI needs
          child: SfCartesianChart(
            primaryXAxis: CategoryAxis(
              majorGridLines: MajorGridLines(width: 0), // Hide grid lines
              axisLine: AxisLine(width: 0), // Hide the x-axis line
              majorTickLines: MajorTickLines(size: 0), // Hide the tick lines above labels
              labelStyle: TextStyle(
                fontSize: 8, // Make the x-axis text smaller
              ),
              labelPlacement: LabelPlacement.onTicks, // Ensure labels are on ticks
              interval: 1, // Ensure all labels (Jun, Jul, Aug) are visible
              plotOffset: 10, // Adds padding to prevent bars from being cut off
            ),
            primaryYAxis: NumericAxis(
              isVisible: false, // Hide y-axis
              majorGridLines: MajorGridLines(width: 0), // Hide grid lines
            ),
            plotAreaBorderWidth: 0, // Remove border around the graph
            series: <CartesianSeries>[
              ColumnSeries<ChartData, String>(
                dataSource: [
                  ChartData('Jun', barValues[0]),
                  ChartData('Jul', barValues[1]),
                  ChartData('Aug', barValues[2]),
                ],
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y,
                color: Color(0xFF3BBCA0), // Set the bar color
                borderRadius: BorderRadius.zero, // Sharp rectangular borders
                width: 0.5, // Bar width adjusted to ensure equal width and full visibility
                spacing: 0.2, // Adjust the spacing between bars
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: _buildCircularPercentIndicator(percent, totalLeaves)
        ),
      ],
    ),
  );
}

 Widget _buildCircularPercentIndicator( double percent, double totalLeaves) {
    return CircularPercentIndicator(
      radius: 35.0, // Reduced the radius size
      lineWidth: 8.0, // Reduced the line width
      percent: percent,
      center: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            '${(percent * totalLeaves).toInt()}',
            style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.black), // Adjusted the font size
          ),
          // Text(
          //   leaveType,
          //   style: TextStyle(
          //       fontSize: 12.0,
          //       color: Color(0xff3BBCA0)), // Adjusted the font size
          // ),
        ],
      ),
      progressColor: Color(0xff35A990),
      backgroundColor: Color(0xffE3E3E3),
      circularStrokeCap: CircularStrokeCap.round, // This makes the ends rounded
    );
  }

}

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final int y;
}
