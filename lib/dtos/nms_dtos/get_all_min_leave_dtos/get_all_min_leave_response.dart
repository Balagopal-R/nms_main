import 'package:nms/dtos/api_response.dart';
import 'package:nms/models/get_all_min_leave_model/get_all_min_leave_model.dart';

class GetAllMinLeaveResponse extends ApiResponse {
  GetAllMinLeaveResponse({message, status, data,errors})
      : super(message: message, status: status, data: data, errors: errors);

  factory GetAllMinLeaveResponse.fromJson(Map<String, dynamic> json) {
    return GetAllMinLeaveResponse(
      message: json["message"],
      status: json["status"],
      data: List<GetAllMinLeaveModel>.from(
          json["data"].map((x) => GetAllMinLeaveModel.fromJson(x))),
    );
  }
}