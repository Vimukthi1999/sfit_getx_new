import 'package:get/get.dart';

import 'package:sfit_getx/app/modules/dashboard/dashboard_binding.dart';
import 'package:sfit_getx/app/modules/dashboard/dashboard_view.dart';
import 'package:sfit_getx/app/modules/home_as_tem/home_binding.dart';
import 'package:sfit_getx/app/modules/home_as_tem/home_view.dart';
import 'package:sfit_getx/app/modules/pdf/bindings/pdf_binding.dart';
import 'package:sfit_getx/app/modules/pdf/views/pdf_view.dart';
import 'package:sfit_getx/app/modules/serviceform/serviceform_binding.dart';
import 'package:sfit_getx/app/modules/serviceform/serviceform_view.dart';
import 'package:sfit_getx/app/modules/sfedit/sfedit_binding.dart';
import 'package:sfit_getx/app/modules/sfedit/sfedit_view.dart';
import 'package:sfit_getx/app/modules/sfview/sfview_binding.dart';
import 'package:sfit_getx/app/modules/sfview/sfview_view.dart';
import 'package:sfit_getx/app/modules/signin/signin_binding.dart';
import 'package:sfit_getx/app/modules/signin/signin_view.dart';
import 'package:sfit_getx/app/modules/singature/singature_binding.dart';
import 'package:sfit_getx/app/modules/singature/singature_view.dart';
import 'package:sfit_getx/app/modules/spalsh/spalsh_binding.dart';
import 'package:sfit_getx/app/modules/spalsh/spalsh_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPALSH;

  static final routes = [
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.SIGNIN,
      page: () => SigninView(),
      binding: SigninBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 750),
    ),
    GetPage(
      name: _Paths.SERVICEFORM,
      page: () => ServiceformView(),
      binding: ServiceformBinding(),
    ),
    GetPage(
      name: _Paths.SFVIEW,
      page: () => SfviewView(),
      binding: SfviewBinding(),
    ),
    GetPage(
      name: _Paths.SFEDIT,
      page: () => SfeditView(),
      binding: SfeditBinding(),
    ),
    GetPage(
      name: _Paths.SINGATURE,
      page: () => SingatureView(),
      binding: SingatureBinding(),
    ),
    GetPage(
      name: _Paths.SPALSH,
      page: () => SpalshView(),
      binding: SpalshBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.PDF,
      page: () => PdfView(),
      binding: PdfBinding(),
    ),
  ];
}
