import 'package:nms/dtos/api_response.dart';
import 'package:nms/models/get_employe_punch_time_model/get_employee_punch_time_model.dart';

class GetEmployePunchTimeResponse extends ApiResponse {
  GetEmployePunchTimeResponse({message, status, data, errors})
      : super(message: message, status: status, data: data, errors: errors);

  factory GetEmployePunchTimeResponse.fromJson(Map<String, dynamic> json) {
    return GetEmployePunchTimeResponse(
      message: json["message"],
      status: json["status"],
      data: List<GetEmployeePunchTimeModel>.from(
          json["data"].map((x) => GetEmployeePunchTimeModel.fromJson(x))),
      // data: GetEmployModel.fromJson(json["data"]),
      // data:json["data"] == null ? null : GetEmployeePunchTimeModel.fromJson(json["data"]),
    );
  }
}
