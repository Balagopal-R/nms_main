import 'package:nms/dtos/api_response.dart';
import '../../../models/punch_line_model/punch_line_model.dart';

class PunchLineResponse extends ApiResponse {
  PunchLineResponse({message, status, data,errors})
      : super(message: message, status: status, data: data, errors: errors);

  factory PunchLineResponse.fromJson(Map<String, dynamic> json) =>
      PunchLineResponse(
        message: json["message"],
        status: json["status"],
        data: List<PunchLineModel>.from(
            json["data"].map((x) => PunchLineModel.fromJson(x))),

      );
}