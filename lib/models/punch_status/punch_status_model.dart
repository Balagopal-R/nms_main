class PunchStatusModel {
    String data;
    List<dynamic> warnings;

    PunchStatusModel({
        required this.data,
        required this.warnings,
    });

    factory PunchStatusModel.fromJson(Map<String, dynamic> json) => PunchStatusModel(
        data: json["data"],
        warnings: List<dynamic>.from(json["warnings"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "data": data,
        "warnings": List<dynamic>.from(warnings.map((x) => x)),
    };
}
