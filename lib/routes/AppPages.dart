import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:login/Dashboard/TutorSearch.dart';
import 'package:login/NotesDashBoard/NotesDetails.dart';
import 'package:login/NotesDashBoard/NotesOverView.dart';
import 'package:login/SignUp/SignUp.dart';
import 'package:login/login/login.dart';
import 'package:login/routes/AppRoutes.dart';

class AppPages{
  static final List<GetPage> pages = [
    GetPage(name: AppRoutes.login, page: ()=> Login(),
    ),
    GetPage(name: AppRoutes.tutor, page: ()=> const TutorSearch(),
    ),
    GetPage(name: AppRoutes.signup, page: ()=> const SignUp(),
    ),
    GetPage(name: AppRoutes.overView, page: ()=> const NotesOverView(),
    ),
    GetPage(name: AppRoutes.details, page: ()=> const NotesDetails(),
    )
  ];
}
