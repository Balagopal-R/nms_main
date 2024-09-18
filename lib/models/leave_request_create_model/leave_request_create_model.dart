import 'dart:convert';

LeaveRequestCreateModel punchRequestModelFromJson(String str) => LeaveRequestCreateModel.fromJson(json.decode(str));

String punchRequestModelToJson(LeaveRequestCreateModel data) => json.encode(data.toJson());

class LeaveRequestCreateModel {
    String data;
    List<dynamic> warnings;

    LeaveRequestCreateModel({
        required this.data,
        required this.warnings,
    });

    factory LeaveRequestCreateModel.fromJson(Map<String, dynamic> json) => LeaveRequestCreateModel(
        data: json["data"],
        warnings: List<dynamic>.from(json["warnings"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "data": data,
        "warnings": List<dynamic>.from(warnings.map((x) => x)),
    };
}
