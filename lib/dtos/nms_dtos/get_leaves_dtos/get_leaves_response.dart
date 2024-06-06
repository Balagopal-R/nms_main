import 'package:nms/dtos/api_response.dart';
import 'package:nms/models/get_remaining_leaves/get_remaining_leaves_model.dart';

class GetLeavesResponse extends ApiResponse {
  GetLeavesResponse({message, status, data,errors})
      : super(message: message, status: status, data: data, errors: errors);

  factory GetLeavesResponse.fromJson(Map<String, dynamic> json) {
    return GetLeavesResponse(
      message: json["message"],
      status: json["status"],
      // data: List<CorporateDetails>.from(
      //     json["data"].map((x) => CorporateDetails.fromJson(x))),
      // data: GetEmployModel.fromJson(json["data"]),
      data:json["data"] == null ? null : GetRemainingLeavesModel.fromJson(json["data"]),
    );
  }
}