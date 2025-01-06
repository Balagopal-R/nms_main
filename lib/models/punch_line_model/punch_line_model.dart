class PunchLineModel {
    int? punchInDatetime;
    int? punchOutDatetime;

    PunchLineModel({
        this.punchInDatetime,
        this.punchOutDatetime,
    });

    factory PunchLineModel.fromJson(Map<String, dynamic> json) => PunchLineModel(
        punchInDatetime: json["punchInDatetime"],
        punchOutDatetime: json["punchOutDatetime"],
    );

    Map<String, dynamic> toJson() => {
        "punchInDatetime": punchInDatetime,
        "punchOutDatetime": punchOutDatetime,
    };
}
