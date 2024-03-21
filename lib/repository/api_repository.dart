import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../dtos/nms_dtos/login/get_employ/get_employ.dart';
import '../dtos/nms_dtos/login/login_dtos/login.dart';
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
}
