import 'package:nms/dtos/api_response.dart';
import 'package:nms/models/get_employe_punch_time/get_employee_punch_time.dart';

class GetEmployePunchTimeResponse extends ApiResponse {
  GetEmployePunchTimeResponse({message, status, data, errors})
      : super(message: message, status: status, data: data, errors: errors);

  factory GetEmployePunchTimeResponse.fromJson(Map<String, dynamic> json) {
    return GetEmployePunchTimeResponse(
      message: json["message"],
      status: json["status"],
      // data: List<CorporateDetails>.from(
      //     json["data"].map((x) => CorporateDetails.fromJson(x))),
      // data: GetEmployModel.fromJson(json["data"]),
      data:json["data"] == null ? null : GetEmployeePunchTime.fromJson(json["data"]),
    );
  }
}
