// To parse this JSON data, do
//
//     final getLeaveYearByLeaveDateModel = getLeaveYearByLeaveDateModelFromJson(jsonString);

import 'dart:convert';

GetLeaveYearByLeaveDateModel getLeaveYearByLeaveDateModelFromJson(String str) => GetLeaveYearByLeaveDateModel.fromJson(json.decode(str));

String getLeaveYearByLeaveDateModelToJson(GetLeaveYearByLeaveDateModel data) => json.encode(data.toJson());

class GetLeaveYearByLeaveDateModel {
    String timestamp;
    String requestId;
    int status;
    String message;
    List<dynamic> data;
    List<dynamic> warnings;

    GetLeaveYearByLeaveDateModel({
        required this.timestamp,
        required this.requestId,
        required this.status,
        required this.message,
        required this.data,
        required this.warnings,
    });

    factory GetLeaveYearByLeaveDateModel.fromJson(Map<String, dynamic> json) => GetLeaveYearByLeaveDateModel(
        timestamp: json["timestamp"],
        requestId: json["requestId"],
        status: json["status"],
        message: json["message"],
        data: List<dynamic>.from(json["data"].map((x) => x)),
        warnings: List<dynamic>.from(json["warnings"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "timestamp": timestamp,
        "requestId": requestId,
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x)),
        "warnings": List<dynamic>.from(warnings.map((x) => x)),
    };
}
