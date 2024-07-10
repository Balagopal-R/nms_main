import 'package:nms/dtos/api_response.dart';

class PunchOutResponse extends ApiResponse {
 PunchOutResponse({message, status, data, errors})
      : super(message: message, status: status, data: data, errors: errors);

  factory PunchOutResponse.fromJson(Map<String, dynamic> json) {
    return PunchOutResponse(
      message: json["message"],
      status: json["status"],
      data: json["data"]
    );
  }
}
