import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sfit_getx/res/app_url.dart';

import 'spalsh_controller.dart';

class SpalshView extends GetView<SpalshController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // child: Text(
        //   'SpalshView is working',
        //   style: TextStyle(fontSize: 20),
        // ),
        child: Image.network(AppUrl.LOGO_URL),
      ),
    );
  }
}
