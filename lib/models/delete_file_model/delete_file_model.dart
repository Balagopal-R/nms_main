// class DeleteFileModel {
//   dynamic code;
//   String status;
//   String message;

//   DeleteFileModel({
//     required this.code,
//     required this.status,
//     required this.message,
//   });

//   factory DeleteFileModel.fromJson(Map<String, dynamic> json) =>
//       DeleteFileModel(
//         code: json["code"],
//         status: json["status"],
//         message: json["message"],
//       );

//   Map<String, dynamic> toJson() => {
//         "code": code,
//         "status": status,
//         "message": message,
//       };
// }

class DeleteFileModel {
    String data;
    List<dynamic> warnings;

    DeleteFileModel({
        required this.data,
        required this.warnings,
    });

    factory DeleteFileModel.fromJson(Map<String, dynamic> json) => DeleteFileModel(
        data: json["data"],
        warnings: List<dynamic>.from(json["warnings"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "data": data,
        "warnings": List<dynamic>.from(warnings.map((x) => x)),
    };
}

