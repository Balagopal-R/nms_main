class GetEmployeAttendance {
  String userId;

  GetEmployeAttendance({required this.userId});

  dynamic toMap() {
    return userId;
  }
}


//    Map<String, dynamic> toBody() {
//     final map = {
//     "data": {
//         "userId": userId,
//         "startDate": startDate,
//         "endDate": endDate
//     }

// };
//     return map;
//   }

