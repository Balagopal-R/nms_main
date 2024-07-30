import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nms/dtos/nms_dtos/documents_list_dtos/documents_list_request.dart';
import 'package:nms/dtos/nms_dtos/documents_list_dtos/documents_list_response.dart';
import 'package:nms/dtos/nms_dtos/get_attendance/get_attendance_request.dart';
import 'package:nms/dtos/nms_dtos/get_birthdays_dtos/get_birthday_response.dart';
import 'package:nms/dtos/nms_dtos/get_employe_punch_time/get_employe_punch_time_request.dart';
import 'package:nms/dtos/nms_dtos/get_employe_punch_time/get_employe_punch_time_response.dart';
import 'package:nms/dtos/nms_dtos/get_leaves_dtos/get_leaves_request.dart';
import 'package:nms/dtos/nms_dtos/get_leaves_dtos/get_leaves_response.dart';
import 'package:nms/dtos/nms_dtos/last_punch_in_dtos/last_punch_in.dart';
import 'package:nms/dtos/nms_dtos/punch_in_dtos/punch_in.dart';
import 'package:nms/dtos/nms_dtos/punch_out_dtos/punch_out.dart';
import 'package:nms/dtos/nms_dtos/punch_status_dtos/punch_status.dart';
import 'package:nms/dtos/nms_dtos/team_listing_dtos/team_listing.dart';
import '../dtos/nms_dtos/file_upload_dtos/file_upload.dart';
import '../dtos/nms_dtos/get_attendance/get_attendance_response.dart';
import '../dtos/nms_dtos/get_birthdays_dtos/get_birthday_request.dart';
import '../dtos/nms_dtos/login/get_employ/get_employ.dart';
import '../dtos/nms_dtos/login/login_dtos/login.dart';
import '../dtos/nms_dtos/logout_dtos/logout_request.dart';
import '../dtos/nms_dtos/logout_dtos/logout_response.dart';
import '../dtos/nms_dtos/punch_approval_pending_request_dtos/punch_approval_pending_request.dart';
import '../dtos/nms_dtos/punch_approvals_dtos/punch_approvals.dart';
import '../dtos/nms_dtos/punch_request_cancel_dtos/punch_request_cancel.dart';
import '../dtos/nms_dtos/punch_request_dtos/punch_request.dart';
import '../managers/api/api.dart';

abstract class ApiRepository extends GetxController {
  static ApiRepository get to => Get.find();

  ////sign in

  //Signin_Screen
  Future<SubmitLoginResponse> logInWithEmail(
      {required SubmitLoginRequest request});
      
  // signin_employ_details
  Future<GetEmployResponse> getEmployDetails(
      {required GetEmpoyRequest request});
     
    //  employee_details_average_punch_time
   Future<GetEmployePunchTimeResponse> getEmployePunchTime(
      {required GetEmployePunchTimeRequest request});
      
      // employe_punch_board
      Future<PunchStatusResponse> getPunchStatus(
      {required PunchStatusRequest request});

      //       // employe_attendance
      Future<GetEmployeAttendanceResponse> getAttendance(
      {required GetEmployeAttendanceRequest request});

          //  upcoming birthdays
   Future<GetBirthdayResponse> getEmployeBirthdays(
      {required GetBirthdayRequest request});

                //  get remaining Leaves
   Future<GetLeavesResponse> getLeaves(
      {required GetLeavesRequest request});

                 //  Logout
   Future<LogoutResponse> logout(
      {required LogoutRequest request});

                //  Listing user documents
   Future<DocumentsListResponse> listDocuments(
      {required DocumentsListRequest request});

       //  Team Listing
   Future<TeamListingResponse> teamListing(
      {required TeamListingRequest request});

          //  Last Punch In
   Future<LastPunchInResponse> lastPunchIn(
      {required LastPunchInRequest request});

          //  Punch In
   Future<PunchInResponse> punchIn(
      {required PunchInRequest request});

          //  Punch Out
   Future<PunchOutResponse> punchOut(
      {required PunchOutRequest request});

          //  Punch Request
   Future<PunchRequestResponse> punchRequest(
      {required PunchRequestRequest request});

   //  File Upload
   Future<dynamic> fileUpload(
      {required FileUploadRequest request});

   //  Punch Approvals Card
   Future<dynamic> punchApprovals(
      {required PunchApprovalsRequest request});

       //  Punch Approvals View Request
   Future<dynamic> punchApprovalsRequestView(
      {required PunchApprovalPendingRequest request});

 //  Punch Request Cancel
   Future<dynamic> punchRequestCancel(
      {required PunchRequestCancelRequest request});

  
      
  
}

class ApiRepositoryImpl extends GetxController implements ApiRepository {
  final _helper = ApiBaseHelper();

  final Map<String, String> _headersWithoutToken = {
    'Content-Type': 'application/json',
    'org-id': 'nintriva',
  };

  // final Map<String, String> _header = {'org-id': 'nintriva'};

  //SiginScreen - submitsignin  Api
  @override
  Future<SubmitLoginResponse> logInWithEmail(
      {required SubmitLoginRequest request}) async {
    final response = await _helper.postWithBody(
      headers: _headersWithoutToken,
      endpoint: ApiEndPoints.login,
      body: request.toBody(),
      params: {},
    );
    return SubmitLoginResponse.fromJson(response);
  }


//  full details of the employe
  @override
  Future<GetEmployResponse> getEmployDetails(
      {required GetEmpoyRequest request}) async {
    final response = await _helper.get(
      // headers: _headersWithoutToken,
      endpoint: ApiEndPoints.getEmploy,
      params: request.toMap(),
    );
    debugPrint("response $response");
    return GetEmployResponse.fromJson(response);
  }


  //  employe punch time and average time
  @override
  Future<GetEmployePunchTimeResponse> getEmployePunchTime(
      {required GetEmployePunchTimeRequest request}) async {
    final response = await _helper.postWithBody(
      endpoint: ApiEndPoints.getEmployeeDashboard,
      body: request.toBody(),
      params: {},
    );
    print(response);
    return GetEmployePunchTimeResponse.fromJson(response);
  }

  //employe punch status (leave , in , out)
  @override
  Future<PunchStatusResponse> getPunchStatus(
      {required PunchStatusRequest request}) async {
    final response = await _helper.get(
    endpoint: ApiEndPoints.getPunchStatus, 
    params: request.toMap(),);
    debugPrint("response $response");
    return PunchStatusResponse.fromJson(response);
  }

    // get employe attendance
 @override
  Future<GetEmployeAttendanceResponse> getAttendance(
      {required GetEmployeAttendanceRequest request}) async {
    final response = await _helper.get(
      endpoint: ApiEndPoints.getAttendance,
      params: request.toMap(),);
   debugPrint("response $response");
    return GetEmployeAttendanceResponse.fromJson(response);
  }

// get employee upcoming birthdays
  @override
  Future<GetBirthdayResponse> getEmployeBirthdays(
      {required GetBirthdayRequest request}) async {
    final response = await _helper.get(
        endpoint: ApiEndPoints.getBirthdays, params:{});
    debugPrint("response $response");
    return GetBirthdayResponse.fromJson(response);
  }

   //  remaining employe leave
  @override
  Future<GetLeavesResponse> getLeaves(
      {required GetLeavesRequest request}) async {
    final response = await _helper.postWithBody(
      endpoint: ApiEndPoints.getRemainingLeaves,
      body: request.toBody(),
      params: request.toMap(),
    );
    // print(response);
    return GetLeavesResponse.fromJson(response);
  }

// Log Out
  @override
  Future<LogoutResponse> logout(
      {required LogoutRequest request}) async {
    final response = await _helper.get(
        endpoint: ApiEndPoints.logout, 
        params:{});
    debugPrint("response $response");
    return LogoutResponse.fromJson(response);
  }

   //  Listing employes uploaded documents
  @override
  Future<DocumentsListResponse> listDocuments(
      {required DocumentsListRequest request}) async {
    final response = await _helper.postWithBody(
      endpoint: ApiEndPoints.documentList,
      body: request.toBody(),
      params: {},
    );
    print(response);
    return DocumentsListResponse.fromJson(response);
  }

  //  Listing of team members, punch in & out details
  @override
  Future<TeamListingResponse> teamListing(
      {required TeamListingRequest request}) async {
    final response = await _helper.postWithBody(
      endpoint: ApiEndPoints.teamListing,
      body: request.toBody(),
      params: request.toMap(),
    );
    print(response);
    return TeamListingResponse.fromJson(response);
  }

  //  last Punch In
  @override
  Future<LastPunchInResponse> lastPunchIn(
      {required LastPunchInRequest request}) async {
    final response = await _helper.get(
      endpoint: ApiEndPoints.lastPunchIn,
      params: request.toMap(),
    );
    debugPrint("response $response");
    return LastPunchInResponse.fromJson(response);
  }

  //  Punch In
  @override
  Future<PunchInResponse> punchIn(
      {required PunchInRequest request}) async {
    final response = await _helper.postWithBody(
      endpoint: ApiEndPoints.punchIn,
      body: request.toBody(),
      params: {},
    );
    print(response);
    return PunchInResponse.fromJson(response);
  }

  //  Punch Out
  @override
  Future<PunchOutResponse> punchOut(
      {required PunchOutRequest request}) async {
    final response = await _helper.postWithBody(
      endpoint: ApiEndPoints.punchOut,
      body: request.toBody(),
      params: {},
    );
    print(response);
    return PunchOutResponse.fromJson(response);
  }

   //  Punch Request
  @override
  Future<PunchRequestResponse> punchRequest(
      {required PunchRequestRequest request}) async {
    final response = await _helper.postWithBody(
      endpoint: ApiEndPoints.punchRequest,
      body: request.toBody(),
      params: {},
    );
    print(response);
    return PunchRequestResponse.fromJson(response);
  }

  //  File Upload
  @override
  Future<dynamic> fileUpload(
      {required FileUploadRequest request}) async {
    final response = await _helper.multipartWithBody(
      endpoint: ApiEndPoints.fileUpload,
      body: request.toBody(),
      params: request.toMap(),
    );
    print(response);
    return response;
  }

   //  Listing of Punch Approvals 
  @override
  Future<PunchApprovalsResponse> punchApprovals(
      {required PunchApprovalsRequest request}) async {
    final response = await _helper.postWithBody(
      endpoint: ApiEndPoints.punchApprovals,
      body: request.toBody(),
      params: {},
    );
    print(response);
    return PunchApprovalsResponse.fromJson(response);
  }

    //  Punch Approvals View Request
  @override
  Future<PunchApprovalPendingResponse> punchApprovalsRequestView(
      {required PunchApprovalPendingRequest request}) async {
      final response = await _helper.postWithBody(
      endpoint: ApiEndPoints.punchApprovalsPendingRequest,
      body: request.toBody(),
      params: {},
    );
    print(response);
    return PunchApprovalPendingResponse.fromJson(response);
  }

  //  Punch Request Cancel
  @override
  Future<PunchRequestCancelResponse> punchRequestCancel(
      {required PunchRequestCancelRequest request}) async {
      final response = await _helper.postWithBodyParamsHasNoString(
      endpoint: ApiEndPoints.punchApprovalsCancel,
      body: {},
      params: request.toMap(),
    );
    print(response);
    return PunchRequestCancelResponse.fromJson(response);
  }

}
