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
import 'package:nms/dtos/nms_dtos/punch_status_dtos/punch_status.dart';
import '../dtos/nms_dtos/get_attendance/get_attendance_response.dart';
import '../dtos/nms_dtos/get_birthdays_dtos/get_birthday_request.dart';
import '../dtos/nms_dtos/login/get_employ/get_employ.dart';
import '../dtos/nms_dtos/login/login_dtos/login.dart';
import '../dtos/nms_dtos/logout_dtos/logout_request.dart';
import '../dtos/nms_dtos/logout_dtos/logout_response.dart';
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

                //  get remaining Leaves
   Future<DocumentsListResponse> listDocuments(
      {required DocumentsListRequest request});

  
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


  
}
