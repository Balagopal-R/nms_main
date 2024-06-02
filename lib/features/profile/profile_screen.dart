import 'package:flutter/material.dart';
import 'package:nms/utils/utils.dart';
import 'package:nms/widgets/appbar_main_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: appbarMain(context, "Profile"),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF1F1F1),
                borderRadius: BorderRadius.circular(4.0),
              ),
              padding: const EdgeInsets.all(16.0),
              child: const Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/png/person.jpg'),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Ryan Lewis',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.black),
                  ),
                  SizedBox(height: 4),
                  Text('NE044',
                  style: TextStyle(color: Color(0xff7A7A7A)),),
                  SizedBox(height: 4),
                  Text('ryanlewis@nintrivia.com',
                  style: TextStyle(color: Color(0xff7A7A7A)),),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Tech Team',style: TextStyle(color: Color(0xff7A7A7A)),),
                      SizedBox(width: 4),
                      Icon(Icons.circle, size: 5, color: Colors.green),
                      SizedBox(width: 4),
                      Text('Developer',style: TextStyle(color: Color(0xff7A7A7A)),),
                      SizedBox(width: 4),
                      Icon(Icons.circle, size: 5, color: Colors.green),
                      SizedBox(width: 4),
                      Text('Joined 2022',style: TextStyle(color: Color(0xff7A7A7A)),),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ProfileButton(
              title: 'Basic Details',
              onTap: () {
                // Navigate to Basic Details page
              },
            ),
            ProfileButton(
              title: 'My Documents',
              onTap: () {
                // Navigate to My Documents page
              },
            ),
            LogoutButton(
              onTap: () {
                _showLogoutDialog(context);
              },
            ),
          ],
        ),

    )
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Handle logout action
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }
}

class ProfileButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const ProfileButton({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Color(0xFFF1F1F1))),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500),),
            const Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}

class LogoutButton extends StatelessWidget {
  final VoidCallback onTap;

  const LogoutButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(top: 16.0),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFFFC1C1)),
          borderRadius: BorderRadius.circular(4.0),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Logout',
              style: TextStyle(color: Colors.red),
            ),
            Icon(Icons.logout, color: Colors.red),
          ],
        ),
      ),
    );
  }
}