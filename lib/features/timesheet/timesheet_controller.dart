import 'package:get/get.dart';
import 'package:nms/mixins/snackbar_mixin.dart';

class TimesheetController extends GetxController with SnackbarMixin {

  final List<String> daysOfWeek = ["M", "T", "W", "T", "F","S", "S",];
  final List<double> dateProgress = [0.7, 0.5, 0.8, 0.6, 0.0, 0.0, 0.0]; 
  final List<String> date = ['11', '12', '13', '14', '15', '16', '17']; 
  int selectedDayIndex = 3;
  final String todayDate = '14'; // Define today's date

  final List<Map<String, String>> tasks = [
    {
      'startTime': '09:00',
      'title': 'NMS',
      'description': 'NMS Mobile bug fix..',
      'endTime': '01:00',
    },
    {
      'startTime': '10:00',
      'title': 'Winemonger',
      'description': 'Winemonger issu..',
      'endTime': '02:30',
    },
     {
      'startTime': '12:30',
      'title': 'Quotely',
      'description': 'Backend Integart..',
      'endTime': '00:30',
    },
    
  ];

  updateUserSelectDay(int index)
  {
    selectedDayIndex = index; // Update selected day
    update();
  }

}