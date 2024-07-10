// To parse this JSON data, do
//
//     final punchInModel = punchInModelFromJson(jsonString);

import 'dart:convert';

PunchInModel punchInModelFromJson(String str) => PunchInModel.fromJson(json.decode(str));

String punchInModelToJson(PunchInModel data) => json.encode(data.toJson());

class PunchInModel {
    String data;
    List<dynamic> warnings;

    PunchInModel({
        required this.data,
        required this.warnings,
    });

    factory PunchInModel.fromJson(Map<String, dynamic> json) => PunchInModel(
        data: json["data"],
        warnings: List<dynamic>.from(json["warnings"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "data": data,
        "warnings": List<dynamic>.from(warnings.map((x) => x)),
    };
}
