import 'package:get/get.dart';

import 'sfview_controller.dart';

class SfviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SfviewController>(
      () => SfviewController(),
    );
  }
}
