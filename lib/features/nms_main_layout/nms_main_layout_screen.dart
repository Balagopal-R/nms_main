import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nms/features/nms_main_layout/dashboard/dashboard.dart';
import 'package:nms/features/nms_main_layout/leave_balance/leave_balance_screen.dart';
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
  final Color selectedColor = lightGreenTextColor;

  static List<Widget> _widgetOptions = <Widget>[
    DashboardScreen(),
    TeamListingScreen(),
    PunchScreen(),
    LeaveBalanceScreen()
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
        selectedItemColor: selectedColor,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svg/home.svg',
              height: 24,
              width: 24,
              colorFilter: _selectedIndex == 0 ? ColorFilter.mode(selectedColor, BlendMode.srcIn) : null,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svg/teamListing.svg',
              height: 24,
              width: 24,
              colorFilter: _selectedIndex == 1 ? ColorFilter.mode(selectedColor, BlendMode.srcIn) : null,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svg/punch.svg',
              height: 24,
              width: 24,
              colorFilter: _selectedIndex == 2 ? ColorFilter.mode(selectedColor, BlendMode.srcIn) : null,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svg/calendar_remove_colorless.svg',
              height: 24,
              width: 24,
              colorFilter: _selectedIndex == 3 ? ColorFilter.mode(selectedColor, BlendMode.srcIn) : null,
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
                builder: (context) => const CustomBottomSheet(),
                shape: const RoundedRectangleBorder(
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
        selectedIconTheme: const IconThemeData(color: lightGreenTextColor),
        unselectedIconTheme: const IconThemeData(color: Colors.transparent), 
      ),
    );
  }
}

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({super.key});

  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
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
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 5,
            width: 50,
            decoration: BoxDecoration(
              color: secondaryTextColor,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BottomSheetColumn(
                iconPath: 'assets/png/time_tracking_icon.png',
                label: 'Timesheet',
                onTap: () {
                  
                },
                textColor: primaryTextColor,
                textStyle: const TextStyle(fontFamily: 'Satoshi'),
              ),
              BottomSheetColumn(
                iconPath: 'assets/png/profile.png',
                label: 'Profile',
                onTap: () {
                  Navigator.pop(context);
                   Get.toNamed('/profile_screen');
                },
                textColor: primaryTextColor,
                textStyle: const TextStyle(fontFamily: 'Satoshi'),
              ),
              BottomSheetColumn(
                iconPath: 'assets/png/settings.png',
                label: 'Settings',
                onTap: () {
                  
                },
                textColor: primaryTextColor,
                textStyle: const TextStyle(fontFamily: 'Satoshi'),
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
          const SizedBox(height: 5),
          Text(
            label,
            style: textStyle.copyWith(color: textColor),
          ),
        ],
      ),
    );
  }
}
