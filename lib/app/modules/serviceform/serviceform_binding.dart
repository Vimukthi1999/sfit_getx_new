import 'package:get/get.dart';

import 'serviceform_controller.dart';

class ServiceformBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ServiceformController>(
      () => ServiceformController(),
    );
  }
}
