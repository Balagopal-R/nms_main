import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nms/mixins/snackbar_mixin.dart';

class TeamListingController extends GetxController with SnackbarMixin{
  final TextEditingController searchEmployeeController = TextEditingController();
}