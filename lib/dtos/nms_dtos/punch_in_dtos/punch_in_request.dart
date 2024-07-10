class PunchInRequest {
  String empId;
  int punchInDateTime;
  String punchLocation;
  String projectCode;
  String task;
  String? description;
  bool isOnBreak;
  int shiftDate;

  PunchInRequest({required this.empId,required this.punchInDateTime, required this.punchLocation,
   required this.projectCode, required this.task,this.description,
   required this.isOnBreak,required this.shiftDate});

   Map<String, dynamic> toBody() {
    final map = {
      "data":{"empId": empId,
              "punchInDateTime": punchInDateTime,
              "punchLocation": punchLocation,
              "projectCode": projectCode,
              "task": task,
              "description": description,
              "isOnBreak": isOnBreak,
              "shiftDate": shiftDate}
      };
    return map;
  }

}