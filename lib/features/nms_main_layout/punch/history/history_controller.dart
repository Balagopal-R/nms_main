import 'package:get/get.dart';
import 'package:nms/mixins/snackbar_mixin.dart';

class HistoryController extends GetxController with SnackbarMixin {

final List<Map<String, dynamic>> weekData = [
    {'day': 'Sat', 'date': '11/05/2024', 'inTime': '09:00', 'outTime': '18:00', 'isLate': false},
    {'day': 'Sun', 'date': '12/05/2024', 'inTime': '09:00', 'outTime': '18:00', 'isLate': false},
    {'day': 'Mon', 'date': '13/05/2024', 'inTime': '09:00', 'outTime': '18:00', 'isLate': false},
    {'day': 'Tue', 'date': '14/05/2024', 'inTime': '09:20', 'outTime': '18:00', 'isLate': true},
    {'day': 'Wed', 'date': '15/05/2024', 'inTime': '08:50', 'outTime': '18:00', 'isLate': false},
    {'day': 'Thu', 'date': '16/05/2024', 'inTime': '09:00', 'outTime': '18:00', 'isLate': false},
    {'day': 'Fri', 'date': '17/05/2024', 'inTime': '09:00', 'outTime': '18:00', 'isLate': false},
  ];

}