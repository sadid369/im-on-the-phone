import 'package:get/get.dart';
import 'package:groc_shopy/presentation/screens/home/controller/home_controller.dart';
import 'package:groc_shopy/presentation/screens/new_contact_screen/controller/contact_controller.dart';
import 'package:groc_shopy/presentation/screens/profile/controller/profile_controller.dart';

import '../presentation/screens/admin_screens/admin_setting_screen/controller/admin_settings_controller.dart';
import '../presentation/screens/auth/controller/auth_controller.dart';

import '../presentation/widgets/custom_navbar/navbar_controller.dart';

void initGetx() {
  // ================== Global Controller ==================

  // ================== Auth Controller ==================
  // Get.lazyPut(() => AuthController(), fenix: true);

  Get.lazyPut(() => HomeController(), fenix: true);
  Get.lazyPut(() => ContactController(), fenix: true);
  Get.lazyPut(() => ProfileController(), fenix: true);
  Get.lazyPut(() => AdminSettingsController(), fenix: true);
  // Get.lazyPut(() => SearchController(), fenix: true);

  // Get.lazyPut(() => ScannedItemsController(), fenix: true);

  // ================================= Worker ======================================

  // ================================= Client ======================================
}
