import 'dart:convert';

PunchRequestModel punchRequestModelFromJson(String str) => PunchRequestModel.fromJson(json.decode(str));

String punchRequestModelToJson(PunchRequestModel data) => json.encode(data.toJson());

class PunchRequestModel {
    String data;
    List<dynamic> warnings;

    PunchRequestModel({
        required this.data,
        required this.warnings,
    });

    factory PunchRequestModel.fromJson(Map<String, dynamic> json) => PunchRequestModel(
        data: json["data"],
        warnings: List<dynamic>.from(json["warnings"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "data": data,
        "warnings": List<dynamic>.from(warnings.map((x) => x)),
    };
}
