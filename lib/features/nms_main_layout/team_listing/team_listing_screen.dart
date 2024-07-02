import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nms/features/nms_main_layout/team_listing/team_listing_controller.dart';
import 'package:nms/utils/theme/theme_constants.dart';
import 'package:nms/widgets/cornered_button.dart';

class TeamListingScreen extends StatefulWidget {
  @override
  _TeamListingScreenState createState() => _TeamListingScreenState();
}

class _TeamListingScreenState extends State<TeamListingScreen> {
  bool isSearching = false;

  final List<TeamMember> teamMembers = [
    TeamMember('Esther Howard', 'Technical', '09:00', 'On Time', 'WFO', 'assets/avatar1.png', Color(0xff2F9680)),
    TeamMember('Guy Hawkins', 'Design', '09:07', 'Late', 'WFH', 'assets/avatar2.png', Color(0xffFF4646)),
    TeamMember('Darlene Robertson', 'Finance', '09:00', 'Break', 'WFO', 'assets/avatar3.png', Colors.orange),
    TeamMember('Dianne Russell', 'Technical', '09:00', 'Absent', 'WFO', 'assets/avatar4.png', Colors.grey),
    TeamMember('Jerome Bell', 'Design', '09:00', 'Leave', 'WFO', 'assets/avatar5.png', Colors.purple),
    TeamMember('Jacob Jones', 'HR', '00:00', '08:56', 'WFO', 'assets/avatar6.png', Colors.blue),
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TeamListingController>(
      init: TeamListingController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Color(0xffFAFAFA),
          appBar: AppBar(
            backgroundColor: Color(0xffFAFAFA),
            leading: IconButton(
              icon: Image.asset('assets/png/arrow_left.png', height: 24, width: 24),
              onPressed: () {
                Get.back();
              },
            ),
            title: Text('Team Listing'),
            centerTitle: true,
            actions: [
              IconButton(
                icon: Image.asset(isSearching ? 'assets/png/cross.png' : 'assets/png/search.png'),
                onPressed: () {
                  setState(() {
                    isSearching = !isSearching;
                  });
                },
              ),
            ],
            bottom: isSearching
                ? PreferredSize(
                    preferredSize: Size.fromHeight(60.0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {},
                              child: Container(
                                height: 48.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4.0),
                                  border: Border.all(color: Color(0xFFB7B7B7)),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Row(
                                  children: [
                                    Icon(Icons.search, color: Colors.grey),
                                    SizedBox(width: 8.0),
                                    Text('Search Employee', style: TextStyle(color: Colors.grey)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 8.0),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: 48.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.0),
                                border: Border.all(color: Color(0xFFB7B7B7)),
                              ),
                              padding: EdgeInsets.all(8.0),
                              child: Image.asset('assets/png/slider.png'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : null,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return BottomSheetContent();
                },
              );
            },
            child: Icon(Icons.add),
            backgroundColor: Color(0xFF3BBCA0),
          ),
          body: ListView.builder(
            itemCount: teamMembers.length,
            itemBuilder: (context, index) {
              return TeamMemberCard(teamMember: teamMembers[index]);
            },
          ),
        );
      },
    );
  }
}

class TeamMember {
  final String name;
  final String role;
  final String checkInTime;
  final String status;
  final String workLocation;
  final String avatar;
  final Color statusColor;

  TeamMember(this.name, this.role, this.checkInTime, this.status, this.workLocation, this.avatar, this.statusColor);
}

class TeamMemberCard extends StatelessWidget {
  final TeamMember teamMember;

  TeamMemberCard({required this.teamMember});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        border: Border(bottom: BorderSide(color: Color(0xFFF1F1F1))),
        color: Colors.white,
      ),
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      padding: EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Column(
            children: [
              Row(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundImage: AssetImage(teamMember.avatar),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          radius: 6,
                          backgroundColor: teamMember.statusColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 8.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(teamMember.name, style: TextStyle(fontWeight: FontWeight.w700, color: Colors.black, fontSize: 14)),
                      Text(teamMember.role, style: TextStyle(color: Color(0xff7A7A7A), fontSize: 12, fontWeight: FontWeight.w400)),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image(
                        image: AssetImage('assets/png/punch_in.png'),
                        height: 20.0,
                        width: 20.0,
                      ),
                      SizedBox(width: 4.0),
                      Text(teamMember.checkInTime, style: TextStyle(color: Color(0xff888888), fontSize: 12, fontWeight: FontWeight.w500)),
                    ],
                  ),
                  Row(
                    children: [
                      Image(
                        image: AssetImage('assets/png/punch_out.png'),
                        height: 20.0,
                        width: 20.0,
                      ),
                      SizedBox(width: 4.0),
                      Text('--:--', style: TextStyle(color: Color(0xff888888), fontSize: 12, fontWeight: FontWeight.w500)),
                    ],
                  ),
                  Row(
                    children: [
                      Image(
                        image: AssetImage('assets/png/location.png'),
                        height: 20.0,
                        width: 20.0,
                      ),
                      SizedBox(width: 4.0),
                      Text(teamMember.workLocation, style: TextStyle(color: Color(0xff888888), fontSize: 12, fontWeight: FontWeight.w500)),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
              decoration: BoxDecoration(
                color: teamMember.statusColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(2.667),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 4.0,
                    backgroundColor: teamMember.statusColor,
                  ),
                  SizedBox(width: 4.0),
                  Text(teamMember.status, style: TextStyle(color: teamMember.statusColor)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BottomSheetContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      height: 150.0, // Increased height for the bottom sheet
      child: Column(
        children: [
          Container(
            height: 6.0,
            width: 70.0, // Increased length for the gray line
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(3.0), // Rounded edges
            ),
            margin: EdgeInsets.only(bottom: 16.0),
          ),
          Row(
            children: [
              Icon(Icons.arrow_back, color: Colors.teal),
              SizedBox(width: 16.0),
              Text('Punch In', style: TextStyle(color: Colors.black)), // Black text
            ],
          ),
          SizedBox(height: 16.0),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) {
                  return NewBottomSheetContent();
                },
              );
            },
            child: Row(
              children: [
                Icon(Icons.arrow_back, color: Colors.teal),
                SizedBox(width: 16.0),
                Text('Punch Request', style: TextStyle(color: Colors.black)), // Black text
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class NewBottomSheetContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth,
      height: screenHeight*.80,
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
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
            // Row 1: Grey line
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Color(0xFF7A7A7A),
                  borderRadius: BorderRadius.circular(2.0),
                ),
              ),
            ),
            SizedBox(height: 8.0),
    
            // Row 2: Punch Request
            Center(
              child: Text(
                'Punch Request',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: 8.0),
    
            // Row 3: Date
            Text(
              'Date*',
              style: TextStyle(
                color: Color(0xFF7A7A7A),
                fontFamily: 'Satoshi',
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 8.0),
    
            // Row 4: Date Picker
            Container(
              height: 50.0, // Increased height for Date Picker
              child: GestureDetector(
                onTap: () {
                  // Date Picker Logic
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    border: Border.all(color: Color(0xFFB7B7B7)),
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '25/09/2023',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      Icon(Icons.calendar_today, color: Colors.grey),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 8.0),
    
            // Row 5: Location
            Text(
              'Location*',
              style: TextStyle(
                color: Color(0xFF7A7A7A),
                fontFamily: 'Satoshi',
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 8.0),
    
            // Row 6: Location Dropdown
            Container(
              height: 50.0, // Increased height for Location Dropdown
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  border: Border.all(color: Color(0xFFB7B7B7)),
                  color: Colors.white,
                ),
                child: DropdownButton<String>(
                  isExpanded: true,
                  hint: Text('Select'),
                  underline: SizedBox(),
                  icon: Icon(Icons.arrow_drop_down, color: Colors.grey),
                  items: <String>['Location 1', 'Location 2', 'Location 3'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (_) {},
                ),
              ),
            ),
            SizedBox(height: 8.0),
  
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Punch In Time*',
                            style: TextStyle(
                              color: Color(0xFF7A7A7A),
                              fontFamily: 'Satoshi',
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          GestureDetector(
                            onTap: () {
                              // Time Picker Logic
                            },
                            child: Container(
                              height: 50,
                              width: screenWidth*0.41,
                              padding: EdgeInsets.symmetric(horizontal: 12.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.0),
                                border: Border.all(color: Color(0xFFB7B7B7)),
                                color: Colors.white,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '09:00',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  Icon(Icons.access_time, color: Colors.grey),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 16.0),
                          Text(
                            'Break*',
                            style: TextStyle(
                              color: Color(0xFF7A7A7A),
                              fontFamily: 'Satoshi',
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          GestureDetector(
                            onTap: () {
                              // Time Picker Logic
                            },
                            child: Container(
                              height: 50,
                              width: screenWidth*0.41,
                              padding: EdgeInsets.symmetric(horizontal: 12.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.0),
                                border: Border.all(color: Color(0xFFB7B7B7)),
                                color: Colors.white,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '13:00',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  Icon(Icons.access_time, color: Colors.grey),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
               
                  SizedBox(width: 16.0),
                  
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Punch Out Time*',
                            style: TextStyle(
                              color: Color(0xFF7A7A7A),
                              fontFamily: 'Satoshi',
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          GestureDetector(
                            onTap: () {
                              // Time Picker Logic
                            },
                            child: Container(
                              height: 50,
                              width: screenWidth*0.41,
                              padding: EdgeInsets.symmetric(horizontal: 12.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.0),
                                border: Border.all(color: Color(0xFFB7B7B7)),
                                color: Colors.white,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '18:00',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  Icon(Icons.access_time, color: Colors.grey),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 16.0),
                          Text(
                            'Resume*',
                            style: TextStyle(
                              color: Color(0xFF7A7A7A),
                              fontFamily: 'Satoshi',
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          GestureDetector(
                            onTap: () {
                              // Time Picker Logic
                            },
                            child: Container(
                              height: 50,
                              width: screenWidth*0.41,
                              padding: EdgeInsets.symmetric(horizontal: 12.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.0),
                                border: Border.all(color: Color(0xFFB7B7B7)),
                                color: Colors.white,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '14:00',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  Icon(Icons.access_time, color: Colors.grey),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                ],
              ),
        
            SizedBox(height: 16.0),
    
            // Row 8: Reason
            Text(
              'Reason*',
              style: TextStyle(
                color: Color(0xFF7A7A7A),
                fontFamily: 'Satoshi',
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 8.0),
    
            // Row 9: Reason Text Field
            Container(
              height: 100.0,
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                border: Border.all(color: Color(0xFFB7B7B7)),
                color: Colors.white,
              ),
              child: TextField(
                maxLength: 200,
                maxLines: 5,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter reason...',
                ),
              ),
            ),
            SizedBox(height: 8.0),
    
            // Row 10: Characters Remaining
            Text(
              '200/200 characters remaining',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 16.0),
    
            // Row 11: Submit Button

            CorneredButton(
                    height: 50,
                    color: primaryColor,
                    title: 'Submit',
                    textcolor: backgroundColor,
                    onPress: () async {

                    },
                  )
          ],
        ),
      ),
    );
  }
}
