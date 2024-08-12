class FileDownloadRequest {
  String fileName;

  FileDownloadRequest({required this.fileName});

    Map<String, String> toMap() {
    final map = {
      'fileName' : fileName,
    };
    return map;
  }

}