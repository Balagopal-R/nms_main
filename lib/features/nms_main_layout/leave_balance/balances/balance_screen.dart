import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BalancesScreen extends StatelessWidget {
  const BalancesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:  Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.chevron_left),
                      onPressed: () {},
                    ),
                    Text('01 Apr 2023 to 31 Mar 2024'),
                    IconButton(
                      icon: Icon(Icons.chevron_right),
                      onPressed: () {},
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Leave Type'),
                    Text('Taken'),
                    Text('Remaining'),
                  ],
                ),
                Expanded(
                  child: ListView(
                    children: [
                      _leaveContainer("CL", [4, 6, 5], 0.8,10),
                      _leaveContainer("SL", [2, 4, 6], 0.8,12),
                      _leaveContainer("PL", [3, 5, 7], 0.8,12),
                      _leaveContainer("ML", [0, 0, 0], 0.8,8),
                      _leaveContainer("VL", [1, 20, 0], 0.8,15),
                      _leaveContainer("SPL", [3, 4, 5], 0.8,10),
                    ],
                  ),
                ),
              ],
            ),
      ),
    );
  }

  
Widget _leaveContainer(String leaveType, List<int> barValues, double percent, double totalLeaves) {
  return Container(
    height: 100,
    width: double.infinity,
    margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
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
