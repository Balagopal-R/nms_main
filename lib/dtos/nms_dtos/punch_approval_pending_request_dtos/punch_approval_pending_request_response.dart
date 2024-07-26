import 'package:nms/dtos/api_response.dart';
import '../../../models/punch_approval_pending_request_model/punch_approval_pending_request_model.dart';

class PunchApprovalPendingResponse extends ApiResponse {
  PunchApprovalPendingResponse({message, status, data,errors})
      : super(message: message, status: status, data: data, errors: errors);

  factory PunchApprovalPendingResponse.fromJson(Map<String, dynamic> json) {
    return PunchApprovalPendingResponse(
      message: json["message"],
      status: json["status"],
      // data: GetEmployModel.fromJson(json["data"]),
      data:json["data"] == null ? null : PunchApprovalPendingRequestModel.fromJson(json["data"]),
    );
  }
}
