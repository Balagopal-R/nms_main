import 'package:flutter/material.dart';
import 'package:nms/features/nms_main_layout/punch/approvals/approvals.dart';
import 'package:nms/features/nms_main_layout/punch/summary/summary_screen.dart';
import 'package:nms/utils/theme/theme_constants.dart';

import 'history/history_screen.dart';

class PunchScreen extends StatefulWidget {
  const PunchScreen({super.key});

  @override
  State<PunchScreen> createState() => _PunchScreenState();
}

class _PunchScreenState extends State<PunchScreen> with SingleTickerProviderStateMixin {

  TabController? _controller;
  bool isSearching = false;

    @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Color(0xffF1F1F1),
      appBar: AppBar(
        backgroundColor: Color(0xffFAFAFA),
        leading: IconButton(
          icon: Image.asset('assets/png/arrow_left.png',height: 24,width: 24),
          onPressed: () {
          },
        ),
        title: Text('Punch Records'),
        centerTitle: true,
        actions: [
          IconButton(
          icon: Image.asset('assets/png/cross.png',height: 24,width: 24),
          onPressed: () {
          },
        ),
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
                                Text('Search', style: TextStyle(color: Colors.grey)),
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
      // body: Padding(
      //                       padding: const EdgeInsets.only(
      //                           left: 22, right: 21, bottom: 8),
      //                       child: Container(
      //                         height: 34,
      //                         width: 300,
      //                         decoration: BoxDecoration(
      //                           color: messageColor,
      //                           borderRadius: BorderRadius.circular(
      //                             5.0,
      //                           ),
      //                         ),
      //                         child: Padding(
      //                           padding: const EdgeInsets.all(2.0),
      //                           child: TabBar(
      //                             controller: _controller,
      //                             indicator: BoxDecoration(
      //                               borderRadius: BorderRadius.circular(
      //                                 5.0,
      //                               ),
      //                               color: Colors.white,
      //                             ),
      //                             labelColor: primaryColor,
      //                             labelStyle: const TextStyle(
      //                                 fontSize: 14,
      //                                 fontWeight: FontWeight.w700),
      //                             unselectedLabelStyle: const TextStyle(
      //                                 fontSize: 14,
      //                                 fontWeight: FontWeight.w400),
      //                             dividerColor: messageColor,
      //                             indicatorSize: TabBarIndicatorSize.tab,
      //                             unselectedLabelColor: Colors.white,
      //                             tabs: const [
      //                               Tab(
      //                                 text: 'History',
      //                               ),
      //                               Tab(
      //                                 text: 'Approvals',
      //                               ),
      //                               Tab(
      //                                 text: 'Summary',
      //                               ),
      //                             ],
                                
        
      //                           ),
      //                         ),
      //                       ),
      //                     ),

    body: SafeArea(
        child: Container(
          // decoration: BoxDecoration(
          //                       color: messageColor,
          //                       borderRadius: BorderRadius.circular(
          //                         5.0,
          //                       ),
          //                     ),
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 10,
          ),
          child: DefaultTabController(
            length: 3,
            initialIndex: 2,
            child: Column(
              children: [
                Container(
                  height: 47,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      border: Border.all(color: Colors.grey, width: 1)),
                  child: TabBar(
                    unselectedLabelColor: Colors.grey[900],
                    indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: Color(0xffCAE3A8)),
                    tabs: [
                      Tab(
                        child: Container(
                          child: const Text(
                            "History",
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          child: const Text(" Approvals ",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.black)),
                        ),
                      ),
                      Tab(
                        child: Container(
                          child: const Text("Summary",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.black)),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                    child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    const HistoryScreen(),
                    ApprovalsScreen(),
                    const SummaryScreen(),
                    
                  ],
                ))
              ],
            ),
          ),
        ),
      ),


    );




  }
}