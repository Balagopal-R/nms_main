import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../employee_details/employee_details_screen.dart';

class NmsDashboardScreen extends StatelessWidget {
  const NmsDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
            onTap: () {
              Get.to(const EmployeeDetailsScreen());
            },
            child: const Text('dashBoard')),
      ),
    );
  }
}
