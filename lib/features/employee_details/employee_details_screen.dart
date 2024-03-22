import 'package:flutter/material.dart';
import 'package:nms/widgets/appbar_main_widget.dart';

import '../../utils/constants/constants.dart';
import '../../utils/utils.dart';

class EmployeeDetailsScreen extends StatelessWidget {
  const EmployeeDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appbarMain(context, 'Employee Details'),
        body: const Padding(
          padding: EdgeInsets.only(left: 24, right: 24, bottom: 16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 24,
                ),
                Center(
                  child: CircleAvatar(
                      radius: 44,
                      backgroundColor: Colors.blueGrey,
                      backgroundImage: AssetImage('assets/png/person.jpg')),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  ' Esther Howard',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  'NEO47',
                  style: TextStyle(
                      color: iconColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ),
                sizedBoxt28,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('Gender'), Text('Female')],
                ),
                sizedBoxt28,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('Blood Group'), Text('B+')],
                ),
                sizedBoxt28,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('Mobile no'), Text('9098745670')],
                ),
                sizedBoxt28,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('Email'), Text('esthar@gmail.com')],
                ),
                sizedBoxt28,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('Project'), Text('Kesher,JB')],
                ),
                sizedBoxt28,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('Buddy'), Text('John Doe')],
                ),
                sizedBoxt28,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('Manager'), Text('Sreenath')],
                ),
                sizedBoxt28,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('Work Mode'), Text('Work From Home')],
                ),
                sizedBoxt28,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('Designation'), Text('Full Stack Developer')],
                ),
                sizedBoxt28,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('Departent '), Text('Tech Department')],
                ),
                sizedBoxt28,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('Office Location'), Text('Kakkanad')],
                ),
                sizedBoxt28,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('Shift Time'), Text('09:00 - 18:00')],
                ),
                sizedBoxt28,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
