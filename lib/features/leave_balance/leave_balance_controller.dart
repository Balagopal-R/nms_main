import 'package:get/get.dart';

class LeaveBalanceController extends GetxController {
  final items = [
    "Pending",
    "Approved",
    "Cancelled",
    "Rejected",
  ];

  final _contactsOptionList = (List<String>.empty()).obs;
  List<String> get contactsOptionList => _contactsOptionList;

  // List<String> selectedItem = [];

  // final TextEditingController chatSearchController = TextEditingController();

  // final _searchDisplayValue = false.obs;
  // bool get searchDisplayValue => _searchDisplayValue.value;

  // searchDisplay() {
  //   _searchDisplayValue.value = !_searchDisplayValue.value;
  //   update();
  // }
}
