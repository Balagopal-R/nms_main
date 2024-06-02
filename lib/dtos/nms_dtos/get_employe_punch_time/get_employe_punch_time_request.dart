class GetEmployePunchTimeRequest {
  String userId;
  int startDate;
  int endDate;

  GetEmployePunchTimeRequest({required this.userId, required this.startDate, required this.endDate});

   Map<String, dynamic> toBody() {
    final map = {
    "data": {
        "userId": userId,
        "startDate": startDate,
        "endDate": endDate
    }

};
    return map;
  }
}


