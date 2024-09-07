class GetLeaveYearByDateRequest {
  String userId;
  int leaveStartDate;
  int leaveEndDate;

  GetLeaveYearByDateRequest({
    required this.userId,
    required this.leaveStartDate,
    required this.leaveEndDate,
  });

  Map<String, dynamic> toBody() {
    final map = {
      "data": {
        "employee": {"userId": userId},
        "leaveStartDate": leaveStartDate,
        "leaveEndDate": leaveEndDate
      }
    };
    return map;
  }
}
