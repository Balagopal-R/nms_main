import 'package:nms/dtos/api_response.dart';
import 'package:nms/models/leave_approvals_model/leave_approvals_model.dart';

class LeaveApprovalsResponse extends ApiResponse {
  LeaveApprovalsResponse({message, status, data,errors, pagination})
      : super(message: message, status: status, data: data, errors: errors, pagination: pagination);

  factory LeaveApprovalsResponse.fromJson(Map<String, dynamic> json) {
    return LeaveApprovalsResponse(
      message: json["message"],
      status: json["status"],
      data: List<LeaveApprovalsModel>.from(
          json["data"].map((x) => LeaveApprovalsModel.fromJson(x))),
      pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
    );
  }
}