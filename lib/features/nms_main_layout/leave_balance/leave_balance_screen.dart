import 'package:flutter/material.dart';
import 'package:nms/features/nms_main_layout/leave_balance/balances/balance_screen.dart';
import 'approvals_leave/approvals_leave.dart';
import 'package:nms/utils/theme/theme_constants.dart';

class LeaveBalanceScreen extends StatefulWidget {
  const LeaveBalanceScreen({super.key});

  @override
  State<LeaveBalanceScreen> createState() => _LeaveBalanceScreenState();
}

class _LeaveBalanceScreenState extends State<LeaveBalanceScreen>
    with SingleTickerProviderStateMixin {
  TabController? _controller;
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFAFAFA),
      appBar: AppBar(
        backgroundColor: Color(0xffFFAFAFA),
        title: Text('Leave Balance'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Image.asset('assets/png/calendar.png', height: 24, width: 24),
            onPressed: () {},
          ),
        ],

      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 22, right: 22, bottom: 8),
        child: Column(
          // Use Column for top-center alignment
          children: [
            Padding(
              // Maintain padding around the tab bar
              padding: const EdgeInsets.all(2.0),
              child: Center(
                // Center the tab bar horizontally
                child: Container(
                  width: 250,
                  decoration: BoxDecoration(
                    color: Color(0xffF1F1F1),
                    border: Border.all(color: Color(0xFFB7B7B7), width: .3 )),
                  child: TabBar(
                    controller: _controller,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(color: Color(0xFFB7B7B7), width: .2),
                      color: Colors.white,
                    
                    ),
                    labelColor: primaryColor,
                    labelStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                    unselectedLabelStyle: const TextStyle(
                      // Update here
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      // color: Color(0xFF7A7A7A),  // Set color to #7A7A7A
                    ),
                    dividerColor: messageColor,
                    indicatorSize: TabBarIndicatorSize.tab,
                    unselectedLabelColor: Color(0xFF7A7A7A), // Not needed anymore
                    tabs: const [
                      Tab(text: 'Balances'),
                      Tab(text: 'Approvals'),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              // Use Expanded for flexible content area
              child: TabBarView(
                controller: _controller,
                children: [
                  BalancesScreen(),
                  ApprovalsLeaveScreen(),
                 
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
