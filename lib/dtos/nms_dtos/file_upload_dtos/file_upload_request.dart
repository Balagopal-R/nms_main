import 'dart:io';

class FileUploadRequest {
  String userId;
  String category;
  File uploadfile;

  FileUploadRequest({required this.userId,required this.category, required this.uploadfile});

    Map<String, String> toMap() {
    final map = {
      'userId' : userId,
      'category' : category
    };
    return map;
  }

   File toBody() {
    return uploadfile;
  }

}