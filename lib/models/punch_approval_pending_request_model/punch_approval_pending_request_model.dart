class PunchApprovalPendingRequestModel {
    int id;
    String empId;
    String unitId;
    String orgId;
    int shiftDate;
    int punchInDatetime;
    int punchOutDatetime;
    String punchLocation;
    String reasonToChange;
    String status;
    int breakDateTime;
    int resumeDateTime;
    String shiftTime;
    List<Manager> managers;
    String departmentName;
    String? profileImgUrl;
    String workMobileNumber;
    String employeeCode;
    String firstName;
    String lastName;
    int createdAt;
    int updatedAt;
    AtedBy createdBy;
    AtedBy? updatedBy;
    List<PunchLog> punchLog;

    PunchApprovalPendingRequestModel({
        required this.id,
        required this.empId,
        required this.unitId,
        required this.orgId,
        required this.shiftDate,
        required this.punchInDatetime,
        required this.punchOutDatetime,
        required this.punchLocation,
        required this.reasonToChange,
        required this.status,
        required this.breakDateTime,
        required this.resumeDateTime,
        required this.shiftTime,
        required this.managers,
        required this.departmentName,
        this.profileImgUrl,
        required this.workMobileNumber,
        required this.employeeCode,
        required this.firstName,
        required this.lastName,
        required this.createdAt,
        required this.updatedAt,
        required this.createdBy,
        this.updatedBy,
        required this.punchLog,
    });

    factory PunchApprovalPendingRequestModel.fromJson(Map<String, dynamic> json) => PunchApprovalPendingRequestModel(
        id: json["id"],
        empId: json["empId"],
        unitId: json["unitId"],
        orgId: json["orgId"],
        shiftDate: json["shiftDate"],
        punchInDatetime: json["punchInDatetime"],
        punchOutDatetime: json["punchOutDatetime"],
        punchLocation: json["punchLocation"],
        reasonToChange: json["reasonToChange"],
        status: json["status"],
        breakDateTime: json["breakDateTime"],
        resumeDateTime: json["resumeDateTime"],
        shiftTime: json["shiftTime"],
        managers: List<Manager>.from(json["managers"].map((x) => Manager.fromJson(x))),
        departmentName: json["departmentName"],
        profileImgUrl: json["profileImgUrl"],
        workMobileNumber: json["workMobileNumber"],
        employeeCode: json["employeeCode"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        createdBy: AtedBy.fromJson(json["createdBy"]),
        updatedBy: AtedBy.fromJson(json["updatedBy"]),
        punchLog: List<PunchLog>.from(json["punchLog"].map((x) => PunchLog.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "empId": empId,
        "unitId": unitId,
        "orgId": orgId,
        "shiftDate": shiftDate,
        "punchInDatetime": punchInDatetime,
        "punchOutDatetime": punchOutDatetime,
        "punchLocation": punchLocation,
        "reasonToChange": reasonToChange,
        "status": status,
        "breakDateTime": breakDateTime,
        "resumeDateTime": resumeDateTime,
        "shiftTime": shiftTime,
        "managers": List<dynamic>.from(managers.map((x) => x.toJson())),
        "departmentName": departmentName,
        "profileImgUrl": profileImgUrl,
        "workMobileNumber": workMobileNumber,
        "employeeCode": employeeCode,
        "firstName": firstName,
        "lastName": lastName,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "createdBy": createdBy.toJson(),
        "updatedBy": updatedBy?.toJson(),
        "punchLog": List<dynamic>.from(punchLog.map((x) => x.toJson())),
    };
}

class AtedBy {
    String userId;
    String firstname;
    String lastname;

    AtedBy({
        required this.userId,
        required this.firstname,
        required this.lastname,
    });

    factory AtedBy.fromJson(Map<String, dynamic> json) => AtedBy(
        userId: json["userId"],
        firstname: json["firstname"],
        lastname: json["lastname"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "firstname": firstname,
        "lastname": lastname,
    };
}

class Department {
    int id;
    String departmentName;
    String departmentCode;

    Department({
        required this.id,
        required this.departmentName,
        required this.departmentCode,
    });

    factory Department.fromJson(Map<String, dynamic> json) => Department(
        id: json["id"],
        departmentName: json["departmentName"],
        departmentCode: json["departmentCode"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "departmentName": departmentName,
        "departmentCode": departmentCode,
    };
}

class Manager {
    int id;
    String userId;
    String firstname;
    String lastname;
    int probationPeriod;
    bool archived;

    Manager({
        required this.id,
        required this.userId,
        required this.firstname,
        required this.lastname,
        required this.probationPeriod,
        required this.archived,
    });

    factory Manager.fromJson(Map<String, dynamic> json) => Manager(
        id: json["id"],
        userId: json["userId"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        probationPeriod: json["probationPeriod"],
        archived: json["archived"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "firstname": firstname,
        "lastname": lastname,
        "probationPeriod": probationPeriod,
        "archived": archived,
    };
}

class PunchLog {
    String empId;
    String unitId;
    String orgId;
    int shiftDate;
    int punchInDateTime;
    int punchOutDateTime;
    String? punchLocation;
    String? description;
    String? reasonToChange;
    bool? isOnBreak;

    PunchLog({
        required this.empId,
        required this.unitId,
        required this.orgId,
        required this.shiftDate,
        required this.punchInDateTime,
        required this.punchOutDateTime,
        this.punchLocation,
        this.description,
        this.reasonToChange,
        this.isOnBreak,
    });

    factory PunchLog.fromJson(Map<String, dynamic> json) => PunchLog(
        empId: json["empId"],
        unitId: json["unitId"],
        orgId: json["orgId"],
        shiftDate: json["shiftDate"],
        punchInDateTime: json["punchInDateTime"],
        punchOutDateTime: json["punchOutDateTime"],
        punchLocation: json["punchLocation"],
        description: json["description"],
        reasonToChange: json["reasonToChange"],
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
        "description": description,
        "reasonToChange": reasonToChange,
        "isOnBreak": isOnBreak,
    };
}
