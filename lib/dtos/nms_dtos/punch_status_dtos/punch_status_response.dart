import 'package:nms/dtos/api_response.dart';
import 'package:nms/models/punch_status/punch_status_model.dart';

class PunchStatusResponse extends ApiResponse {
  PunchStatusResponse({message, status, data, errors})
      : super(message: message, status: status, data: data, errors: errors);

  factory PunchStatusResponse.fromJson(Map<String, dynamic> json) =>
      PunchStatusResponse(
          message: json["message"],
          status: json["status"],
          // data: List<PunchStatusModel>.from(
          //     json["data"].map((x) => PunchStatusModel.fromJson(x))),

          data: json["data"]
          // == null ? null : PunchStatusModel.fromJson(json["data"]),
          );
}
