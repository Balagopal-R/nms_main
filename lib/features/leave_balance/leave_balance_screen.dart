import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nms/widgets/appbar_main_widget.dart';

import '../../utils/utils.dart';
import 'leave_balance.dart';

class LeaveBalanceScreen extends StatefulWidget {
  const LeaveBalanceScreen({super.key});

  @override
  State<LeaveBalanceScreen> createState() => _LeaveBalanceScreenState();
}

class _LeaveBalanceScreenState extends State<LeaveBalanceScreen>
    with SingleTickerProviderStateMixin {
  TabController? _controller;
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LeaveBalanceController>(
        init: LeaveBalanceController(),
        builder: (controller) {
          return SafeArea(
              child: Scaffold(
            appBar: appbarMain(context, 'Leave Balances'),
            body: Column(
              children: [
                Column(
                  children: [
                    Container(
                      height: 34,
                      width: 189,
                      decoration: BoxDecoration(
                        color: messageColor,
                        borderRadius: BorderRadius.circular(
                          5.0,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: TabBar(
                          controller: _controller,
                          indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              5.0,
                            ),
                            color: Colors.white,
                          ),
                          labelColor: primaryColor,
                          labelStyle: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w700),
                          unselectedLabelStyle: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400),
                          dividerColor: messageColor,
                          indicatorSize: TabBarIndicatorSize.tab,
                          unselectedLabelColor: Colors.white,
                          tabs: const [
                            Tab(
                              text: 'Balance',
                            ),
                            Tab(
                              text: 'History',
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width - 15,
                        child: Wrap(
                            direction: Axis.horizontal,
                            spacing: 5,
                            alignment: WrapAlignment.start,
                            children: controller.items
                                .map(
                                  (e) => FilterChip(
                                    shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                            color: Colors.transparent),
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    backgroundColor: const Color(0xffF1F1F1),
                                    selectedColor: primaryColor,
                                    showCheckmark: false,
                                    label: Text(
                                      e,
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400,
                                          color: controller.contactsOptionList
                                                  .contains(e)
                                              ? Colors.white
                                              : const Color(0xff7A7A7A)),
                                    ),
                                    selected: controller.contactsOptionList
                                        .contains(e),
                                    onSelected: (value) {
                                      if (controller.contactsOptionList
                                          .contains(e)) {
                                        controller.contactsOptionList.remove(e);
                                      } else {
                                        controller.contactsOptionList.add(e);
                                        debugPrint(controller.contactsOptionList
                                            .toString());
                                      }
                                      controller.update();
                                    },
                                  ),
                                )
                                .toList()),
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: _controller,
                      children: const [
                        Text('balance'),
                        Text('History'),
                      ]),
                )
              ],
            ),
          ));
        });
  }
}
