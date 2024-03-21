import 'package:get/get.dart';
import 'package:nms/features/basic_details/basic_details.dart';

import '../features/nms_dasboard/nms_dashboard_screen.dart';
import '../features/signin/signin.dart';

List<GetPage> routes() => [
      GetPage(
          name: "/",
          page: () => const SignInScreen(),
          transition: Transition.cupertino),
          
      GetPage(
          name: "/nms_dashboard_screen",
          page: () => const NmsDashboardScreen(),
          transition: Transition.cupertino),
      GetPage(
          name: "/basic_details_screen",
          page: () => const BasicDetailsScreen(),
          transition: Transition.cupertino),        
    ];
