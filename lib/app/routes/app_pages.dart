import 'package:get/get.dart';

import 'package:presensi/app/modules/about/bindings/about_binding.dart';
import 'package:presensi/app/modules/about/views/about_view.dart';
import 'package:presensi/app/modules/detail/bindings/detail_binding.dart';
import 'package:presensi/app/modules/detail/views/detail_view.dart';
import 'package:presensi/app/modules/home/bindings/home_binding.dart';
import 'package:presensi/app/modules/home/views/home_view.dart';
import 'package:presensi/app/modules/login/bindings/login_binding.dart';
import 'package:presensi/app/modules/login/views/login_view.dart';
import 'package:presensi/app/modules/new_password/bindings/new_password_binding.dart';
import 'package:presensi/app/modules/new_password/views/new_password_view.dart';
import 'package:presensi/app/modules/register/bindings/register_binding.dart';
import 'package:presensi/app/modules/register/views/register_view.dart';
import 'package:presensi/app/modules/riwayat/bindings/riwayat_binding.dart';
import 'package:presensi/app/modules/riwayat/views/riwayat_view.dart';
import 'package:presensi/app/modules/setting/bindings/setting_binding.dart';
import 'package:presensi/app/modules/setting/views/setting_view.dart';
import 'package:presensi/app/modules/update/bindings/update_binding.dart';
import 'package:presensi/app/modules/update/views/update_view.dart';
import 'package:presensi/app/modules/update_password/bindings/update_password_binding.dart';
import 'package:presensi/app/modules/update_password/views/update_password_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.NEW_PASSWORD,
      page: () => NewPasswordView(),
      binding: NewPasswordBinding(),
    ),
    GetPage(
      name: _Paths.SETTING,
      page: () => SettingView(),
      binding: SettingBinding(),
    ),
    GetPage(
      name: _Paths.UPDATE,
      page: () => UpdateView(),
      binding: UpdateBinding(),
    ),
    GetPage(
      name: _Paths.ABOUT,
      page: () => AboutView(),
      binding: AboutBinding(),
    ),
    GetPage(
      name: _Paths.UPDATE_PASSWORD,
      page: () => UpdatePasswordView(),
      binding: UpdatePasswordBinding(),
    ),
    GetPage(
      name: _Paths.RIWAYAT,
      page: () => RiwayatView(),
      binding: RiwayatBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.DETAIL,
      page: () => DetailView(),
      binding: DetailBinding(),
    ),
  ];
}
