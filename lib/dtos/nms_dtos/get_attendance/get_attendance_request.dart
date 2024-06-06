class GetEmployeAttendanceRequest {
  String userId;

  GetEmployeAttendanceRequest({required this.userId});

  Map<String, String> toMap() {
    return {"userId": userId,};
   }
}
