import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nms/features/nms_main_layout/dashboard/dashboard.dart';
import 'package:nms/features/nms_main_layout/leave/leave_screen.dart';
import 'package:nms/features/nms_main_layout/punch/punch_screen.dart';
import 'package:nms/features/nms_main_layout/team_listing/team_listing.dart';
import 'package:nms/features/profile/profile_screen.dart';
import 'package:popup_menu/popup_menu.dart';

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

//  void _showPopupMenu() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return Dialog(
//           backgroundColor: Colors.transparent,
//           child: Container(
//             width: MediaQuery.of(context).size.width * 0.9,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       _buildMenuItem(Icons.access_time, 'Timesheet', () {
//                         // Navigator.pushNamed(context, '/timesheet');
//                         Navigator.of(context).pop();
//                       }),
//                       _buildMenuItem(Icons.person, 'Profile', () {
//                         print('Baluuuuu');
//                         Get.toNamed('/profile_screen');
//                         Navigator.of(context).pop();
//                       }),
//                       _buildMenuItem(Icons.settings, 'Settings', () {
//                         // Navigator.pushNamed(context, '/settings');
//                         Navigator.of(context).pop();
//                       }),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         IconButton(
//           icon: Icon(icon, color: Colors.teal),
//           onPressed: onTap,
//         ),
//         Text(title, style: TextStyle(color: Colors.black)),
//       ],
//     );
//   }
  void _showPopupMenu() {
  PopupMenu menu = PopupMenu(
    context: context,
    items: [
      MenuItem(
        title: 'Timesheet',
        image: Icon(Icons.access_time, color: Colors.white),
      ),
      MenuItem(
        title: 'Profile',
        image: Icon(Icons.person, color: Colors.white),
      ),
      MenuItem(
        title: 'Settings',
        image: Icon(Icons.settings, color: Colors.white),
      ),
    ],
    onClickMenu: (MenuItemProvider item) {
      switch (item.menuTitle) {
        case 'Timesheet':
          // Navigator.pushNamed(context, '/timesheet');
          break;
        case 'Profile':
          Get.toNamed('/profile_screen');
          break;
        case 'Settings':
          // Navigator.pushNamed(context, '/settings');
          break;
      }
    },
  );
  menu.show(widgetKey: _moreIconKey);
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
            _showPopupMenu();
          } else {
            _onItemTapped(index);
          }
        },
      ),
    );
  }
}
