class TeamListingModel {
    String userId;
    String firstname;
    String lastname;
    String? profileImg;
    String designation;
    String dept;
    int? punchIn;
    int? punchOut;
    String? punchLocation;
    String shiftTime;
    String? status;

    TeamListingModel({
        required this.userId,
        required this.firstname,
        required this.lastname,
        this.profileImg,
        required this.designation,
        required this.dept,
        this.punchIn,
        this.punchOut,
        this.punchLocation,
        required this.shiftTime,
        this.status,
    });

    factory TeamListingModel.fromJson(Map<String, dynamic> json) => TeamListingModel(
        userId: json["userId"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        profileImg: json["profileImg"],
        designation: json["designation"],
        dept: json["dept"],
        punchIn: json["punchIn"],
        punchOut: json["punchOut"],
        punchLocation: json["punchLocation"],
        shiftTime: json["shiftTime"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "firstname": firstname,
        "lastname": lastname,
        "profileImg": profileImg,
        "designation": designation,
        "dept": dept,
        "punchIn": punchIn,
        "punchOut": punchOut,
        "punchLocation": punchLocation,
        "shiftTime": shiftTime,
        "status": status,
    };
}

class Pagination {
    int totalPages;
    int totalElements;
    int currentPage;
    int pageSize;

    Pagination({
        required this.totalPages,
        required this.totalElements,
        required this.currentPage,
        required this.pageSize,
    });

    factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        totalPages: json["totalPages"],
        totalElements: json["totalElements"],
        currentPage: json["currentPage"],
        pageSize: json["pageSize"],
    );

    Map<String, dynamic> toJson() => {
        "totalPages": totalPages,
        "totalElements": totalElements,
        "currentPage": currentPage,
        "pageSize": pageSize,
    };
}