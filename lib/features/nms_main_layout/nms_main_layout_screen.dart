import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nms/features/nms_main_layout/dashboard/dashboard.dart';
import 'package:nms/features/nms_main_layout/leave/leave_screen.dart';
import 'package:nms/features/nms_main_layout/punch/punch_screen.dart';
import 'package:nms/features/nms_main_layout/team_listing/team_listing.dart';
import 'package:nms/utils/theme/theme_constants.dart';

class NmsMainLayoutScreen extends StatefulWidget {
  const NmsMainLayoutScreen({super.key});

  @override
  State<NmsMainLayoutScreen> createState() => _NmsMainLayoutScreenState();
}

class _NmsMainLayoutScreenState extends State<NmsMainLayoutScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    DashboardScreen(),
    LeaveScreen(),
    PunchScreen(),
    TeamListingScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      floatingActionButton: SpeedDial(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
        buttonSize: const Size(48, 48),
        //animatedIcon: AnimatedIcons.add_event,
        icon: Icons.add,
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
            padding: const EdgeInsets.only(right: 5),
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
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
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
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Page')),
      body: Center(child: Text('Home Page Content')),
    );
  }
}

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Search Page')),
      body: Center(child: Text('Search Page Content')),
    );
  }
}

class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notifications Page')),
      body: Center(child: Text('Notifications Page Content')),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile Page')),
      body: Center(child: Text('Profile Page Content')),
    );
  }
}
