import 'package:nms/dtos/api_response.dart';

class DeleteFileByNameResponse extends ApiResponse {
  DeleteFileByNameResponse({code, status, message, data, errors})
      : super(
            status: status,
            message: message,
            data: data,
            errors: errors);

  factory DeleteFileByNameResponse.fromJson(Map<String, dynamic> json) {
    return DeleteFileByNameResponse(
      status: json["status"],
      message: json["message"],
      data: json["data"]
    );
  }
}