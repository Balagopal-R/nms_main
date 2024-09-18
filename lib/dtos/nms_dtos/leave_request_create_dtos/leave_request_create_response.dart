import 'package:nms/dtos/api_response.dart';

class LeaveRequestCreateResponse extends ApiResponse {
 LeaveRequestCreateResponse({message, status, data, errors})
      : super(message: message, status: status, data: data, errors: errors);

  factory LeaveRequestCreateResponse.fromJson(Map<String, dynamic> json) {
    return LeaveRequestCreateResponse(
      message: json["message"],
      status: json["status"],
      data: json["data"]
    );
  }
}
