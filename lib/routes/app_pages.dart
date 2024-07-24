import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:login/routes/app_routes.dart';
import 'package:login/screens/dashBoard/view/notes_over_view_screen.dart';
import 'package:login/screens/detail/view/notes_detail_screen.dart';
import 'package:login/screens/login/view/login_screen.dart';
import 'package:login/screens/signup/view/sign_up_screen.dart';
import 'package:login/screens/splash/splash_screen.dart';

class AppPages{
  static final List<GetPage> pages = [
    GetPage(name: AppRoutes.splash, page: () => const SplashScreen()),
    GetPage(name: AppRoutes.login, page: ()=> Login(),
    ),
    GetPage(name: AppRoutes.signup, page: ()=> const SignUp(),
    ),
    GetPage(name: AppRoutes.overView, page: ()=> NotesOverView(),
    ),
    GetPage(name: AppRoutes.details, page: ()=> NotesDetails(),
    )
  ];
}
