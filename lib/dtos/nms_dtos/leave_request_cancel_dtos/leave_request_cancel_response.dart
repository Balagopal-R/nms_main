import 'package:nms/dtos/api_response.dart';

class LeaveRequestCancelResponse extends ApiResponse {
 LeaveRequestCancelResponse({message, status, data, errors})
      : super(message: message, status: status, data: data, errors: errors);

  factory LeaveRequestCancelResponse.fromJson(Map<String, dynamic> json) {
    return LeaveRequestCancelResponse(
      message: json["message"],
      status: json["status"],
      data: json["data"]
    );
  }
}
