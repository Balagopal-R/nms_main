class ProjectSearchRequest {
  String field;
  String sortOfOrder;
  int page;
  int size;
  bool isArchived;
  bool isDeleted;
  String userId;

  ProjectSearchRequest({
    required this.field,
    required this.sortOfOrder,
    required this.page,
    required this.size,
    required this.isArchived,
    required this.isDeleted,
    required this.userId,
  });

  Map<String, dynamic> toBody() {
    final map = {
      "sortBy": {"field": field, "sortOrder": sortOfOrder},
      "pagination": {"page": page, "size": size},
      "data": {"isArchived": false, "isDeleted": false, "userId": userId},
      "filter": []
    };
    return map;
  }
}
