class GetLeavesRequest {
  String userId;
  String asOfDate;
  List<String> status;
  String field;
  String sortOfOrder;
  int page;
  int size;


  GetLeavesRequest({required this.userId, required this.asOfDate, required this.status, required this.field, required this.sortOfOrder, required this.page, required this.size});

   Map<String, String> toMap() {
    // return {"userId": userId,};
    final map = {
      "userId": userId,
      "keyword" : ""
    };
    return map;
  }

   Map<String, dynamic> toBody() {
    final map = {
      "data":{"asOfDate":asOfDate,"status":status,},
     "sortBy":{"field":field,"sortOrder":sortOfOrder},
      "pagination":{"page":page,"size":size}
    };
    return map;
  }

}