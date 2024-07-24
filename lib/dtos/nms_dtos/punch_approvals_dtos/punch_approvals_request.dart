class PunchApprovalsRequest {
  String field;
  String sortOfOrder;
  int page;
  int size;
  String userId;


  PunchApprovalsRequest({required this.field, required this.sortOfOrder,
   required this.page, required this.size, required this.userId});

   Map<String, dynamic> toBody() {
    final map = {
      "sortBy":{"field":field,"sortOrder":sortOfOrder},
      "pagination":{"page":page,"size":size},
      "data":{"userId": userId}
      };
    return map;
  }

}