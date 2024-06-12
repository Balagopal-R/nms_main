import 'dart:convert';

GetAttendanceModel getAttendanceModelFromJson(String str) => GetAttendanceModel.fromJson(json.decode(str));

String getAttendanceModelToJson(GetAttendanceModel data) => json.encode(data.toJson());

class GetAttendanceModel {
    int data;
    List<dynamic> warnings;

    GetAttendanceModel({
        required this.data,
        required this.warnings,
    });

    factory GetAttendanceModel.fromJson(Map<String, dynamic> json) => GetAttendanceModel(
        data: json["data"],
        warnings: List<dynamic>.from(json["warnings"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "data": data,
        "warnings": List<dynamic>.from(warnings.map((x) => x)),
    };
}
