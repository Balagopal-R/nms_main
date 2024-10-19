import 'package:flutter/material.dart';
import 'package:nms/features/nms_main_layout/leave_balance/balances/balance_screen.dart';
import 'approvals_leave/approvals_leave.dart';
import 'package:nms/utils/theme/theme_constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'leave_bottomsheet/apply_leave_bottomsheet.dart';

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
    _controller?.addListener(_handleTabSelection); // Add listener
  }

    void _handleTabSelection() {
    setState(() {}); // Update the UI when the tab changes
  }

    @override
  void dispose() {
    _controller?.removeListener(_handleTabSelection);
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: scaffoldBackgroundColor,
        title: const Text('Leave Balance'),
        centerTitle: true,
        actions: _controller?.index == 1 // Check if the ApprovalsLeaveScreen is selected
            ? [
                IconButton(
                   icon: Padding(
                     padding: const EdgeInsets.only(right: 8.0),
                     child: SvgPicture.asset('assets/svg/filter.svg', height: 24, width: 24),
                   ),
                  onPressed: () {},
                ),
              ]
            : [], // No actions if BalancesScreen is selected

      ),
      floatingActionButton: FloatingActionButton(
  onPressed: () {

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return const ApplyLeaveBottomSheetScreen();
      },
    );

  },
   backgroundColor: lightGreenTextColor,
   foregroundColor: backgroundColor,
   child: const Icon(Icons.add),
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
                    borderRadius: BorderRadius.circular(4),
                    color: veryLightGray,
                    border: Border.all(color: primaryGray, width: .1 )),
                  child: TabBar(
                    controller: _controller,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(color: primaryGray, width: .2),
                      color: backgroundColor,
                    
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
                    dividerColor: primaryGray,
                    indicatorSize: TabBarIndicatorSize.tab,
                    unselectedLabelColor: secondaryTextColor, // Not needed anymore
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
                children: const [
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
