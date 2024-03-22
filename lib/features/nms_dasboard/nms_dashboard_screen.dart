import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../team_listing/team_listing.dart';

class NmsDashboardScreen extends StatelessWidget {
  const NmsDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
            onTap: () {
              Get.to(const TeamListingScreen());
            },
            child: const Text('dashBoard')),
      ),
    );
  }
}
