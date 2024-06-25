import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nms/managers/sharedpreferences/sharedpreferences.dart';
import 'package:nms/mixins/snackbar_mixin.dart';
import 'package:nms/models/documents_list_model/documensts_list_model.dart';
import 'package:nms/repository/api_repository.dart';
import 'package:nms/utils/helpers/validation.dart';
import '../../dtos/nms_dtos/documents_list_dtos/documents_list_request.dart';

class MyDocumentsController extends GetxController with SnackbarMixin {

   final _listEmployeDocuments = (List<DocumentsListModel>.empty()).obs;
  List<DocumentsListModel> get listEmployeDocuments => _listEmployeDocuments;

   final _employeDocumentDetails = (List<Map<String, String>>.empty()).obs;
  List<Map<String, String>> get employeDocumentDetails => _employeDocumentDetails;

  // final _employeDocumentDetailsMap = (Map<String, String>.empty()).obs;
  // Map<String, String> get employeDocumentDetailsMap => _employeDocumentDetailsMap;

  Map<String, String> documentMap = {'name': '', 'date': '', 'category': ''};
  

  
  @override
  void onInit() async{
    await listUserDocuments();
    super.onInit();
  }
     
    //  list uploaded user documenst
  Future<void> listUserDocuments() async {
    try {
      final authService = NMSJWTDecoder();
      final decodedToken = await authService.decodeAuthToken();
      if (decodedToken != null) {
        final userId = decodedToken["userId"];

        final request = DocumentsListRequest(
          field: "",
          sortOfOrder:"" ,
          page: 0,
          size: 10,
          userId: userId,);

        final response =
            await ApiRepository.to.listDocuments(request: request);

        if (response.status == 200) {
          _listEmployeDocuments.value = response.data;
          for (int i = 0 ; i < listEmployeDocuments.length; i++) {
            documentMap = {'name': listEmployeDocuments[i].displayName,
                           'date': listEmployeDocuments[i].createdAt.toString(), 
                           'category': listEmployeDocuments[i].category};

          // _employeDocumentDetails.value = _employeDocumentDetails.value.add(documentMap);

          }

       

        } else if (response.message == "Failed") {
          debugPrint(response.errors['errorMessage']);
          showErrorSnackbar(message: errorOccuredText);
        }
      }
    } catch (e) {
      return catchErrorSection(e);
    }
  }

  catchErrorSection(e) async {
    debugPrint('error-----${e.toString()}------');

    if (e.toString().isNotEmpty) {
      try {
        Map<String, dynamic> errorResponse = jsonDecode(e.toString());

        if (errorResponse.containsKey("errors")) {
          Map<String, dynamic> errors =
              Map<String, dynamic>.from(errorResponse["errors"]);
          if (errors.containsKey("errorMessage")) {
            String errorMessage = errors["errorMessage"];

            if (errorMessage.contains("Bad Credentials")) {
              debugPrint('error');
            }

            return;
          }
        }
      } catch (e) {
        debugPrint('Error decoding JSON: ${e.toString()}');
        showErrorSnackbar(
          message: e.toString(),
        );
        return e.toString();
      }
    }
  }

}