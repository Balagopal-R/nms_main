import 'dart:io';

class FileUploadRequest {
  String userId;
  String category;
  File file;

  FileUploadRequest({required this.userId,required this.category, required this.file});

    Map<String, String> toMap() {
    final map = {
      'userId' : userId,
      'category' : category
    };
    return map;
  }

   File toBody() {
    return file;
  }

}