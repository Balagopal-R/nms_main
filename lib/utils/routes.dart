import 'package:get/get.dart';
import 'package:nms/features/basic_details/basic_details.dart';
import 'package:nms/features/my_documents/my_documents_screen.dart';
import 'package:nms/features/nms_main_layout/punch/approvals/approvals_screen.dart';
import 'package:nms/features/profile/profile_screen.dart';
import 'package:nms/features/reset_password/reset_password.dart';
import 'package:nms/features/splash/splash_screen.dart';
import 'package:nms/features/timesheet/timesheet_screen.dart';
import '../features/nms_main_layout/nms_main_layout_screen.dart';
import '../features/signin/signin.dart';

List<GetPage> routes() => [

      GetPage(
          name: "/",
          page: () => const SplashScreen(),
          transition: Transition.cupertino),

      GetPage(
          name: "/splash_screen",
          page: () => const SplashScreen(),
          transition: Transition.cupertino),
      GetPage(
          name: "/signin_screen",
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
          page: () => const MyDocumentsScreen(),
          transition: Transition.cupertino),
      GetPage(
          name: "/approvals_screen",
          page: () => const ApprovalsScreen(),
          transition: Transition.cupertino),
      GetPage(
          name: "/timesheet_screen",
          page: () => const TimesheetScreen(),
          transition: Transition.cupertino),
    ];


