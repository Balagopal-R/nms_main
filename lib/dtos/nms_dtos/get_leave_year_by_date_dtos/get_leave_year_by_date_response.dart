import 'package:nms/dtos/api_response.dart';
import 'package:nms/models/get_leave_year_by_date_model/get_leave_year_by_date_model.dart';

class GetLeaveYearByDateResponse extends ApiResponse {
  GetLeaveYearByDateResponse({message, status, data,errors})
      : super(message: message, status: status, data: data, errors: errors);

  factory GetLeaveYearByDateResponse.fromJson(Map<String, dynamic> json) {
    return GetLeaveYearByDateResponse(
      message: json["message"],
      status: json["status"],
      data: List<GetLeaveYearByLeaveDateModel>.from(
          json["data"].map((x) => GetLeaveYearByLeaveDateModel.fromJson(x))),
    );
  }
}