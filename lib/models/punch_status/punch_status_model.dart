// To parse this JSON data, do
//
//     final punchStatusModel = punchStatusModelFromJson(jsonString);

// import 'dart:convert';

// PunchStatusModel punchStatusModelFromJson(String str) => PunchStatusModel.fromJson(json.decode(str));

// String punchStatusModelToJson(PunchStatusModel data) => json.encode(data.toJson());

class PunchStatusModel {
    // String timestamp;
    // String requestId;
    // int status;
    // String message;
    String data;
    List<dynamic> warnings;

    PunchStatusModel({
        // required this.timestamp,
        // required this.requestId,
        // required this.status,
        // required this.message,
        required this.data,
        required this.warnings,
    });

    factory PunchStatusModel.fromJson(Map<String, dynamic> json) => PunchStatusModel(
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
