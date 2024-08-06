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
    _controller = TabController(length: 3, vsync: this, initialIndex: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Color(0xffFFAFAFA),
      appBar: AppBar(
        backgroundColor: Color(0xffFFAFAFA),
        leading: IconButton(
          icon: Image.asset('assets/png/arrow_left.png',height: 24,width: 24),
          onPressed: () {
          },
        ),
        title: Text('Punch Records'),
        centerTitle: true,
        actions: [
          IconButton(
          icon: Image.asset('assets/png/calendar.png',height: 24,width: 24),
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
     
body: Padding(
  padding: const EdgeInsets.only(left: 22, right: 21, bottom: 8),
  child: Column(  // Use Column for top-center alignment
    children: [
      Padding(  // Maintain padding around the tab bar
        padding: const EdgeInsets.all(2.0),
        child: Center(  // Center the tab bar horizontally
          child: TabBar(
            controller: _controller,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: Colors.white,
            ),
            labelColor: primaryColor,
            labelStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
            unselectedLabelStyle: const TextStyle(  // Update here
              fontSize: 14,
              fontWeight: FontWeight.w400,
              // color: Color(0xFF7A7A7A),  // Set color to #7A7A7A
            ),
            dividerColor: messageColor,
            indicatorSize: TabBarIndicatorSize.tab,
            unselectedLabelColor: Color(0xFF7A7A7A),  // Not needed anymore
            tabs: const [
              Tab(text: 'History'),
              Tab(text: 'Approvals'),
              Tab(text: 'Summary'),
            ],
          ),
        ),
      ),
      Expanded(  // Use Expanded for flexible content area
        child: TabBarView(
          controller: _controller,
          children: [
            HistoryScreen(),
            ApprovalsScreen(),
            SummaryScreen(),
          ],
        ),
      ),
    ],
  ),
),
    );

 }
}