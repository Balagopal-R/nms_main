import 'package:get/get.dart';
import 'package:nms/features/basic_details/basic_details.dart';
import 'package:nms/features/reset_password/reset_password.dart';

import '../features/nms_main_layout/nms_main_layout_screen.dart';
import '../features/signin/signin.dart';

List<GetPage> routes() => [
      GetPage(
          name: "/nn",
          page: () => const SignInScreen(),
          transition: Transition.cupertino),
          
      GetPage(
        name: "/",
          // name: "/nms_mainlayout_screen",
          page: () => const NmsMainLayoutScreen(),
          transition: Transition.cupertino),
      GetPage(
          name: "/basic_details_screen",
          page: () => const BasicDetailsScreen(),
          transition: Transition.cupertino),
      GetPage(
          name: "/reset_password_screen",
          // name: "/",
          page: () => const ResetPasswordScreen(),
          transition: Transition.cupertino),        
    ];
