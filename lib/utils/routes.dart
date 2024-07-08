import 'package:get/get.dart';
import 'package:nms/features/basic_details/basic_details.dart';
import 'package:nms/features/my_documents/my_documents_screen.dart';
import 'package:nms/features/nms_main_layout/punch/approvals/approvals_screen.dart';
import 'package:nms/features/profile/profile_screen.dart';
import 'package:nms/features/reset_password/reset_password.dart';
import '../features/nms_main_layout/nms_main_layout_screen.dart';
import '../features/signin/signin.dart';

List<GetPage> routes() => [
      GetPage(
          name: "/n",
          page: () => const SignInScreen(),
          transition: Transition.cupertino),
      GetPage(
          name: "/nms_mainlayout_screen",
          page: () => const NmsMainLayoutScreen(),
          transition: Transition.cupertino),
      GetPage(
          name: "/basic_details_screen",
          page: () => const BasicDetailsScreen(),
          transition: Transition.cupertino),
      GetPage(
          name: "/reset_password_screen",
          page: () => const ResetPasswordScreen(),
          transition: Transition.cupertino),
      GetPage(
          name: "/profile_screen",
          page: () => const ProfileScreen(),
          transition: Transition.cupertino),
      GetPage(
          name: "/my_documents_screen",
          page: () => MyDocumentsScreen(),
          transition: Transition.cupertino),
      GetPage(
          name: "/",
          page: () => ApprovalsScreen(),
          transition: Transition.cupertino),
    ];


