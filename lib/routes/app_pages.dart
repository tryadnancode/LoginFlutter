import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:login/auth/login/view/login_screen.dart';
import 'package:login/auth/signup/view/sign_up_screen.dart';
import 'package:login/routes/app_routes.dart';
import 'package:login/screen/all_notes/view_all_screen.dart';
import 'package:login/screen/dashboard/view/notes_over_view_screen.dart';
import 'package:login/screen/detail/view/notes_detail_screen.dart';
import 'package:login/screen/splash/splash_screen.dart';

class AppPages{
  static final List<GetPage> pages = [
    GetPage(name: AppRoutes.splash, page: () => const SplashScreen()),
    GetPage(name: AppRoutes.login, page: ()=> Login(),
    ),
    GetPage(name: AppRoutes.signup, page: ()=> const SignUp(),
    ),
    GetPage(name: AppRoutes.overView, page: ()=> const NotesOverview(),
    ),
    GetPage(name: AppRoutes.details, page: ()=> const NotesDetails(),
    ),
    GetPage(name: AppRoutes.viewAll, page: ()=> const ViewAllScreen(),
    )
  ];
}
