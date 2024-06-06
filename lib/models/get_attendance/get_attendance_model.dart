// To parse this JSON data, do
//
//     final getAttendanceModel = getAttendanceModelFromJson(jsonString);

import 'dart:convert';

GetAttendanceModel getAttendanceModelFromJson(String str) => GetAttendanceModel.fromJson(json.decode(str));

String getAttendanceModelToJson(GetAttendanceModel data) => json.encode(data.toJson());

class GetAttendanceModel {
    // String timestamp;
    // String requestId;
    // int status;
    // String message;
    int data;
    List<dynamic> warnings;

    GetAttendanceModel({
        // required this.timestamp,
        // required this.requestId,
        // required this.status,
        // required this.message,
        required this.data,
        required this.warnings,
    });

    factory GetAttendanceModel.fromJson(Map<String, dynamic> json) => GetAttendanceModel(
        // timestamp: json["timestamp"],
        // requestId: json["requestId"],
        // status: json["status"],
        // message: json["message"],
        data: json["data"],
        warnings: List<dynamic>.from(json["warnings"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        // "timestamp": timestamp,
        // "requestId": requestId,
        // "status": status,
        // "message": message,
        "data": data,
        "warnings": List<dynamic>.from(warnings.map((x) => x)),
    };
}
