import 'dart:convert';

PunchOutModel punchOutModelFromJson(String str) => PunchOutModel.fromJson(json.decode(str));

String punchOutModelToJson(PunchOutModel data) => json.encode(data.toJson());

class PunchOutModel {
    String data;
    List<dynamic> warnings;

    PunchOutModel({
        required this.data, 
        required this.warnings,
    });

    factory PunchOutModel.fromJson(Map<String, dynamic> json) => PunchOutModel(
        data: json["data"],
        warnings: List<dynamic>.from(json["warnings"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "data": data,
        "warnings": List<dynamic>.from(warnings.map((x) => x)),
    };
}
