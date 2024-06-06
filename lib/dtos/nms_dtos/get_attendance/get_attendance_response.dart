import 'package:nms/dtos/api_response.dart';
import 'package:nms/models/get_attendance/get_attendance_model.dart';

class GetEmployeAttendanceResponse extends ApiResponse {
 GetEmployeAttendanceResponse({message, status, data, errors})
      : super(message: message, status: status, data: data, errors: errors);

  factory GetEmployeAttendanceResponse.fromJson(Map<String, dynamic> json) {
    return GetEmployeAttendanceResponse(
      message: json["message"],
      status: json["status"],
      data: json["data"]
      // data: List<CorporateDetails>.from(
      //     json["data"].map((x) => CorporateDetails.fromJson(x))),
      // data: GetEmployModel.fromJson(json["data"]),
      // data:json["data"] == null ? null : GetAttendanceModel.fromJson(json["data"]),
    );
  }
}
