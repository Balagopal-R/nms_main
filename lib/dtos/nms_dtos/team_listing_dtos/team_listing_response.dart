import 'package:nms/dtos/api_response.dart';
import 'package:nms/models/team_list_model/team_list_model.dart';

class TeamListingResponse extends ApiResponse {
  TeamListingResponse({message, status, data,errors})
      : super(message: message, status: status, data: data, errors: errors);

  factory TeamListingResponse.fromJson(Map<String, dynamic> json) {
    return TeamListingResponse(
      message: json["message"],
      status: json["status"],
      data: List<TeamListingModel>.from(
          json["data"].map((x) => TeamListingModel.fromJson(x))),
    );
  }
}