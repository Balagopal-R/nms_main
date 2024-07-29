// To parse this JSON data, do
//
//     final punchRequestCancelModel = punchRequestCancelModelFromJson(jsonString);

import 'dart:convert';

PunchRequestCancelModel punchRequestCancelModelFromJson(String str) => PunchRequestCancelModel.fromJson(json.decode(str));

String punchRequestCancelModelToJson(PunchRequestCancelModel data) => json.encode(data.toJson());

class PunchRequestCancelModel {
    String data;
    List<dynamic> warnings;

    PunchRequestCancelModel({
        required this.data,
        required this.warnings,
    });

    factory PunchRequestCancelModel.fromJson(Map<String, dynamic> json) => PunchRequestCancelModel(
        data: json["data"],
        warnings: List<dynamic>.from(json["warnings"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "data": data,
        "warnings": List<dynamic>.from(warnings.map((x) => x)),
    };
}
