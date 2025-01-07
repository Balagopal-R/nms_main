import 'package:nms/dtos/api_response.dart';
import 'package:nms/models/task_search_model/task_search_model.dart';

class TaskSearchResponse extends ApiResponse {
  TaskSearchResponse({message, status, data, errors})
      : super(message: message, status: status, data: data, errors: errors);

  factory TaskSearchResponse.fromJson(Map<String, dynamic> json) =>
      TaskSearchResponse(
        message: json["message"],
        status: json["status"],
        data: List<TaskSearchModel>.from(
            json["data"].map((x) => TaskSearchModel.fromJson(x))),
      );
}
