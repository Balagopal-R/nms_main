import 'package:nms/dtos/api_response.dart';
import 'package:nms/models/get_remaining_leaves/get_remaining_leaves_model.dart';

class GetLeavesResponse extends ApiResponse {
  GetLeavesResponse({message, status, data,errors, pagination})
      : super(message: message, status: status, data: data, errors: errors, pagination: pagination);

  factory GetLeavesResponse.fromJson(Map<String, dynamic> json) {
    return GetLeavesResponse(
      message: json["message"],
      status: json["status"],
      data: List<GetRemainingLeavesModel>.from(
          json["data"].map((x) => GetRemainingLeavesModel.fromJson(x))),
      pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
    );
  }
}