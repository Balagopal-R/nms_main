import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nms/features/nms_main_layout/team_listing/team_listing_controller.dart';
import 'package:nms/widgets/punch_in_request_bottomsheet.dart';
import 'package:nms/widgets/punch_out_request_bottomsheet.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../models/team_list_model/team_list_model.dart';

class TeamListingScreen extends StatefulWidget {
  @override
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
          backgroundColor: Color(0xffFAFAFA),
          appBar: AppBar(
            backgroundColor: Color(0xffFAFAFA),
            title: Text('Team Listing'),
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
                    preferredSize: Size.fromHeight(60.0),
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
                                  border: Border.all(color: Color(0xFFB7B7B7)),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Row(
                                  children: [
                                    Icon(Icons.search, color: Colors.grey),
                                    SizedBox(width: 8.0),
                                    Text('Search Employee',
                                        style: TextStyle(color: Colors.grey)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 8.0),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: 48.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.0),
                                border: Border.all(color: Color(0xFFB7B7B7)),
                              ),
                              padding: EdgeInsets.all(8.0),
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
              if (controller.getEmployPunchIn?.punchOutDateTime != null) {
                await showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return PunchInRequestSheetContent();
                  },
                );
              } else {
                await showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return PunchOutRequestSheetContent();
                  },
                );
              }
            },
            backgroundColor: Color(0xFF3BBCA0),
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
                  border: Border(bottom: BorderSide(color: Color(0xFFF1F1F1))),
                  color: Colors.white,
                ),
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                padding: EdgeInsets.all(8.0),
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
                            SizedBox(width: 8.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item.firstname,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                        fontSize: 14)),
                                Text(item.designation.toString(),
                                    style: TextStyle(
                                        color: Color(0xff7A7A7A),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400)),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image(
                                  image: AssetImage('assets/png/punch_in.png'),
                                  height: 20.0,
                                  width: 20.0,
                                ),
                                SizedBox(width: 4.0),
                                Text(
                                  controller.epochToTimeString(item.punchIn),
                                  style: TextStyle(
                                      color: Color(0xff888888),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Image(
                                  image: AssetImage('assets/png/punch_out.png'),
                                  height: 20.0,
                                  width: 20.0,
                                ),
                                SizedBox(width: 4.0),
                                Text(
                                    controller.epochToTimeString(item.punchOut),
                                    style: TextStyle(
                                        color: Color(0xff888888),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500)),
                              ],
                            ),
                            Row(
                              children: [
                                Image(
                                  image: AssetImage('assets/png/location.png'),
                                  height: 20.0,
                                  width: 20.0,
                                ),
                                SizedBox(width: 4.0),
                                Text(item.punchLocation.toString(),
                                    style: TextStyle(
                                        color: Color(0xff888888),
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
                        padding: EdgeInsets.symmetric(
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
                            SizedBox(width: 4.0),
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
              firstPageErrorIndicatorBuilder: (context) => Center(
                child: Text('Error occurred, please try again.'),
              ),
              noItemsFoundIndicatorBuilder: (context) => Center(
                child: Text('No team listing found.'),
              ),
              newPageProgressIndicatorBuilder: (context) => Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        );
      },
    );
  }
}
