import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sfit_getx/app/routes/app_pages.dart';

class SpalshController extends GetxController {
  final box = GetStorage();

  var num = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();

    // check user already login
    if (box.read('uid') != null) {
      // nav to home
      Future.delayed(Duration(seconds: 3), () {
        Get.offAllNamed(Routes.DASHBOARD);
      });
    } else {
      // nav to login
      Future.delayed(Duration(seconds: 2), () {
        Get.offAllNamed(Routes.SIGNIN);
      });
    }

    // Future.delayed(Duration(seconds: 3), () {
    //   Get.offAllNamed(Routes.SIGNIN);
    // });
  }

  @override
  void onClose() {}
}
