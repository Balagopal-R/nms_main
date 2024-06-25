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
