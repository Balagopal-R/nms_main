import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nms/features/basic_details/basic_details.dart';

class NmsDashboardScreen extends StatelessWidget {
  const NmsDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
            onTap: () {
              Get.to(const BasicDetailsScreen());
            },
            child: const Text('dashBoard')),
      ),
    );
  }
}
