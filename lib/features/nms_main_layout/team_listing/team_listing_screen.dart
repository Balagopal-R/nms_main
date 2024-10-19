import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nms/features/nms_main_layout/team_listing/team_listing_controller.dart';
import 'package:nms/utils/theme/theme.dart';
import 'package:nms/widgets/punch_in_request_bottomsheet.dart';
import 'package:nms/widgets/punch_out_request_bottomsheet.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../models/team_list_model/team_list_model.dart';

// ignore: use_key_in_widget_constructors
class TeamListingScreen extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _TeamListingScreenState createState() => _TeamListingScreenState();
}

class _TeamListingScreenState extends State<TeamListingScreen> {
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TeamListingController>(
      init: TeamListingController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: scaffoldBackgroundColor,
          appBar: AppBar(
            backgroundColor: scaffoldBackgroundColor,
            title: const Text('Team Listing'),
            centerTitle: true,
            actions: [
              IconButton(
                icon: Image.asset(isSearching
                    ? 'assets/png/cross.png'
                    : 'assets/png/search.png'),
                onPressed: () {
                  setState(() {
                    isSearching = !isSearching;
                  });
                },
              ),
            ],
            bottom: isSearching
                ? PreferredSize(
                    preferredSize: const Size.fromHeight(60.0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {},
                              child: Container(
                                height: 48.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4.0),
                                  border: Border.all(color: primaryGray),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: const Row(
                                  children: [
                                    Icon(Icons.search, color: primaryGray),
                                    SizedBox(width: 8.0),
                                    Text('Search Employee',
                                        style: TextStyle(color: primaryGray)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: 48.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.0),
                                border: Border.all(color: primaryGray),
                              ),
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset('assets/png/slider.png'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : null,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              await controller.getLastPunchIn();
              if (controller.getEmployPunchIn?.punchOutDateTime != null) {
                await showModalBottomSheet(
                  // ignore: use_build_context_synchronously
                  context: context,
                  builder: (context) {
                    return const PunchInRequestSheetContent();
                  },
                );
              } else {
                await showModalBottomSheet(
                  // ignore: use_build_context_synchronously
                  context: context,
                  builder: (context) {
                    return const PunchOutRequestSheetContent();
                  },
                );
              }
            },
            backgroundColor: lightGreenTextColor,
            child: const Image(
              image: AssetImage('assets/png/plus.png'),
            ),
          ),
          body: PagedListView<int, TeamListingModel>(
            pagingController: controller.pagingController,
            builderDelegate: PagedChildBuilderDelegate<TeamListingModel>(
              itemBuilder: (context, item, index) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  border:
                      const Border(bottom: BorderSide(color: veryLightGray)),
                  color: Colors.white,
                ),
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Stack(
                              children: [
                                CircleAvatar(
                                  radius: 24,
                                  backgroundImage: NetworkImage(
                                      item.profileImg?.toString() ??
                                          'https://picsum.photos/250?image=9'),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: CircleAvatar(
                                      radius: 6,
                                      backgroundColor:
                                          controller.getColorBasedOnConditions(
                                              item.punchIn != null,
                                              item.punchOut == null)),
                                ),
                              ],
                            ),
                            const SizedBox(width: 8.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item.firstname,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: primaryTextColor,
                                        fontSize: 14)),
                                Text(item.designation.toString(),
                                    style: const TextStyle(
                                        color: secondaryTextColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400)),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Image(
                                  image: AssetImage('assets/png/punch_in.png'),
                                  height: 20.0,
                                  width: 20.0,
                                ),
                                const SizedBox(width: 4.0),
                                Text(
                                  controller.epochToTimeString(item.punchIn),
                                  style: const TextStyle(
                                      color: darkGray,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Image(
                                  image: AssetImage('assets/png/punch_out.png'),
                                  height: 20.0,
                                  width: 20.0,
                                ),
                                const SizedBox(width: 4.0),
                                Text(
                                    controller.epochToTimeString(item.punchOut),
                                    style: const TextStyle(
                                        color: darkGray,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500)),
                              ],
                            ),
                            Row(
                              children: [
                                const Image(
                                  image: AssetImage('assets/png/location.png'),
                                  height: 20.0,
                                  width: 20.0,
                                ),
                                const SizedBox(width: 4.0),
                                Text(item.punchLocation.toString(),
                                    style: const TextStyle(
                                        color: darkGray,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500)),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6.0, vertical: 2.0),
                        decoration: BoxDecoration(
                          color: controller.getContainerColorBasedOnPunchStatus(
                              item.status.toString()),
                          borderRadius: BorderRadius.circular(2.667),
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 4.0,
                              backgroundColor:
                                  controller.getColorBasedOnPunchStatus(
                                      item.status.toString()),
                            ),
                            const SizedBox(width: 4.0),
                            Text(
                                controller.capitalizeFirstLetter(
                                    item.status.toString()),
                                style: TextStyle(
                                    color:
                                        controller.getColorBasedOnPunchStatus(
                                            item.status.toString()),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              firstPageErrorIndicatorBuilder: (context) => const Center(
                child: Text('Error occurred, please try again.'),
              ),
              noItemsFoundIndicatorBuilder: (context) => const Center(
                child: Text('No team listing found.'),
              ),
              newPageProgressIndicatorBuilder: (context) => const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        );
      },
    );
  }
}
