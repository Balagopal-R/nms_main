import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../leave_balance/leave_balance.dart';

class NmsDashboardScreen extends StatelessWidget {
  const NmsDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
            onTap: () {
              Get.to(const LeaveBalanceScreen());
            },
            child: const Text('dashBoard')),
      ),
    );
  }
}
