class LeaveApprovalsModel {
    int id;
    CreatedBy employee;
    String duration;
    LeaveType leaveType;
    double lengthOfLeave;
    String leaveStartDate;
    String leaveEndDate;
    String comments;
    String status;
    int createdAt;
    int updatedAt;
    List<dynamic>? leaveDocuments;
    CreatedBy createdBy;
    CreatedBy updatedBy;

    LeaveApprovalsModel({
        required this.id,
        required this.employee,
        required this.duration,
        required this.leaveType,
        required this.lengthOfLeave,
        required this.leaveStartDate,
        required this.leaveEndDate,
        required this.comments,
        required this.status,
        required this.createdAt,
        required this.updatedAt,
        this.leaveDocuments,
        required this.createdBy,
        required this.updatedBy,
    });

    factory LeaveApprovalsModel.fromJson(Map<String, dynamic> json) => LeaveApprovalsModel(
        id: json["id"],
        employee: CreatedBy.fromJson(json["employee"]),
        duration: json["duration"],
        leaveType: LeaveType.fromJson(json["leaveType"]),
        lengthOfLeave: json["lengthOfLeave"],
        leaveStartDate: json["leaveStartDate"],
        leaveEndDate: json["leaveEndDate"],
        comments: json["comments"],
        status: json["status"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        leaveDocuments: json["leaveDocuments"] == null ? [] : List<dynamic>.from(json["leaveDocuments"]!.map((x) => x)),
        createdBy: CreatedBy.fromJson(json["createdBy"]),
        updatedBy: CreatedBy.fromJson(json["updatedBy"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "employee": employee.toJson(),
        "duration": duration,
        "leaveType": leaveType.toJson(),
        "lengthOfLeave": lengthOfLeave,
        "leaveStartDate": leaveStartDate,
        "leaveEndDate": leaveEndDate,
        "comments": comments,
        "status": status,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "leaveDocuments": leaveDocuments == null ? [] : List<dynamic>.from(leaveDocuments!.map((x) => x)),
        "createdBy": createdBy.toJson(),
        "updatedBy": updatedBy.toJson(),
    };
}

class CreatedBy {
    int id;
    String userId;
    String firstname;
    String lastname;
    String? profileImgUrl;
    String? employeeCode;
    int probationPeriod;
    bool archived;

    CreatedBy({
        required this.id,
        required this.userId,
        required this.firstname,
        required this.lastname,
        this.profileImgUrl,
        this.employeeCode,
        required this.probationPeriod,
        required this.archived,
    });

    factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
        id: json["id"],
        userId: json["userId"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        profileImgUrl: json["profileImgUrl"],
        employeeCode: json["employeeCode"],
        probationPeriod: json["probationPeriod"],
        archived: json["archived"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "firstname": firstname,
        "lastname": lastname,
        "profileImgUrl": profileImgUrl,
        "employeeCode": employeeCode,
        "probationPeriod": probationPeriod,
        "archived": archived,
    };
}

class LeaveType {
    int id;
    String name;
    LeaveYear leaveYear;

    LeaveType({
        required this.id,
        required this.name,
        required this.leaveYear,
    });

    factory LeaveType.fromJson(Map<String, dynamic> json) => LeaveType(
        id: json["id"],
        name: json["name"],
        leaveYear: LeaveYear.fromJson(json["leaveYear"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "leaveYear": leaveYear.toJson(),
    };
}

class LeaveYear {
    String year;
    String leaveYearName;
    int startMonth;

    LeaveYear({
        required this.year,
        required this.leaveYearName,
        required this.startMonth,
    });

    factory LeaveYear.fromJson(Map<String, dynamic> json) => LeaveYear(
        year: json["year"],
        leaveYearName: json["leaveYearName"],
        startMonth: json["startMonth"],
    );

    Map<String, dynamic> toJson() => {
        "year": year,
        "leaveYearName": leaveYearName,
        "startMonth": startMonth,
    };
}
