

import '../../../../models/login_screen/get_employee_model.dart';
import '../../../api_response.dart';

class GetEmployResponse extends ApiResponse {
  GetEmployResponse({message, status, data, errors})
      : super(message: message, status: status, data: data, errors: errors);

  factory GetEmployResponse.fromJson(Map<String, dynamic> json) {
    return GetEmployResponse(
      message: json["message"],
      status: json["status"],
      // data: List<CorporateDetails>.from(
      //     json["data"].map((x) => CorporateDetails.fromJson(x))),
      // data: GetEmployModel.fromJson(json["data"]),
      data:json["data"] == null ? null : EmployeeData.fromJson(json["data"]),
    );
  }
}
