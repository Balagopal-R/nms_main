import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nms/features/nms_main_layout/team_listing/team_listing_controller.dart';
import 'package:nms/utils/theme/theme_constants.dart';
import 'package:nms/widgets/punch_bottom_sheet.dart';
import 'package:nms/widgets/punch_in_request_bottomsheet.dart';
import 'package:nms/widgets/punch_out_request_bottomsheet.dart';
import 'package:nms/widgets/punch_request_bottomsheet.dart';


class TeamListingScreen extends StatefulWidget {
  @override
  _TeamListingScreenState createState() => _TeamListingScreenState();
}

class _TeamListingScreenState extends State<TeamListingScreen> {
  bool isSearching = false;

  // final List<TeamMember> teamMembers = [
  //   TeamMember('Esther Howard', 'Technical', '09:00', 'On Time', 'WFO', 'assets/avatar1.png', Color(0xff2F9680)),
  //   TeamMember('Guy Hawkins', 'Design', '09:07', 'Late', 'WFH', 'assets/avatar2.png', Color(0xffFF4646)),
  //   TeamMember('Darlene Robertson', 'Finance', '09:00', 'Break', 'WFO', 'assets/avatar3.png', Colors.orange),
  //   TeamMember('Dianne Russell', 'Technical', '09:00', 'Absent', 'WFO', 'assets/avatar4.png', Colors.grey),
  //   TeamMember('Jerome Bell', 'Design', '09:00', 'Leave', 'WFO', 'assets/avatar5.png', Colors.purple),
  //   TeamMember('Jacob Jones', 'HR', '00:00', '08:56', 'WFO', 'assets/avatar6.png', Colors.blue),
  // ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TeamListingController>(
      init: TeamListingController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Color(0xffFAFAFA),
          appBar: AppBar(
            backgroundColor: Color(0xffFAFAFA),
            leading: IconButton(
              icon: Image.asset('assets/png/arrow_left.png', height: 24, width: 24),
              onPressed: () {
                Get.back();
              },
            ),
            title: Text('Team Listing'),
            centerTitle: true,
            actions: [
              IconButton(
                icon: Image.asset(isSearching ? 'assets/png/cross.png' : 'assets/png/search.png'),
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
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
                                    Text('Search Employee', style: TextStyle(color: Colors.grey)),
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
            onPressed: () async{

              if(controller.getEmployPunchIn!.punchOutDateTime != null){

               await showModalBottomSheet(
                context: context,
                builder: (context) {
                  return PunchInRequestSheetContent();
                },
              );

  }else{

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
          body: controller.teamListing != null? ListView.builder(
            itemCount: controller.teamListing.length,
            itemBuilder: (context, index) {
              return Container(
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
                        backgroundImage: NetworkImage(controller.teamListing[index].profileImg.toString()),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          radius: 6,
                          backgroundColor: Colors.green
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 8.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(controller.teamListing[index].firstname, style: TextStyle(fontWeight: FontWeight.w700, color: Colors.black, fontSize: 14)),
                      Text(controller.teamListing[index].designation, style: TextStyle(color: Color(0xff7A7A7A), fontSize: 12, fontWeight: FontWeight.w400)),
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
  controller.teamListing[index].punchIn?.toString() ?? '--:--',
  style: TextStyle(color: Color(0xff888888), fontSize: 12, fontWeight: FontWeight.w500),
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
                      Text('--:--', style: TextStyle(color: Color(0xff888888), fontSize: 12, fontWeight: FontWeight.w500)),
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
                      Text(controller.teamListing[index]!.punchLocation.toString(), style: TextStyle(color: Color(0xff888888), fontSize: 12, fontWeight: FontWeight.w500)),
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
              padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
              decoration: BoxDecoration(
                color:Color(0xffBEFFE8),
                borderRadius: BorderRadius.circular(2.667),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 4.0,
                    backgroundColor: Color(0xff2F9680),
                  ),
                  SizedBox(width: 4.0),
                  Text("On Time", style: TextStyle(color: Color(0xff2F9680))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
            }, 
          ) : const Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      ),
                    ),
        );
      },
    );
  }
}

// class TeamMember {
//   final String name;
//   final String role;
//   final String checkInTime;
//   final String status;
//   final String workLocation;
//   final String avatar;
//   final Color statusColor;

//   TeamMember(this.name, this.role, this.checkInTime, this.status, this.workLocation, this.avatar, this.statusColor);
// }

// class TeamMemberCard extends StatelessWidget {
//   final TeamMember teamMember;

//   TeamMemberCard({required this.teamMember});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(4.0),
//         border: Border(bottom: BorderSide(color: Color(0xFFF1F1F1))),
//         color: Colors.white,
//       ),
//       margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//       padding: EdgeInsets.all(8.0),
//       child: Stack(
//         children: [
//           Column(
//             children: [
//               Row(
//                 children: [
//                   Stack(
//                     children: [
//                       CircleAvatar(
//                         radius: 24,
//                         backgroundImage: AssetImage(teamMember.avatar),
//                       ),
//                       Positioned(
//                         bottom: 0,
//                         right: 0,
//                         child: CircleAvatar(
//                           radius: 6,
//                           backgroundColor: teamMember.statusColor,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(width: 8.0),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(teamMember.name, style: TextStyle(fontWeight: FontWeight.w700, color: Colors.black, fontSize: 14)),
//                       Text(teamMember.role, style: TextStyle(color: Color(0xff7A7A7A), fontSize: 12, fontWeight: FontWeight.w400)),
//                     ],
//                   ),
//                 ],
//               ),
//               SizedBox(height: 8.0),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Row(
//                     children: [
//                       Image(
//                         image: AssetImage('assets/png/punch_in.png'),
//                         height: 20.0,
//                         width: 20.0,
//                       ),
//                       SizedBox(width: 4.0),
//                       Text(teamMember.checkInTime, style: TextStyle(color: Color(0xff888888), fontSize: 12, fontWeight: FontWeight.w500)),
//                     ],
//                   ),
//                   Row(
//                     children: [
//                       Image(
//                         image: AssetImage('assets/png/punch_out.png'),
//                         height: 20.0,
//                         width: 20.0,
//                       ),
//                       SizedBox(width: 4.0),
//                       Text('--:--', style: TextStyle(color: Color(0xff888888), fontSize: 12, fontWeight: FontWeight.w500)),
//                     ],
//                   ),
//                   Row(
//                     children: [
//                       Image(
//                         image: AssetImage('assets/png/location.png'),
//                         height: 20.0,
//                         width: 20.0,
//                       ),
//                       SizedBox(width: 4.0),
//                       Text(teamMember.workLocation, style: TextStyle(color: Color(0xff888888), fontSize: 12, fontWeight: FontWeight.w500)),
//                     ],
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           Positioned(
//             top: 0,
//             right: 0,
//             child: Container(
//               padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
//               decoration: BoxDecoration(
//                 color: teamMember.statusColor.withOpacity(0.2),
//                 borderRadius: BorderRadius.circular(2.667),
//               ),
//               child: Row(
//                 children: [
//                   CircleAvatar(
//                     radius: 4.0,
//                     backgroundColor: teamMember.statusColor,
//                   ),
//                   SizedBox(width: 4.0),
//                   Text(teamMember.status, style: TextStyle(color: teamMember.statusColor)),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

