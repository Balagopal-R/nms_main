import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nms/utils/utils.dart';
import 'package:nms/widgets/appbar_main_widget.dart';

import 'profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: backgroundColor,
          appBar: appbarMain(context, "Profile"),
          body:  controller.getEmployData != null ?
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(height: 40),
                Container(
  decoration: BoxDecoration(
    color: const Color(0xFFF1F1F1),
    borderRadius: BorderRadius.circular(4.0),
  ),
  padding: const EdgeInsets.only(top: 48.0, left: 16.0, right: 16.0, bottom: 16.0),
  child: Stack(
    clipBehavior: Clip.none,
    alignment: Alignment.center,
    children: [
      Column(
        children: [
          SizedBox(height: 10), // This creates space for the CircleAvatar
          Text(
            '${controller.getEmployData!.personalDetails.firstname} ${controller.getEmployData!.personalDetails.lastname}',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          SizedBox(height: 4),
          Text(
            controller.getEmployData!.employeeCode,
            style: TextStyle(color: Color(0xff7A7A7A)),
          ),
          SizedBox(height: 4),
          Text(
            controller.getEmployData!.personalDetails.personalEmail,
            style: TextStyle(color: Color(0xff7A7A7A)),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                controller.getEmployData!.corporateDetails.department.departmentName,
                style: TextStyle(color: Color(0xff7A7A7A)),
              ),
              SizedBox(width: 4),
              Icon(Icons.circle, size: 5, color: Colors.green),
              SizedBox(width: 4),
              Text(
                controller.getEmployData!.corporateDetails.designation.designationName,
                style: TextStyle(color: Color(0xff7A7A7A)),
              ),
              SizedBox(width: 4),
              Icon(Icons.circle, size: 5, color: Colors.green),
              SizedBox(width: 4),
              Text(
                controller.getEmployData!.corporateDetails.dateOfFirstJoining.toString(),
                style: TextStyle(color: Color(0xff7A7A7A)),
              ),
            ],
          ),
        ],
      ),
      Positioned(
        top: -90, // Half of the CircleAvatar's diameter to center it
        child: CircleAvatar(
          radius: 40,
          backgroundImage: NetworkImage(controller.getEmployData!.profileImgUrl!), // Replace with your image URL
        ),
      ),
    ],
  ),
),

                const SizedBox(height: 16),
                ProfileButton(
                  title: 'Basic Details',
                  onTap: () {
                   Get.toNamed('/basic_details_screen');
                  },
                ),
                ProfileButton(
                  title: 'My Documents',
                  onTap: () {
                    Get.toNamed('/my_documents_screen');
                  },
                ),
                LogoutButton(
                  onTap: () {
                    // _showLogoutDialog(context);
                    controller.showCustomLogoutDialog(context);
                  },
                ),
              ],
            ),
        
        ) 
         : const Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      ),
                    ),
        );
      }
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
            
            // Icon(Icons.logout, color: Colors.red),

            Image(
  image: AssetImage('assets/png/logout.png'), // Adjust the path if needed
  color: Colors.red, // Apply desired color (optional)
)
          ],
        ),
      ),
    );
  }
}