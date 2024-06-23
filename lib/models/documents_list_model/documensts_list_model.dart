// // To parse this JSON data, do
// //
// //     final documentsListModel = documentsListModelFromJson(jsonString);

// import 'dart:convert';

// DocumentsListModel documentsListModelFromJson(String str) => DocumentsListModel.fromJson(json.decode(str));

// String documentsListModelToJson(DocumentsListModel data) => json.encode(data.toJson());

// class DocumentsListModel {
//     String timestamp;
//     String requestId;
//     int status;
//     String message;
//     List<Datum> data;
//     Pagination pagination;
//     List<dynamic> warnings;

//     DocumentsListModel({
//         required this.timestamp,
//         required this.requestId,
//         required this.status,
//         required this.message,
//         required this.data,
//         required this.pagination,
//         required this.warnings,
//     });

//     factory DocumentsListModel.fromJson(Map<String, dynamic> json) => DocumentsListModel(
//         timestamp: json["timestamp"],
//         requestId: json["requestId"],
//         status: json["status"],
//         message: json["message"],
//         data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
//         pagination: Pagination.fromJson(json["pagination"]),
//         warnings: List<dynamic>.from(json["warnings"].map((x) => x)),
//     );

//     Map<String, dynamic> toJson() => {
//         "timestamp": timestamp,
//         "requestId": requestId,
//         "status": status,
//         "message": message,
//         "data": List<dynamic>.from(data.map((x) => x.toJson())),
//         "pagination": pagination.toJson(),
//         "warnings": List<dynamic>.from(warnings.map((x) => x)),
//     };
// }

class DocumentsListModel {
    int id;
    String userId;
    String displayName;
    String fileName;
    String fileUrl;
    String fileType;
    String category;
    int size;
    int createdAt;

    DocumentsListModel({
        required this.id,
        required this.userId,
        required this.displayName,
        required this.fileName,
        required this.fileUrl,
        required this.fileType,
        required this.category,
        required this.size,
        required this.createdAt,
    });

    factory DocumentsListModel.fromJson(Map<String, dynamic> json) => DocumentsListModel(
        id: json["id"],
        userId: json["userId"],
        displayName: json["displayName"],
        fileName: json["fileName"],
        fileUrl: json["fileUrl"],
        fileType: json["fileType"],
        category: json["category"],
        size: json["size"],
        createdAt: json["createdAt"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "displayName": displayName,
        "fileName": fileName,
        "fileUrl": fileUrl,
        "fileType": fileType,
        "category": category,
        "size": size,
        "createdAt": createdAt,
    };
}

class Pagination {
    int totalPages;
    int totalElements;
    int currentPage;
    int pageSize;

    Pagination({
        required this.totalPages,
        required this.totalElements,
        required this.currentPage,
        required this.pageSize,
    });

    factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        totalPages: json["totalPages"],
        totalElements: json["totalElements"],
        currentPage: json["currentPage"],
        pageSize: json["pageSize"],
    );

    Map<String, dynamic> toJson() => {
        "totalPages": totalPages,
        "totalElements": totalElements,
        "currentPage": currentPage,
        "pageSize": pageSize,
    };
}
