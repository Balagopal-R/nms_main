class GetLeavesRequest {
  String userId;
  String asOfDate;
  List<String> status;
  String field;
  String sortOfOrder;
  int page;
  int size;
  String keyword;


  GetLeavesRequest({required this.userId, required this.asOfDate, required this.status, required this.field, required this.sortOfOrder,
   required this.page, required this.size,required this.keyword});

   Map<String, String> toMap() {
    // return {"userId": userId,};
    final map = {
      'userId': userId,
      'keyword' : keyword
    };
    return map;
  }

   Map<String, dynamic> toBody() {
    final map = {
      "pagination":{"page":page,"size":size},
      "sortBy":{"field":field,"sortOrder":sortOfOrder},
      "data":{"asOfDate":asOfDate,"status":status,},
     
    };
    return map;
  }

}