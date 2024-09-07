import 'dart:convert';

LeaveRequestCancelModel punchRequestCancelModelFromJson(String str) => LeaveRequestCancelModel.fromJson(json.decode(str));

String punchRequestCancelModelToJson(LeaveRequestCancelModel data) => json.encode(data.toJson());

class LeaveRequestCancelModel {
    String data;
    List<dynamic> warnings;

    LeaveRequestCancelModel({
        required this.data,
        required this.warnings,
    });

    factory LeaveRequestCancelModel.fromJson(Map<String, dynamic> json) => LeaveRequestCancelModel(
        data: json["data"],
        warnings: List<dynamic>.from(json["warnings"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "data": data,
        "warnings": List<dynamic>.from(warnings.map((x) => x)),
    };
}
