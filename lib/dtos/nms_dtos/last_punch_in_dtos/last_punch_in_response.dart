import 'package:nms/dtos/api_response.dart';
import 'package:nms/models/last_punch_in_model/last_punch_in_model.dart';

class LastPunchInResponse extends ApiResponse {
  LastPunchInResponse({message, status, data,errors})
      : super(message: message, status: status, data: data, errors: errors);

  factory LastPunchInResponse.fromJson(Map<String, dynamic> json) {
    return LastPunchInResponse(
      message: json["message"],
      status: json["status"],
      // data: List<CorporateDetails>.from(
      //     json["data"].map((x) => CorporateDetails.fromJson(x))),
      // data: GetEmployModel.fromJson(json["data"]),
      data:json["data"] == null ? null : LastPunchInModel.fromJson(json["data"]),
    );
  }
}
