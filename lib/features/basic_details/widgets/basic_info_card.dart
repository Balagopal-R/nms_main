import 'package:flutter/material.dart';

import '../../../utils/utils.dart';

class BasicInfoCard extends StatelessWidget {
  const BasicInfoCard({
    super.key,
    required this.mobileNumber,
    required this.email,
    required this.joiningDate,
  });

  final String mobileNumber;
  final String email;
  final String joiningDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: secondaryTextColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [const Text('Mobile No.',style: TextStyle(color: Color(0xff7A7A7A),fontSize: 12,fontWeight: FontWeight.w500),), 
              Text(mobileNumber,style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.w500),)],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [const Text('Email',style: TextStyle(color: Color(0xff7A7A7A),fontSize: 12,fontWeight: FontWeight.w500),), 
              Text(email,style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.w500),)],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [const Text('Joining Date',style: TextStyle(color: Color(0xff7A7A7A),fontSize: 12,fontWeight: FontWeight.w500),), 
              Text(joiningDate,style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.w500),)],
            ),
          )
        ],
      ),
    );
  }
}
