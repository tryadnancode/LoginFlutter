import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:login/NotesDashBoard/NotesDetails.dart';
import 'package:login/NotesDashBoard/NotesOverView.dart';
import 'package:login/module/view/login/login_screen.dart';
import 'package:login/module/view/signup/sign_up_screen.dart';
import 'package:login/routes/app_routes.dart';

class AppPages{
  static final List<GetPage> pages = [
    GetPage(name: AppRoutes.login, page: ()=> Login(),
    ),
    GetPage(name: AppRoutes.signup, page: ()=> const SignUp(),
    ),
    GetPage(name: AppRoutes.overView, page: ()=> const NotesOverView(),
    ),
    GetPage(name: AppRoutes.details, page: ()=> const NotesDetails(),
    )
  ];
}
