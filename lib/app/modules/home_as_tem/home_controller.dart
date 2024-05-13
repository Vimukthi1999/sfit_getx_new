import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../res/app_url.dart';
import '../../data/network/dio_client.dart';

class HomeController extends GetxController {
  final box = GetStorage();
  DioClient dioClient = DioClient();

  var tok = ''.obs;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;

  fetchCompany() {
    dioClient.get(AppUrl.customerdp).then((value) {
      print(value.toString());

      // if (value != null) {
      //   var objC = CompanyDpModel.fromJson(value);
      //   for (var element in objC.data) {
      //     // log(element.dropId);
      //     companylist.add(element);
      //   }
      //   fcompanylist.addAll(companylist);
      // } else {
      //   log('featch values are null');
      // }
    }).onError((error, stackTrace) {
      log(error.toString());
    });
  }

  void signIn() {
    // if (controllerUser.text.isEmpty) {
    //   Utils.getXsnackBar('Error', AppTxts.unReq);
    // } else if (controllerPw.text.isEmpty) {
    //   Utils.getXsnackBar('Error', AppTxts.pweReq);
    // } else {
    dioClient.withOutTokenPost(
      AppUrl.login,
      {
        // "email": controllerUser.text.toString(),
        // "password": controllerPw.text.toString(),
        "username": AppUrl.userName,
        "password": AppUrl.appPw,
      },
    ).then(
      (value) async {
        // store token
        await box.write('uid', value['access_token']);
        tok.value = value['access_token'];
        // // nav to home
        // Future.delayed(Duration(seconds: 2), () {
        //   Get.offAllNamed(Routes.DASHBOARD);
        // });
      },
    ).onError(
      (error, stackTrace) {
        log("finder['#01'].toString()");
      },
    );
    // }

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
