import '../../../models/file_upload_model/file_upload_model.dart';
import '../../api_response.dart';

class FileUploadResponse extends ApiResponse {
  FileUploadResponse({message, status, data,errors})
      : super(message: message, status: status, data: data, errors: errors);

  factory FileUploadResponse.fromJson(Map<String, dynamic> json) {
    return FileUploadResponse(
      message: json["message"],
      status: json["status"],
      data:json["data"] == null ? null : FileUploadModel.fromJson(json["data"]),
    );
  }
}
