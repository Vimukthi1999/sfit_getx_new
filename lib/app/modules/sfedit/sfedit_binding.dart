import 'package:get/get.dart';

import 'sfedit_controller.dart';

class SfeditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SfeditController>(
      () => SfeditController(),
    );
  }
}
