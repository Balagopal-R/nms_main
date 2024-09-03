class EmployeeData {
  int id;
  String employeeCode;
  String userId;
  String unitId;
  String orgId;
  String? profileImg;
  String? profileImgUrl;
  PersonalDetails personalDetails;
  CorporateDetails corporateDetails;
  bool isActive;
  bool isArchived;
  dynamic archiveDate;
  dynamic archiveType;
  dynamic archiveReason;

  EmployeeData({
    required this.id,
    required this.employeeCode,
    required this.userId,
    required this.unitId,
    required this.orgId,
    this.profileImg,
    this.profileImgUrl,
    required this.personalDetails,
    required this.corporateDetails,
    required this.isActive,
    required this.isArchived,
    this.archiveDate,
    this.archiveType,
    this.archiveReason,
  });

  factory EmployeeData.fromJson(Map<String, dynamic> json) {
    return EmployeeData(
      id: json["id"],
      employeeCode: json['employeeCode'],
      userId: json['userId'],
      unitId: json['unitId'],
      orgId: json['orgId'],
      profileImg: json['profileImg'],
      profileImgUrl: json['profileImgUrl'],
      personalDetails: PersonalDetails.fromJson(json['personalDetails']),
      corporateDetails: CorporateDetails.fromJson(json['corporateDetails']),
      isActive: json['isActive'],
      isArchived: json['isArchived'],
      archiveDate: json['archiveDate'],
      archiveType: json['archiveType'],
      archiveReason: json['archiveReason'],
    );
  }
}

class PersonalDetails {
  String firstname;
  String lastname;
  String? dateOfBirth;
  String? gender;
  String personalMobileNumber;
  String personalEmail;
  String? residentialAddress;
  String? bloodGroup;
  String emergencyContact;
  String? bankAccountNumber;
  String? bankName;
  dynamic ifscCode;
  dynamic panNumber;
  dynamic aadhaarNumber;
  dynamic esiNumber;
  dynamic providentFundNumber;
  dynamic medicalInsuranceNumber;

  PersonalDetails({
    required this.firstname,
    required this.lastname,
    this.dateOfBirth,
    this.gender,
    required this.personalMobileNumber,
    required this.personalEmail,
    this.residentialAddress,
    this.bloodGroup,
    required this.emergencyContact,
    this.bankAccountNumber,
    this.bankName,
    this.ifscCode,
    this.panNumber,
    this.aadhaarNumber,
    this.esiNumber,
    this.providentFundNumber,
    this.medicalInsuranceNumber,
  });

  factory PersonalDetails.fromJson(Map<String, dynamic> json) {
    return PersonalDetails(
      firstname: json['firstname'],
      lastname: json['lastname'],
      dateOfBirth: json['dateOfBirth'],
      gender: json['gender'],
      personalMobileNumber: json['personalMobileNumber'],
      personalEmail: json['personalEmail'],
      residentialAddress: json['residentialAddress'],
      bloodGroup: json['bloodGroup'],
      emergencyContact: json['emergencyContact'],
      bankAccountNumber: json['bankAccountNumber'],
      bankName: json['bankName'],
      ifscCode: json['ifscCode'],
      panNumber: json['panNumber'],
      aadhaarNumber: json['aadhaarNumber'],
      esiNumber: json['esiNumber'],
      providentFundNumber: json['providentFundNumber'],
      medicalInsuranceNumber: json['medicalInsuranceNumber'],
    );
  }
}

class PersonalDetailsBuddy {
  String firstname;
  String lastname;
  String? dateOfBirth;
  String? gender;
  String? personalMobileNumber;
  String? personalEmail;
  String? residentialAddress;
  String? bloodGroup;
  String? emergencyContact;
  String? bankAccountNumber;
  String? bankName;
  dynamic ifscCode;
  dynamic panNumber;
  dynamic aadhaarNumber;
  dynamic esiNumber;
  dynamic providentFundNumber;
  dynamic medicalInsuranceNumber;

  PersonalDetailsBuddy({
    required this.firstname,
    required this.lastname,
    this.dateOfBirth,
    this.gender,
    this.personalMobileNumber,
    this.personalEmail,
    this.residentialAddress,
    this.bloodGroup,
    this.emergencyContact,
    this.bankAccountNumber,
    this.bankName,
    this.ifscCode,
    this.panNumber,
    this.aadhaarNumber,
    this.esiNumber,
    this.providentFundNumber,
    this.medicalInsuranceNumber,
  });

  factory PersonalDetailsBuddy.fromJson(Map<String, dynamic> json) {
    return PersonalDetailsBuddy(
      firstname: json['firstname'],
      lastname: json['lastname'],
      dateOfBirth: json['dateOfBirth'],
      gender: json['gender'],
      personalMobileNumber: json['personalMobileNumber'],
      personalEmail: json['personalEmail'],
      residentialAddress: json['residentialAddress'],
      bloodGroup: json['bloodGroup'],
      emergencyContact: json['emergencyContact'],
      bankAccountNumber: json['bankAccountNumber'],
      bankName: json['bankName'],
      ifscCode: json['ifscCode'],
      panNumber: json['panNumber'],
      aadhaarNumber: json['aadhaarNumber'],
      esiNumber: json['esiNumber'],
      providentFundNumber: json['providentFundNumber'],
      medicalInsuranceNumber: json['medicalInsuranceNumber'],
    );
  }
}

class CorporateDetails {
  String employeeCode;
  String workMobileNumber;
  String workEmail;
  String? dateOfFirstJoining;
  String? joiningDate;
  dynamic employmentType;
  Designation designation;
  Department department;
  dynamic officeLocation;
  dynamic employmentStatus;
  int probationPeriod;
  int? ctc;
  List<Project> projects;
  // Buddy? buddy;
  List<Buddy>? managers;
  dynamic workMode;
  int? dailyWorkHours;
  int? weeklyWorkHours;
  //String? shiftTime;

  CorporateDetails({
    required this.employeeCode,
    required this.workMobileNumber,
    required this.workEmail,
    this.dateOfFirstJoining,
     this.joiningDate,
    this.employmentType,
    required this.designation,
    required this.department,
    this.officeLocation,
    this.employmentStatus,
    required this.probationPeriod,
    this.ctc,
    required this.projects,
    //  this.buddy,
    this.managers,
    this.workMode,
    this.dailyWorkHours,
    this.weeklyWorkHours,
//     this.shiftTime,
  });

  factory CorporateDetails.fromJson(Map<String, dynamic> json) {
    return CorporateDetails(
      employeeCode: json['employeeCode'],
      workMobileNumber: json['workMobileNumber'],
      workEmail: json['workEmail'],
      dateOfFirstJoining: json['dateOfFirstJoining'],
      joiningDate: json['joiningDate'],
      employmentType: json['employmentType'],
      designation: Designation.fromJson(json['designation']),
      department: Department.fromJson(json['department']),
      officeLocation: json['officeLocation'],
      employmentStatus: json['employmentStatus'],
      probationPeriod: json['probationPeriod'],
      ctc: json['ctc'],
      projects:
          List<Project>.from(json['projects'].map((x) => Project.fromJson(x))),
      // buddy: Buddy.fromJson(json['buddy']),
      managers:
          List<Buddy>.from(json['managers'].map((x) => Buddy.fromJson(x))),
      workMode: json['workMode'],
      dailyWorkHours: json['dailyWorkHours'],
      weeklyWorkHours: json['weeklyWorkHours'],
      //śshiftTime: json['shiftTime'],
    );
  }
}

class Buddy {
  String? employeeCode;
  String userId;
  String? unitId;
  String? orgId;
  String? profileImg;
  String? profileImgUrl;
  PersonalDetailsBuddy personalDetailsBuddy;
  dynamic corporateDetails;
  bool? isActive;
  bool? isArchived;
  String? archiveDate;
  dynamic archiveType;
  dynamic archiveReason;

  Buddy({
     this.employeeCode,
    required this.userId,
     this.unitId,
     this.orgId,
     this.profileImg,
     this.profileImgUrl,
    required this.personalDetailsBuddy,
    this.corporateDetails,
     this.isActive,
     this.isArchived,
    this.archiveDate,
    this.archiveType,
    this.archiveReason,
  });

  factory Buddy.fromJson(Map<String, dynamic> json) {
    return Buddy(
      employeeCode: json['employeeCode'],
      userId: json['userId'],
      unitId: json['unitId'],
      orgId: json['orgId'],
      profileImg: json['profileImg'],
      profileImgUrl: json['profileImgUrl'],
      personalDetailsBuddy: PersonalDetailsBuddy.fromJson(json['personalDetails']),
      corporateDetails: json['corporateDetails'],
      isActive: json['isActive'],
      isArchived: json['isArchived'],
      archiveDate: json['archiveDate'],
      archiveType: json['archiveType'],
      archiveReason: json['archiveReason'],
    );
  }
}

class Designation {
  int id;
  String designationName;

  Designation({required this.id, required this.designationName});

  factory Designation.fromJson(Map<String, dynamic> json) {
    return Designation(
      id: json['id'],
      designationName: json['designationName'],
    );
  }
}

class Department {
  int id;
  String departmentName;
  String departmentCode;

  Department(
      {required this.id,
      required this.departmentName,
      required this.departmentCode});

  factory Department.fromJson(Map<String, dynamic> json) {
    return Department(
      id: json['id'],
      departmentName: json['departmentName'],
      departmentCode: json['departmentCode'],
    );
  }
}

class Project {
  int id;
  String projectName;
  String projectCode;

  Project(
      {required this.id, required this.projectName, required this.projectCode});

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'],
      projectName: json['projectName'],
      projectCode: json['projectCode'],
    );
  }
}
