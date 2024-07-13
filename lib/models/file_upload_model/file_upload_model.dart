class FileUploadModel {
    int id;
    String userId;
    String displayName;
    String fileName;
    String fileUrl;
    String fileType;
    String category;
    int size;
    int createdAt;

    FileUploadModel({
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

    factory FileUploadModel.fromJson(Map<String, dynamic> json) => FileUploadModel(
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
