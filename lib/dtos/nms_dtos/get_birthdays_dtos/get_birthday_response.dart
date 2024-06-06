
import 'package:nms/models/get_birthdays/get_birthdays_model.dart';

import '../../api_response.dart';

class GetBirthdayResponse extends ApiResponse {
  GetBirthdayResponse({message, status, data,errors})
      : super(message: message, status: status, data: data, errors: errors);

  factory GetBirthdayResponse.fromJson(Map<String, dynamic> json) =>
      GetBirthdayResponse(
        message: json["message"],
      status: json["status"],
        data: List<GetBirthdayModel>.from(
            json["data"].map((x) => GetBirthdayModel.fromJson(x))),

            // data:json["data"] == null ? null : GetBirthdayModel.fromJson(json["data"]),
      );
}
