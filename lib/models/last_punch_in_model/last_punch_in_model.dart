class LastPunchInModel {
    String empId;
    String unitId;
    String orgId;
    int shiftDate;
    int punchInDateTime;
    int? punchOutDateTime;
    String punchLocation;
    String projectCode;
    String task;
    String description;
    bool isOnBreak;

    LastPunchInModel({
        required this.empId,
        required this.unitId,
        required this.orgId,
        required this.shiftDate,
        required this.punchInDateTime,
        this.punchOutDateTime,
        required this.punchLocation,
        required this.projectCode,
        required this.task,
        required this.description,
        required this.isOnBreak,
    });

    factory LastPunchInModel.fromJson(Map<String, dynamic> json) => LastPunchInModel(
        empId: json["empId"],
        unitId: json["unitId"],
        orgId: json["orgId"],
        shiftDate: json["shiftDate"],
        punchInDateTime: json["punchInDateTime"],
        punchOutDateTime: json["punchOutDateTime"],
        punchLocation: json["punchLocation"],
        projectCode: json["projectCode"],
        task: json["task"],
        description: json["description"],
        isOnBreak: json["isOnBreak"],
    );

    Map<String, dynamic> toJson() => {
        "empId": empId,
        "unitId": unitId,
        "orgId": orgId,
        "shiftDate": shiftDate,
        "punchInDateTime": punchInDateTime,
        "punchOutDateTime": punchOutDateTime,
        "punchLocation": punchLocation,
        "projectCode": projectCode,
        "task": task,
        "description": description,
        "isOnBreak": isOnBreak,
    };
}
