import 'package:nms/dtos/api_response.dart';
import 'package:nms/models/punch_approvals_model/punch_approvals_model.dart';

class PunchApprovalsResponse extends ApiResponse {
  PunchApprovalsResponse({message, status, data,errors, pagination})
      : super(message: message, status: status, data: data, errors: errors, pagination: pagination);

  factory PunchApprovalsResponse.fromJson(Map<String, dynamic> json) {
    return PunchApprovalsResponse(
      message: json["message"],
      status: json["status"],
      data: List<PunchApprovalsModel>.from(
          json["data"].map((x) => PunchApprovalsModel.fromJson(x))),
      pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
    );
  }
}