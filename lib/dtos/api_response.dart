import 'package:flutter/material.dart';

class ApiResponse {
  ApiResponse(
      {
      // required this.code,
      this.requestId,
      this.timestamp,
      this.message,
      required this.status,
      required this.data,
      this.errors});
  // String code;
  String? timestamp;
  String? requestId;
  String? message;
  int status;
  dynamic data;
  dynamic errors;
  String messagecall() {
    String? message;
    debugPrint("ApiResponse : Response Data Type :${message.runtimeType}");
    if (errors is List<String>) {
      if (errors['errors'] != null) {
        if (errors['errors'] is String) {
          message = errors['errors'];
        } else if (errors['errors'] is List<String>) {
          List<String> messageList = errors['errors'];
          message = messageList.join('\n');
        }
      } else {
        List<String> messageList = [];
        for (final value in errors.vales.toList()) {
          if (value is String) {
            messageList.add(value);
          } else if (value is List) {
            messageList.addAll(value.map((e) => e.toString()));
          }
        }
        message = messageList.join('\n');
      }
    }

    return message ?? 'Some error occurred.';
  }
}
