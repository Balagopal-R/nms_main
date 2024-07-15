class PunchRequestRequest {
  String empId;
  int shiftDate;
  String punchLocation;
  int punchInDateTime;
  int punchOutDateTime;
  int breakDateTime;
  int resumeDateTime;
  bool isOnBreak;
  String? projectCode;
  String? task;
  String? description;
  String? reasonToChange;

  PunchRequestRequest({required this.empId,required this.shiftDate,required this.punchInDateTime,
                       required this.punchOutDateTime,required this.breakDateTime,required this.resumeDateTime, 
                       required this.punchLocation,this.projectCode,this.task,this.description,
                       this.reasonToChange,required this.isOnBreak});

   Map<String, dynamic> toBody() {
    final map = {
      "data":{
               "empId": empId,
               "shiftDate": shiftDate,
               "punchInDateTime": punchInDateTime,
               "punchOutDateTime": punchOutDateTime,
               "breakDateTime": breakDateTime,
               "resumeDateTime": resumeDateTime,
               "punchLocation": punchLocation,
               "projectCode": projectCode,
               "task": task,
               "description": description,
               "reasonToChange": reasonToChange,
               "isOnBreak" : isOnBreak,
                }
      };
    return map;
  }

}