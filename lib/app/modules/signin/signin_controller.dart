import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sfit_getx/app/data/network/dio_client.dart';
import 'package:sfit_getx/res/app_url.dart';
import 'package:sfit_getx/utils/utils.dart';

import '../../../res/app_txts.dart';
import '../../../res/default_data.dart';
import '../../routes/app_pages.dart';

class SigninController extends GetxController {
  final box = GetStorage();
  DioClient dioClient = DioClient();
  TextEditingController controllerUser = TextEditingController();
  TextEditingController controllerPw = TextEditingController();
  var passwordVisible = true.obs;
  var loading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    controllerUser.dispose();
    controllerPw.dispose();
  }

  // sign-in

  void signIn() {
    if (controllerUser.text.isEmpty) {
      Utils.getXsnackBar('Error', AppTxts.unReq);
    } else if (controllerPw.text.isEmpty) {
      Utils.getXsnackBar('Error', AppTxts.pweReq);
    } else {
      loading.value = true;
      dioClient.withOutTokenPost(
        AppUrl.login,
        {
          // "username": controllerUser.text.toString(),
          // "password": controllerPw.text.toString(),
          "username": AppUrl.userName,
          "password": AppUrl.appPw,
        },
      ).then(
        (value) async {
          // store token
          await box.write('uid', value['access_token']);
          loading.value = false;
          // nav to home
          Future.delayed(Duration(seconds: 2), () {
            Get.offAllNamed(Routes.DASHBOARD);
          });
        },
      ).onError(
        (error, stackTrace) {
          loading.value = false;
          log(finder['#01'].toString());
        },
      );
    }

    // dioClient.withOutTokenPost(
    //   AppUrl.login,
    //   {
    //     // "email": controllerUser.text.toString(),
    //     // "password": controllerPw.text.toString(),
    //     "email": AppUrl.userName,
    //     "password": AppUrl.appPw,
    //   },
    // ).then(
    //   (value) {
    //     log(value.toString());
    //   },
    // ).onError(
    //   (error, stackTrace) {
    //     log(finder['#01'].toString());
    //   },
    // );
  }
}
