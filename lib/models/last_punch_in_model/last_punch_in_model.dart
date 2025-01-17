class LastPunchInModel {
    String empId;
    String unitId;
    String orgId;
    String shiftDate;
    int punchInDateTime;
    int? punchOutDateTime;
    String punchLocation;
    String projectId;
    String taskId;
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
        required this.projectId,
        required this.taskId,
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
        projectId: json["projectId"],
        taskId: json["taskId"],
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
        "projectId": projectId,
        "taskId": taskId,
        "description": description,
        "isOnBreak": isOnBreak,
    };
}
