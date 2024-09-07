import 'dart:io';
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
import 'package:path_provider/path_provider.dart';
import '../dtos/nms_dtos/delete_file_by_name_dtos/delete_file_by_name.dart';
import '../dtos/nms_dtos/file_download_dtos/file_download.dart';
import '../dtos/nms_dtos/file_upload_dtos/file_upload.dart';
import '../dtos/nms_dtos/get_all_min_leave_dtos/get_all_min_leave.dart';
import '../dtos/nms_dtos/get_attendance/get_attendance_response.dart';
import '../dtos/nms_dtos/get_birthdays_dtos/get_birthday_request.dart';
import '../dtos/nms_dtos/get_leave_year_by_date_dtos/get_leave_year_by_date.dart';
import '../dtos/nms_dtos/leave_approvals_dtos/leave_approvals.dart';
import '../dtos/nms_dtos/leave_request_cancel_dtos/leave_request_cancel.dart';
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
  Future<GetLeavesResponse> getLeaves({required GetLeavesRequest request});

  //  Logout
  Future<LogoutResponse> logout({required LogoutRequest request});

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
  Future<PunchInResponse> punchIn({required PunchInRequest request});

  //  Punch Out
  Future<PunchOutResponse> punchOut({required PunchOutRequest request});

  //  Punch Request
  Future<PunchRequestResponse> punchRequest(
      {required PunchRequestRequest request});

  //  File Upload
  Future<FileUploadResponse> fileUpload({required FileUploadRequest request});

  //  Punch Approvals Card
  Future<dynamic> punchApprovals({required PunchApprovalsRequest request});

  //  Punch Approvals View Request
  Future<dynamic> punchApprovalsRequestView(
      {required PunchApprovalPendingRequest request});

  //  Punch Request Cancel
  Future<dynamic> punchRequestCancel(
      {required PunchRequestCancelRequest request});

  // Deletefilebyname api
  Future<DeleteFileByNameResponse> deleteFileByName(
      {required DeleteFileByNameRequest request});

  // File Download
  Future<File> fileDownload({required FileDownloadRequest request});

    // Leave Approvals Card
  Future<LeaveApprovalsResponse> leaveApprovals({required LeaveApprovalsRequest request});

    // Leave Request Cancel
  Future<LeaveRequestCancelResponse> leaveRequestCancel(
      {required LeaveRequestCancelRequest request});

      // Get leave year by Leave Date
  Future<GetLeaveYearByDateResponse> leaveYearByLeaveDate(
      {required GetLeaveYearByDateRequest request});

        // Get All Minimum Leave
  Future<GetAllMinLeaveResponse> getAllMin(
      {required GetAllMinLeaveRequest request});

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
      params: request.toMap(),
    );
    debugPrint("response $response");
    return PunchStatusResponse.fromJson(response);
  }

  // get employe attendance
  @override
  Future<GetEmployeAttendanceResponse> getAttendance(
      {required GetEmployeAttendanceRequest request}) async {
    final response = await _helper.get(
      endpoint: ApiEndPoints.getAttendance,
      params: request.toMap(),
    );
    debugPrint("response $response");
    return GetEmployeAttendanceResponse.fromJson(response);
  }

// get employee upcoming birthdays
  @override
  Future<GetBirthdayResponse> getEmployeBirthdays(
      {required GetBirthdayRequest request}) async {
    final response =
        await _helper.get(endpoint: ApiEndPoints.getBirthdays, params: {});
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
  Future<LogoutResponse> logout({required LogoutRequest request}) async {
    final response =
        await _helper.get(endpoint: ApiEndPoints.logout, params: {});
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
  Future<PunchInResponse> punchIn({required PunchInRequest request}) async {
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
  Future<PunchOutResponse> punchOut({required PunchOutRequest request}) async {
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
  Future<FileUploadResponse> fileUpload(
      {required FileUploadRequest request}) async {
    final response = await _helper.multipartWithBody(
      endpoint: ApiEndPoints.fileUpload,
      body: request.toBody(),
      params: request.toMap(),
    );
    print(response);
    return FileUploadResponse.fromJson(response);
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

   //  Listing of Leave Approvals
  @override
  Future<LeaveApprovalsResponse> leaveApprovals(
      {required LeaveApprovalsRequest request}) async {
    final response = await _helper.postWithBody(
      endpoint: ApiEndPoints.leaveApprovals,
      body: request.toBody(),
      params: {},
    );
    print(response);
    return LeaveApprovalsResponse.fromJson(response);
  }

   // Leave Request Cancel
  @override
  Future<LeaveRequestCancelResponse> leaveRequestCancel(
      {required LeaveRequestCancelRequest request}) async {
    final response = await _helper.postWithBodyParamsHasNoString(
      endpoint: ApiEndPoints.punchApprovalsCancel,
      body: {},
      params: request.toMap(),
    );
    print(response);
    return LeaveRequestCancelResponse.fromJson(response);
  }

    //  Get leave year by Leave Date
  @override
  Future<GetLeaveYearByDateResponse> leaveYearByLeaveDate(
      {required GetLeaveYearByDateRequest request}) async {
    final response = await _helper.postWithBody(
      endpoint: ApiEndPoints.leaveYearByLeaveDate,
      body: request.toBody(),
      params: {},
    );
    print(response);
    return GetLeaveYearByDateResponse.fromJson(response);
  }

      //  Get All Minimum Leave
  @override
  Future<GetAllMinLeaveResponse> getAllMin(
      {required GetAllMinLeaveRequest request}) async {
    final response = await _helper.postWithBody(
      endpoint: ApiEndPoints.getAllMin,
      body: request.toBody(),
      params: {},
    );
    print(response);
    return GetAllMinLeaveResponse.fromJson(response);
  }

  //edit_item_screen - deletefilebyname api
  @override
  Future<DeleteFileByNameResponse> deleteFileByName(
      {required DeleteFileByNameRequest request}) async {
    final response = await _helper.postWithId(
      endpoint: ApiEndPoints.deleteFileByName,
      id: request.toBody(),
      params: {},
    );
    debugPrint("response $response");
    return DeleteFileByNameResponse.fromJson(response);
  }

  //  file Download
  @override
  Future<File> fileDownload({required FileDownloadRequest request}) async {
    final response = await _helper.getImage(
      endpoint: ApiEndPoints.downloadFileByName,
      params: request.toMap(),
      isBlob: true, // Pass a flag to indicate a blob response
    );
    debugPrint("Response Type: ${response.runtimeType}");
    debugPrint("Response Length: ${response.length}");
    debugPrint("File downloaded with size: ${response.length} bytes");
    // Get the devices downloads directory for storing the file
  // final Directory? downloadsDir = await getExternalStorageDirectory();

   final Directory downloadsDir = await Directory('/storage/emulated/0/Download').create(recursive: true);
  
  // Define the file path with a filename 
  final String filePath = '${downloadsDir.path}/${request.fileName}';

  // Write the Uint8List to a file
  final File file = File(filePath);
  await file.writeAsBytes(response , flush: true);

 if (await file.exists()) {
  debugPrint("File successfully saved at $filePath with size: ${await file.length()} bytes");
} else {
  debugPrint("File not saved.");
}
  // Return the file
  return file;
}
 
}
