import 'package:nms/dtos/api_response.dart';
import '../../../models/documents_list_model/documensts_list_model.dart';

class DocumentsListResponse extends ApiResponse {
  DocumentsListResponse({message, status, data,errors,pagination})
      : super(message: message, status: status, data: data,pagination: pagination, errors: errors);

  factory DocumentsListResponse.fromJson(Map<String, dynamic> json) {
    return DocumentsListResponse(
      message: json["message"],
      status: json["status"],
      data: List<DocumentsListModel>.from(
          json["data"].map((x) => DocumentsListModel.fromJson(x))),
      pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
      // data: GetEmployModel.fromJson(json["data"]),
      // data:json["data"] == null ? null : GetRemainingLeavesModel.fromJson(json["data"]),
    );
  }
}