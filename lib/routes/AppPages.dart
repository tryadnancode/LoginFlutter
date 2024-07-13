import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:login/TutorSearch.dart';
import 'package:login/login.dart';
import 'package:login/routes/AppRoutes.dart';

class AppPages{
  static final List<GetPage> pages = [
    GetPage(name: AppRoutes.login, page: ()=> const Login(),

    ),
    GetPage(name: AppRoutes.tutor, page: ()=> const TutorSearch(),

    )
  ];
}