class TeamListingModel {
    String userId;
    String firstname;
    String lastname;
    String? profileImg;
    String? designation;
    String? dept;
    int? punchIn;
    int? punchOut;
    String? punchLocation;
    String? shiftTime;
    String? status;

    TeamListingModel({
        required this.userId,
        required this.firstname,
        required this.lastname,
        this.profileImg,
        this.designation,
        this.dept,
        this.punchIn,
        this.punchOut,
        this.punchLocation,
        this.shiftTime,
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

