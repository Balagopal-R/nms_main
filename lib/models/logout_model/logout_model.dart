class LogoutModel {
    String data;
    List<dynamic> warnings;

    LogoutModel({
        required this.data,
        required this.warnings,
    });

    factory LogoutModel.fromJson(Map<String, dynamic> json) => LogoutModel(
        data: json["data"],
        warnings: List<dynamic>.from(json["warnings"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "data": data,
        "warnings": List<dynamic>.from(warnings.map((x) => x)),
    };
}
