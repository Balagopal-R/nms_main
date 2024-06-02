// // To parse this JSON data, do
// //
// //     final getEmployeeDashboard = getEmployeeDashboardFromJson(jsonString);

// // import 'dart:convert';

// // GetEmployeeDashboard getEmployeeDashboardFromJson(String str) => GetEmployeeDashboard.fromJson(json.decode(str));

// // String getEmployeeDashboardToJson(GetEmployeeDashboard data) => json.encode(data.toJson());

// class GetEmployeeDashboard {
//     String timestamp;
//     String requestId;
//     int status;
//     String message;
//     List<Datum> data;
//     List<dynamic> warnings;

//     GetEmployeeDashboard({
//         required this.timestamp,
//         required this.requestId,
//         required this.status,
//         required this.message,
//         required this.data,
//         required this.warnings,
//     });

//     factory GetEmployeeDashboard.fromJson(Map<String, dynamic> json) => GetEmployeeDashboard(
//         timestamp: json["timestamp"],
//         requestId: json["requestId"],
//         status: json["status"],
//         message: json["message"],
//         data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
//         warnings: List<dynamic>.from(json["warnings"].map((x) => x)),
//     );

//     Map<String, dynamic> toJson() => {
//         "timestamp": timestamp,
//         "requestId": requestId,
//         "status": status,
//         "message": message,
//         "data": List<dynamic>.from(data.map((x) => x.toJson())),
//         "warnings": List<dynamic>.from(warnings.map((x) => x)),
//     };
// }

class GetEmployeePunchTime {
    int startDate;
    int endDate;
    int day;
    int clockedWorkingMinutes;
    int clockedBreakMinutes;

    GetEmployeePunchTime({
        required this.startDate,
        required this.endDate,
        required this.day,
        required this.clockedWorkingMinutes,
        required this.clockedBreakMinutes,
    });

    factory GetEmployeePunchTime.fromJson(Map<String, dynamic> json) => GetEmployeePunchTime(
        startDate: json["startDate"],
        endDate: json["endDate"],
        day: json["day"],
        clockedWorkingMinutes: json["clockedWorkingMinutes"],
        clockedBreakMinutes: json["clockedBreakMinutes"],
    );

    Map<String, dynamic> toJson() => {
        "startDate": startDate,
        "endDate": endDate,
        "day": day,
        "clockedWorkingMinutes": clockedWorkingMinutes,
        "clockedBreakMinutes": clockedBreakMinutes,
    };
}
