import 'package:flutter/material.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      // decoration: const BoxDecoration(color: Colors.white),
      child: const Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text('Date'), Text('Pending')],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text('01 mar 2024 - '), Text('02 mar 2024')],
          ),
          Divider(),
          Row(
            
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text('Leave Type'), Text('Casual/Half Day')],
              ),
              SizedBox(width: 28,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text('Applied'), Text('Feb 21 2024')],
              )
            ],
          ),
          Text('Approved by'),
        ],
      ),
    );
  }
}
