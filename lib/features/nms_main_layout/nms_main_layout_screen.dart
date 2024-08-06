import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nms/features/nms_main_layout/dashboard/dashboard.dart';
import 'package:nms/features/nms_main_layout/leave/leave_screen.dart';
import 'package:nms/features/nms_main_layout/punch/punch_screen.dart';
import 'package:nms/features/nms_main_layout/team_listing/team_listing.dart';

class NmsMainLayoutScreen extends StatefulWidget {
  const NmsMainLayoutScreen({super.key});

  @override
  State<NmsMainLayoutScreen> createState() => _NmsMainLayoutScreenState();
}

class _NmsMainLayoutScreenState extends State<NmsMainLayoutScreen> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    DashboardScreen(),
    TeamListingScreen(),
    PunchScreen(),
    LeaveScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  final GlobalKey _moreIconKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Color(0xff3BBCA0),
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svg/home.svg',
              height: 24,
              width: 24,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svg/teamListing.svg',
              height: 24,
              width: 24,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svg/punch.svg',
              height: 24,
              width: 24,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svg/calendarRemove.svg',
              height: 24,
              width: 24,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svg/more.svg',
              height: 24,
              width: 24,key: _moreIconKey ,
            ),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
         onTap: (index) {
          if (index == 4) {
            showModalBottomSheet(
                context: context,
                builder: (context) => CustomBottomSheet(),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                backgroundColor: Colors.transparent,
              );
          } else {
            _onItemTapped(index);
          }
        },
        selectedIconTheme: IconThemeData(color: Color(0xff3BBCA0)),
        unselectedIconTheme: IconThemeData(color: Colors.transparent), 
      ),
    );
  }
}

class CustomBottomSheet extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
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
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 5,
            width: 50,
            decoration: BoxDecoration(
              color: Color(0xFF7A7A7A),
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BottomSheetColumn(
                iconPath: 'assets/png/time_tracking_icon.png',
                label: 'Timesheet',
                onTap: () {
                  
                },
                textColor: Colors.black,
                textStyle: TextStyle(fontFamily: 'Satoshi'),
              ),
              BottomSheetColumn(
                iconPath: 'assets/png/profile.png',
                label: 'Profile',
                onTap: () {
                  Navigator.pop(context);
                   Get.toNamed('/profile_screen');
                },
                textColor: Colors.black,
                textStyle: TextStyle(fontFamily: 'Satoshi'),
              ),
              BottomSheetColumn(
                iconPath: 'assets/png/settings.png',
                label: 'Settings',
                onTap: () {
                  
                },
                textColor: Colors.black,
                textStyle: TextStyle(fontFamily: 'Satoshi'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BottomSheetColumn extends StatelessWidget {
  final String iconPath;
  final String label;
  final VoidCallback onTap;
  final Color textColor;
  final TextStyle textStyle;

  const BottomSheetColumn({
    Key? key,
    required this.iconPath,
    required this.label,
    required this.onTap,
    required this.textColor,
    required this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Image.asset(iconPath, width: 30, height: 30),
          SizedBox(height: 5),
          Text(
            label,
            style: textStyle.copyWith(color: textColor),
          ),
        ],
      ),
    );
  }
}
