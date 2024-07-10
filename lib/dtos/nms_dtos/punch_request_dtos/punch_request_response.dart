import 'package:nms/dtos/api_response.dart';

class PunchRequestResponse extends ApiResponse {
 PunchRequestResponse({message, status, data, errors})
      : super(message: message, status: status, data: data, errors: errors);

  factory PunchRequestResponse.fromJson(Map<String, dynamic> json) {
    return PunchRequestResponse(
      message: json["message"],
      status: json["status"],
      data: json["data"]
    );
  }
}
