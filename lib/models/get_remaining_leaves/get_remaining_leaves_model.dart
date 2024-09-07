class GetRemainingLeavesModel {
    Employee employee;
    double balanceLeaves;
    double takenLeaves;
    double totalLeaves;
    String leaveTypeName;
    int leaveTypeId;
    String nameAbbr;

    GetRemainingLeavesModel({
        required this.employee,
        required this.balanceLeaves,
        required this.takenLeaves,
        required this.totalLeaves,
        required this.leaveTypeName,
        required this.leaveTypeId,
        required this.nameAbbr
    });

    factory GetRemainingLeavesModel.fromJson(Map<String, dynamic> json) => GetRemainingLeavesModel(
        employee: Employee.fromJson(json["employee"]),
        balanceLeaves: json["balanceLeaves"],
        takenLeaves: json["takenLeaves"],
        totalLeaves: json["totalLeaves"],
        leaveTypeName: json["leaveTypeName"],
        leaveTypeId: json["leaveTypeId"],
        nameAbbr: json["nameAbbr"],
    );

    Map<String, dynamic> toJson() => {
        "employee": employee.toJson(),
        "balanceLeaves": balanceLeaves,
        "takenLeaves": takenLeaves,
        "totalLeaves": totalLeaves,
        "leaveTypeName": leaveTypeName,
        "leaveTypeId": leaveTypeId,
        "nameAbbr": nameAbbr,
    };
}

class Employee {
    int id;
    String userId;
    String firstname;
    String lastname;
    String profileImgUrl;
    String employeeCode;
    int probationPeriod;
    bool archived;

    Employee({
        required this.id,
        required this.userId,
        required this.firstname,
        required this.lastname,
        required this.profileImgUrl,
        required this.employeeCode,
        required this.probationPeriod,
        required this.archived,
    });

    factory Employee.fromJson(Map<String, dynamic> json) => Employee(
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