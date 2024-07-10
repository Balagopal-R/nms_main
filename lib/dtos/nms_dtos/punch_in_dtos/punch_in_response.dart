import 'package:nms/dtos/api_response.dart';

class PunchInResponse extends ApiResponse {
 PunchInResponse({message, status, data, errors})
      : super(message: message, status: status, data: data, errors: errors);

  factory PunchInResponse.fromJson(Map<String, dynamic> json) {
    return PunchInResponse(
      message: json["message"],
      status: json["status"],
      data: json["data"]
    );
  }
}
