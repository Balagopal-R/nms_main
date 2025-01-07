class TaskSearchRequest {
  String field;
  String sortOfOrder;
  int page;
  int size;
  String keyword;
  String projectId;
  bool isArchived;
  bool isDeleted;
  String userId;

  TaskSearchRequest({
    required this.field,
    required this.sortOfOrder,
    required this.page,
    required this.size,
    required this.keyword,
    required this.projectId,
    required this.isArchived,
    required this.isDeleted,
    required this.userId,
  });

  Map<String, dynamic> toBody() {
    final map = {
      "sortBy": {"field": field, "sortOrder": sortOfOrder},
      "pagination": {"page": page, "size": size},
      "data": {
        "keyword": keyword,
        "projectId": projectId,
        "userId": userId,
        "isArchived": isArchived,
        "isDeleted": isDeleted
      },
      "filter": []
    };
    return map;
  }
}
