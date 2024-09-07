class GetAllMinLeaveRequest {
  int id;
  String userId;

  GetAllMinLeaveRequest({
    required this.userId,
    required this.id,
  });

  Map<String, dynamic> toBody() {
    final map = {
    "data": {
        "id": id,
        "userIds": [
            userId
        ]
    }
};
    return map;
  }
}
