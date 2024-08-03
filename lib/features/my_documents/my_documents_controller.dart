import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nms/managers/sharedpreferences/sharedpreferences.dart';
import 'package:nms/mixins/snackbar_mixin.dart';
import 'package:nms/models/documents_list_model/documensts_list_model.dart';
import 'package:nms/models/file_upload_model/file_upload_model.dart';
import 'package:nms/repository/api_repository.dart';
import 'package:nms/utils/helpers/validation.dart';
import '../../dtos/nms_dtos/documents_list_dtos/documents_list_request.dart';
import '../../dtos/nms_dtos/file_upload_dtos/file_upload.dart';

class MyDocumentsController extends GetxController with SnackbarMixin {

  var uploadedImageMessage = "".obs;

   final _listEmployeDocuments = (List<DocumentsListModel>.empty()).obs;
  List<DocumentsListModel> get listEmployeDocuments => _listEmployeDocuments;

   final _employeDocumentDetails = (List<Map<String, String>>.empty()).obs;
  List<Map<String, String>> get employeDocumentDetails => _employeDocumentDetails;

    final _uploadedImagevalue = (List<String>.empty(growable: true)).obs;
  List<String> get uploadedImagevalue => _uploadedImagevalue.value;

  // final _employeDocumentDetailsMap = (Map<String, String>.empty()).obs;
  // Map<String, String> get employeDocumentDetailsMap => _employeDocumentDetailsMap;

  final _userFileUpload = Rx<FileUploadModel?>(null);
  FileUploadModel? get userFileUpload => _userFileUpload.value;

    final _extractedFirstPart = "".obs;
  String get extractedFirstPart => _extractedFirstPart.value;

  Map<String, String> documentMap = {'name': '', 'date': '', 'category': ''};
  

  
  @override
  void onInit() async{
    await listUserDocuments();
    super.onInit();
  }

  

String epochTimeToFormattedDate (int epochTime) {
  // Convert epoch time to DateTime object
  final dateTime = DateTime.fromMillisecondsSinceEpoch(epochTime);

  // Use DateFormat to format the date string
  final formattedDate = DateFormat('dd MMM yy').format(dateTime);

  return formattedDate;
}

String capitalizeFirstLetter(String text) {
  if (text.isEmpty) return text;

  return text[0].toUpperCase() + text.substring(1).toLowerCase();
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
          print(listEmployeDocuments.length);
          print(listEmployeDocuments[0].displayName);
          update();
          // for (int i = 0 ; i < listEmployeDocuments.length; i++) {
          //   documentMap = {'name': listEmployeDocuments[i].displayName,
          //                  'date': listEmployeDocuments[i].createdAt.toString(), 
          //                  'category': listEmployeDocuments[i].category};

          // // _employeDocumentDetails.value = _employeDocumentDetails.value.add(documentMap);

          // }

       

        } else if (response.message == "Failed") {
          debugPrint(response.errors['errorMessage']);
          showErrorSnackbar(message: errorOccuredText);
          update();
        }
      }
    } catch (e) {
      update();
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

   // upload image api function
  Future<void> uploadImage(File imageFile) async {
    String defaultMessage = '';

    try {

      final authService = NMSJWTDecoder();
      final decodedToken = await authService.decodeAuthToken();
      if (decodedToken != null) {
        final userId = decodedToken["userId"];
      final request =
          FileUploadRequest(userId: userId, uploadfile: imageFile,category: 'Work');
      final response = await ApiRepository.to.fileUpload(request: request);

      if (response.statusCode == 200) {
        final response1 = await response.stream.bytesToString();
        final parsedJson = json.decode(response1);
        var datas = FileUploadModel.fromJson(parsedJson);
        var message = datas.fileUrl;
        
        // uploadedImageMessage.value = message;
        if (uploadedImagevalue.length < 3) {
          uploadedImagevalue.add(_extractLastSegment(message));
          _extractedFirstPart.value = _extractFirstSegment(message);
        } else {
          showErrorSnackbar(message: "Maximum 3 images can be uploaded");
          
        }

        // print(uploadedImagevalue);

        debugPrint('-----Stored file name :$message-----');
        update();
      } else {
        debugPrint('fail');
        uploadedImageMessage.value = defaultMessage;
      }
      }
    } 
   catch (e) {
      showErrorSnackbar(message: e.toString());
           uploadedImageMessage.value = defaultMessage;
      debugPrint(e.toString());
    }
  }

    String _extractLastSegment(String url) {
    Uri uri = Uri.parse(url);
    List<String> pathSegments = uri.pathSegments;
    if (pathSegments.isNotEmpty) {
      return pathSegments.last;
    } else {
      return '';
    }
  }

  String _extractFirstSegment(String url) {
    Uri uri = Uri.parse(url);
    List<String> pathSegments = uri.pathSegments;
    if (pathSegments.isNotEmpty) {
      var part = uri.replace(path: '/').toString();
      return part;
    } else {
      return '';
    }
  }




}