import 'package:nms/dtos/api_response.dart';

class PunchRequestCancelResponse extends ApiResponse {
 PunchRequestCancelResponse({message, status, data, errors})
      : super(message: message, status: status, data: data, errors: errors);

  factory PunchRequestCancelResponse.fromJson(Map<String, dynamic> json) {
    return PunchRequestCancelResponse(
      message: json["message"],
      status: json["status"],
      data: json["data"]
    );
  }
}
