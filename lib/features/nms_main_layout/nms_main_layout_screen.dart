import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
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

 void showCustomBottomSheet(BuildContext context) {
  showMaterialModalBottomSheet(
    context: context,
    builder: (context) => Container(
      padding: EdgeInsets.all(16.0),
      height: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        children: [
          Container(
            width: 100,
            height: 4,
            margin: EdgeInsets.only(bottom: 16.0),
            decoration: BoxDecoration(
              color: Color(0xFF7A7A7A),
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildBottomSheetItem(
                context,
                icon: Icons.access_time,
                label: 'Timesheet',
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.pushNamed(context, '/timesheet');
                },
              ),
              _buildBottomSheetItem(
                context,
                icon: Icons.person,
                label: 'Profile',
                onTap: () {
                  Get.toNamed('/profile_screen');
                },
              ),
              _buildBottomSheetItem(
                context,
                icon: Icons.settings,
                label: 'Settings',
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.pushNamed(context, '/settings');
                },
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _buildBottomSheetItem(BuildContext context, {required IconData icon, required String label, required VoidCallback onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 30, color: Colors.teal),
        SizedBox(height: 8),
        Text(label, style: TextStyle(color: Colors.teal)),
      ],
    ),
  );
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
        // selectedItemColor: Colors.amber[800],
         onTap: (index) {
          if (index == 4) {
            // _showPopupMenu();
            showCustomBottomSheet(context);
          } else {
            _onItemTapped(index);
          }
        },
      ),
    );
  }
}
