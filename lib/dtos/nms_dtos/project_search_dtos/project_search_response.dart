import 'package:nms/dtos/api_response.dart';
import '../../../models/project_search_model/project_search_model.dart';

class ProjectSearchResponse extends ApiResponse {
  ProjectSearchResponse({message, status, data, errors})
      : super(message: message, status: status, data: data, errors: errors);

  factory ProjectSearchResponse.fromJson(Map<String, dynamic> json) =>
      ProjectSearchResponse(
        message: json["message"],
        status: json["status"],
        data: List<ProjectSearchModel>.from(
            json["data"].map((x) => ProjectSearchModel.fromJson(x))),
      );
}
