import '../../api_response.dart';

class LogoutResponse extends ApiResponse {
 LogoutResponse({message, status, data, errors})
      : super(message: message, status: status, data: data, errors: errors);

  factory LogoutResponse.fromJson(Map<String, dynamic> json) {
    return LogoutResponse(
      message: json["message"],
      status: json["status"],
      data: json["data"]
    );
  }
}