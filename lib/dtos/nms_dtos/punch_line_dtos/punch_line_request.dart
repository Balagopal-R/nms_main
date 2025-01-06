class PunchLineRequest {
  String userId;
  String date;

  PunchLineRequest({required this.userId, required this.date});

   Map<String, String> toMap() {
    return {
      "date": date,
      "userId": userId,};
   }
}
