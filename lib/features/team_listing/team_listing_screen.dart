import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nms/features/team_listing/team_listing.dart';
import 'package:nms/widgets/appbar_main_widget.dart';
import 'package:nms/widgets/search_text_field.dart';

import '../../widgets/team_listing_card.dart';

class TeamListingScreen extends StatelessWidget {
  const TeamListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TeamListingController>(
        init: TeamListingController(),
        builder: (controller) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: appbarMain(context, 'Team Listing'),
              body: Padding(
                padding: const EdgeInsets.only(
                    left: 23, top: 23, right: 23, bottom: 16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: SearchTextField(
                              controller: controller.searchEmployeeController),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Image.asset('assets/png/slider.png')
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: 10,
                          itemBuilder: (builder, index) {
                            return const TeamListingCard(
                              name: 'codey Lane',
                              designation: 'Full Stack Developer',
                              team:'Tech Team',
                            );
                          }),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
