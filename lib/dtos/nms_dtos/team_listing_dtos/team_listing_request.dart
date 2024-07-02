class TeamListingRequest {

  String keyword;
  String field;
  String sortOfOrder;
  int page;
  int size;


  TeamListingRequest({required this.keyword,required this.field, required this.sortOfOrder,
   required this.page, required this.size});

    Map<String, String> toMap() {
    final map = {
      'keyword' : keyword
    };
    return map;
  }

   Map<String, dynamic> toBody() {
    final map = {
      "sortBy":{"field":field,"sortOrder":sortOfOrder},
      "pagination":{"page":page,"size":size},
      };
    return map;
  }

}