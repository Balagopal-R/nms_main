class DeleteFileByNameRequest {
  String fileName;

  DeleteFileByNameRequest({required this.fileName});

  Map<String, dynamic> toBody() {
    final map = {"data":[fileName]};
    return map;
  }
}