class PunchOutRequest {
  String empId;
  int punchOutDateTime;
  String punchLocation;
  String projectCode;
  String task;
  String? description;
  bool isOnBreak;
  int shiftDate;

  PunchOutRequest({required this.empId,required this.punchOutDateTime, required this.punchLocation,
   required this.projectCode, required this.task,this.description,
   required this.isOnBreak,required this.shiftDate});

   Map<String, dynamic> toBody() {
    final map = {
      "data":{"empId": empId,
              "punchInDateTime": punchOutDateTime,
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