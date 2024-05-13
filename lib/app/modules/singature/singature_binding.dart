import 'package:get/get.dart';

import 'singature_controller.dart';

class SingatureBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SingatureController>(
      () => SingatureController(),
    );
  }
}
