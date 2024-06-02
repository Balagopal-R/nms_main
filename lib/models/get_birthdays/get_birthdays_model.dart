// To parse this JSON data, do
//
//     final getBirthdayModel = getBirthdayModelFromJson(jsonString);

import 'dart:convert';

GetBirthdayModel getBirthdayModelFromJson(String str) => GetBirthdayModel.fromJson(json.decode(str));

String getBirthdayModelToJson(GetBirthdayModel data) => json.encode(data.toJson());

class GetBirthdayModel {
    String timestamp;
    String requestId;
    int status;
    String message;
    List<Datum> data;
    List<dynamic> warnings;

    GetBirthdayModel({
        required this.timestamp,
        required this.requestId,
        required this.status,
        required this.message,
        required this.data,
        required this.warnings,
    });

    factory GetBirthdayModel.fromJson(Map<String, dynamic> json) => GetBirthdayModel(
        timestamp: json["timestamp"],
        requestId: json["requestId"],
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        warnings: List<dynamic>.from(json["warnings"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "timestamp": timestamp,
        "requestId": requestId,
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "warnings": List<dynamic>.from(warnings.map((x) => x)),
    };
}

class Datum {
    Employee employee;
    int birthDay;
    int daysToBirthday;

    Datum({
        required this.employee,
        required this.birthDay,
        required this.daysToBirthday,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        employee: Employee.fromJson(json["employee"]),
        birthDay: json["birthDay"],
        daysToBirthday: json["daysToBirthday"],
    );

    Map<String, dynamic> toJson() => {
        "employee": employee.toJson(),
        "birthDay": birthDay,
        "daysToBirthday": daysToBirthday,
    };
}

class Employee {
    int id;
    String userId;
    String firstname;
    String lastname;
    String? profileImgUrl;
    String? employeeCode;
    int probationPeriod;
    bool archived;

    Employee({
        required this.id,
        required this.userId,
        required this.firstname,
        required this.lastname,
        this.profileImgUrl,
        this.employeeCode,
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
