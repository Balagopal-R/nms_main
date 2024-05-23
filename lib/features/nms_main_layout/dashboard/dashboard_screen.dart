import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

 @override
Widget build(BuildContext context) {
  return Scaffold(
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: 
              
              Container(
                height: 100, 
                color: Colors.white,
                width: double.infinity,
                child: const Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Text(
              "You're Punched in",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w700),
            ),
          ),
                  Text('Text 2'),
                ],
              ),
              // Add other widgets in the column below if needed
              // Text('Another widget in the column'),
            ],
          ),
              ),
            ),



            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Container(
                height: 300, // Specify the height of the container
                color: Colors.green,
                width: double.infinity,
                child: Center(child: Text('Container 2')),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Container(
                height: 300, // Specify the height of the container
                color: Colors.blue,
                width: double.infinity,
                child: Center(child: Text('Container 3')),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

}