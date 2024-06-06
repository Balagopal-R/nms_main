import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nms/utils/theme/theme_constants.dart';
import 'package:nms/widgets/cornered_button.dart';
import 'dashboard_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:percent_indicator/percent_indicator.dart';

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
            backgroundColor: const Color(0xffFAFAFA),
            appBar: AppBar(
              backgroundColor: const Color(0xffFAFAFA),
              title: InkWell(
                onTap: () {
                  // Get.to(const LeaveBalanceScreen());
                },
                child: const Padding(
                  padding: EdgeInsets.only(left: 1.0),
                  child: Text(
                    'Hello Ryan',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.w700),
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
            body: SingleChildScrollView(
              child: Column(
                children: [
                  // First Container
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: backgroundColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(
                                0.05), // Slight grey shadow with 5% opacity
                            offset: Offset(0, 4), // Shadow offset 4px down
                            blurRadius: 18.0, // Blur radius of the shadow
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "You're Punched ${controller.punchStatus}",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black),
                              ),
                              Row(
  children: [
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2.667),
        color: Color(0xffFFF0F0),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 4,
            backgroundColor: Colors.red,
          ),
          SizedBox(width: 4),
          Text(
            'Late',
            style: TextStyle(color: Colors.red),
          ),
        ],
      ),
    ),
  ],
)

                            ],
                          ),
                          const SizedBox(height: 8),
                    
                          LinearPercentIndicator(
                            lineHeight: 8.0,
                            percent: 0.7, // Example value
                            backgroundColor: Colors.grey[300]!,
                            linearGradient: LinearGradient(
                              colors: [
                                Color(0xff3DC5A2),
                                Color(0xff3DC5A2),
                                Color(0xffF0C27D),
                                Color(0xffF0C27D),
                                Color(0xff3DC5A2)
                              ],
                              stops: [
                                0.0,
                                0.30,
                                0.3,
                                0.6,
                                0.60
                              ], // Adjust the stops for the amber section
                            ),
                            barRadius: Radius.circular(20),
                            // clipLinearGradient: true,
                          ),
                    
                          // LinearPercentIndicator(
                          //   lineHeight: 8.0,
                          //   percent: 0.7, // Example value
                          //   backgroundColor: Colors.grey[300]!,
                          //   linearGradient: LinearGradient(
                          //     colors: [Colors.green, Colors.amber],
                          //     stops: [0.5, 1.0], // Example values
                          //   ),
                          // ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              CircleAvatar(
                                  radius: 3, backgroundColor: Colors.green),
                              SizedBox(width: 4),
                              Text('5 hours 25 minutes'),
                              SizedBox(width: 16),
                              CircleAvatar(
                                  radius: 3, backgroundColor: Colors.amber),
                              SizedBox(width: 4),
                              Text('23 minutes'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Second Container
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      padding: EdgeInsets.all(0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: backgroundColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(
                                0.05), // Slight grey shadow with 5% opacity
                            offset: Offset(0, 4), // Shadow offset 4px down
                            blurRadius: 18.0, // Blur radius of the shadow
                          ),
                        ],
                      ),
                      child: CarouselSlider(
                        options: CarouselOptions(
                            height: 300.0, enlargeCenterPage: false),
                        items: [
                          _buildChartPage(
                              'Avg Break Time',
                              [1.2, 1.1, 1.3, 1.0, 1.4, 1.5, 2],
                              '1.2 hours',
                              'Last 7 days',
                              'assets/svg/ph_coffee_bold.svg',
                              Color(0xffFFEECC)),
                          _buildChartPage(
                              'Avg Punch Time',
                              [7.8, 7.6, 7.7, 7.9, 8.0, 7.8, 7.7],
                              '7.8 hours',
                              ' Last 7 days',
                              'assets/svg/clock.svg',
                              Color(0xffBEFFE8)),
                          _buildChartPage('Attendance',
                              [17, 18, 16, 19, 20, 21, 17],
                               '17',
                                'This Month',
                              'assets/svg/attendance.svg',
                              Color(0xffDFDFFB)),
                    
                    
                          _buildTextPage(
                              'Birthdays',
                              controller.birthdayName,
                              controller.daysToBirthday,
                              'assets/svg/cake.svg',
                              Color(0xffFFEECC)
                              // ['Esther Howard', 'Guy Hawkins', 'Devon Lane'],
                              // ['Today', 'In 2 Days', 'In 10 Days'],
                              ),
                    
                              
                          _buildTextPage(
                              'Leaves',
                              ['Sick Leave', 'Casual Leave', 'Privilege Leave'],
                              ['Tomorrow', 'May 19, 2024', 'May 17, 2024'],
                              'assets/svg/upcoming_leaves.svg',
                              Color(0xffBEFFE8)),

                          _buildTextPage(
                              'Leave History',
                              ['Sick Leave', 'Casual Leave', 'Privilege Leave'],
                              ['Yesterday', 'Feb 19, 2024', 'Feb 17, 2024'],
                              'assets/svg/teamListing.svg',
                              Color(0xffDFDFFB)),
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

                  // Third Container
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: backgroundColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(
                                0.05), // Slight grey shadow with 5% opacity
                            offset: Offset(0, 4), // Shadow offset 4px down
                            blurRadius: 18.0, // Blur radius of the shadow
                          ),
                        ],
                      ),
                      child: buildRemainingLeavesCard(),
                    ),
                  ),
                ],
              ),
            ),
            floatingActionButton: SpeedDial(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7)),
              buttonSize: const Size(48, 48),
              //animatedIcon: AnimatedIcons.add_event,
              icon: Icons.arrow_upward_rounded,
              childPadding: const EdgeInsets.only(right: 5, left: 5),
              activeIcon: Icons.close,
              childrenButtonSize: const Size(48, 38),
              overlayColor: Colors.black,
              overlayOpacity: 0.8,
              spacing: 5,
              spaceBetweenChildren: 8,
              iconTheme: const IconThemeData(
                color: Colors.white,
                size: 24,
              ),
              backgroundColor: primaryColor,
              children: [
                SpeedDialChild(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7)),
                    backgroundColor: Colors.white,
                    labelBackgroundColor: Colors.transparent,
                    labelShadow: [],
                    labelStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                    child: SvgPicture.asset(
                      'assets/svg/edit.svg',
                      height: 16,
                      width: 16,
                    ),
                    label: 'Punch In',
                    onTap: () {
                      // Get.toNamed('new_group_screen');
                    }),
                SpeedDialChild(
                    onTap: () {
                      // Get.toNamed('/new_chat_screen');
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7)),
                    backgroundColor: Colors.white,
                    child: SvgPicture.asset(
                      'assets/svg/received.svg',
                      height: 16,
                      width: 16,
                    ),
                    labelBackgroundColor: Colors.transparent,
                    labelShadow: [],
                    labelStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                    label: 'Edit Punch'),
              ],
            ),
          );
        });
  }

  List<ChartData> getChartData() {
    return [
      ChartData('TUE', 0.8),
      ChartData('WED', 0.9),
      ChartData('THU', 1.0),
      ChartData('FRI', 1.1),
      ChartData('SAT', 1.2),
      ChartData('SUN', 1.3),
      ChartData('MON', 1.4),
    ];
  }

  Widget _buildChartPage(
      String title, List<double> data, String time, String period, String imageName, Color avatarColor) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // Equivalent to #FFF
        borderRadius: BorderRadius.circular(8.0), // 8px rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05), // Slight gray shadow
            offset: Offset(0, 4), // Shadow slightly below the container
            blurRadius: 18.0, // Blur the shadow for a softer effect
          ),
        ],
      ),

      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.black),
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
            SizedBox(height: 4),
            Text(time,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: Colors.black)),
            Text(period),
            SizedBox(height: 16),
            SizedBox(
              height: 150,
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                series: <CartesianSeries>[
                  LineSeries<ChartData, String>(
                    dataSource: List.generate(
                      data.length,
                      (index) => ChartData('${index + 1}', data[index]),
                    ),
                    xValueMapper: (ChartData sales, _) => sales.x,
                    yValueMapper: (ChartData sales, _) => sales.y,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildTextPage(String title, List<String> items, List<String> subtexts,
  //     DashboardController controller) 
   Widget _buildTextPage(String title, List<String> items, List<String> subtexts, String imageName, Color avatarColor)
      {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // Equivalent to #FFF
        borderRadius: BorderRadius.circular(8.0), // 8px rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05), // Slight gray shadow
            offset: Offset(0, 4), // Shadow slightly below the container
            blurRadius: 18.0, // Blur the shadow for a softer effect
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.black),
                ),
               CircleAvatar(
                  radius: 16,
                  backgroundColor:avatarColor,
                  child: SvgPicture.asset(
              imageName,
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
                      child: Text(items[index][0]),
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

  Widget buildRemainingLeavesCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // Equivalent to #FFF
        borderRadius: BorderRadius.circular(8.0), // 8px rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05), // Slight gray shadow
            offset: Offset(0, 4), // Shadow slightly below the container
            blurRadius: 18.0, // Blur the shadow for a softer effect
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Remaining leaves',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
            SizedBox(height: 8),
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: <Widget>[
                _buildCircularPercentIndicator('CL', 0.6),
                _buildCircularPercentIndicator('SL', 0.6),
                _buildCircularPercentIndicator('ML', 0.6),
                _buildCircularPercentIndicator('VL', 0.6),
                _buildCircularPercentIndicator('SCL', 0.6),
                _buildCircularPercentIndicator('TL', 0.6),
              ],
            ),
            if (!isExpanded)
              Column(
                children: [
                  IconButton(
                    icon: Icon(Icons.expand_more),
                    onPressed: toggleExpanded,
                  ),
                  CorneredButton(
                    height: 30,
                    color: primaryColor,
                    title: 'Apply for Leave',
                    textcolor: backgroundColor,
                    onPress: () async {},
                  )
                ],
              ),
            if (isExpanded)
              Column(
                children: [
                  _buildLinearPercentIndicator('Casual Leave', 0.7),
                  _buildLinearPercentIndicator('Sick Leave', 0.6),
                  _buildLinearPercentIndicator('Privilege Leave', 0.5),
                  _buildLinearPercentIndicator('Maternity Leave', 0.4),
                  _buildLinearPercentIndicator('Vacation Leave', 0.3),
                  IconButton(
                    icon: Icon(Icons.expand_less),
                    onPressed: toggleExpanded,
                  ),
                  // ElevatedButton(
                  //   onPressed: () {},
                  //   child: Text('Apply for Leave'),
                  // ),
                  CorneredButton(
                    height: 30,
                    color: primaryColor,
                    title: 'Apply for Leave',
                    textcolor: backgroundColor,
                    onPress: () async {},
                  )
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCircularPercentIndicator(String leaveType, double percent) {
    return CircularPercentIndicator(
      radius: 40.0, // Reduced the radius size
      lineWidth: 10.0, // Reduced the line width
      percent: percent,
      center: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            '${(percent * 10).toInt()}',
            style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.black), // Adjusted the font size
          ),
          Text(
            leaveType,
            style: TextStyle(
                fontSize: 12.0,
                color: Color(0xff3BBCA0)), // Adjusted the font size
          ),
        ],
      ),
      progressColor: Color(0xff35A990),
      backgroundColor: Color(0xffE3E3E3),
      circularStrokeCap: CircularStrokeCap.round, // This makes the ends rounded
    );
  }

  Widget _buildLinearPercentIndicator(String leaveType, double percent) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Text(
              leaveType,
              style: TextStyle(fontSize: 16),
            ),
          ),
          Expanded(
            flex: 3,
            child: LinearPercentIndicator(
              barRadius: Radius.circular(20), // Adjust the radius as needed
              clipLinearGradient: true,
              lineHeight: 10.0,
              percent: percent,
              backgroundColor: Colors.grey[200],
              progressColor: Color(0xff35A990),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              '${(percent * 10).toInt()}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
