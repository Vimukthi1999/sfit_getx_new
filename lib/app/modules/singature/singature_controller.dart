import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sfit_getx/res/app_url.dart';
import 'package:sfit_getx/utils/utils.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'dart:ui' as ui;
import '../../data/models/sf_data_model.dart';
import '../../data/network/dio_client.dart';
import '../../routes/app_pages.dart';

class SingatureController extends GetxController {
  DioClient dioClient = DioClient();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var Obj = SfDataModel().obs;

  ScrollController viewScrollController = ScrollController();

  /// preview view
  ScrollController previewScroll = ScrollController();

  TextEditingController reasoncontroller = TextEditingController();
  TextEditingController cusnamecontroller = TextEditingController();

  GlobalKey<SfSignaturePadState> engineersignatureGlobalKey = GlobalKey();
  GlobalKey<SfSignaturePadState> clientsignatureGlobalKey = GlobalKey();

  var Converted64EngSign;
  var Converted64ClientSign;

  bool engAccess = true;
  bool cliAccess = true;

  bool isSignedEng = false;
  bool isSignedCli = false;

  var isclientnot = false.obs;
  var clientSignPad = false.obs;
  var engineerSignPad = false.obs;

  var isEngSignLoading = false.obs;
  var isCliSignLoading = false.obs;

  void openDrower() {
    scaffoldKey.currentState!.openDrawer();
  }

  void closeDrower() {
    scaffoldKey.currentState!.openEndDrawer();
  }

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

  fetchData(var map) {
    dioClient.get(AppUrl.fetchsignaturedata + map["reqno"]).then((resdata) {
      //   // log("* * * * *" + resdata.toString());
      log(map["engSign"].toString());
      log(map.toString());
      try {
        if (resdata['success']) {
          Obj.value = SfDataModel.fromJson(resdata);
          if (map["engSign"]) {
            clientSignPad.value = true;
          } else {
            engineerSignPad.value = true;
          }
        }
      } catch (e) {
        log(e.toString());
      }
    }).onError((error, stackTrace) {
      log(error.toString());
    });
  }

  saveEngeerSign(String reqNo) async {
    if (isSignedEng) {
      isEngSignLoading.value = true;
      final data = await engineersignatureGlobalKey.currentState!
          .toImage(pixelRatio: 3.0);
      final bytes = await data.toByteData(format: ui.ImageByteFormat.png);

      Converted64EngSign = base64.encode(bytes!.buffer.asUint8List());

      await dioClient
          .signPost(AppUrl.submitalldata, 'E', toJson('E', reqNo))
          .then((value) {
        log('>><<$value');
        if (value['success']) {
          isEngSignLoading.value = false;
          Utils.appDialog('Success', value['messages']['Signature'], () {
            if (isclientnot.value) {
              Get.back();
              Get.offAllNamed(Routes.DASHBOARD);
            }
            engineerSignPad.value = false;
            clientSignPad.value = true;
            Get.back();
          });
        } else {
          isEngSignLoading.value = false;
          Utils.appDialog('Not Success', value['message'], () {
            Get.back();
          });
        }
      }).onError((error, stackTrace) {
        isEngSignLoading.value = false;
        log(error.toString());
      });
    } else {
      Utils.getXsnackBar('Error', 'Please provide a Signature');
    }
  }

  saveClientSign(String reqNo) async {
    if (isSignedCli) {
      isCliSignLoading.value = true;
      final data =
          await clientsignatureGlobalKey.currentState!.toImage(pixelRatio: 3.0);
      final bytes = await data.toByteData(format: ui.ImageByteFormat.png);

      Converted64ClientSign = base64.encode(bytes!.buffer.asUint8List());

      await dioClient
          .signPost(AppUrl.submitalldata, 'C', toJson('C', reqNo))
          .then((value) {
        log('>><<$value');
        if (value['success']) {
          isCliSignLoading.value = false;
          Utils.appDialog('Success', value['messages']['Signature'], () {
            Get.offAllNamed(Routes.DASHBOARD);
          });
        } else {
          isCliSignLoading.value = false;
          Utils.appDialog('Not Success', value['message'], () {
            Get.back();
          });
        }
      }).onError((error, stackTrace) {
        isCliSignLoading.value = false;
        log(error.toString());
      });
    } else {
      Utils.getXsnackBar('Error', 'Please provide a Signature');
    }
  }

  toJson(String type, String reqNo) {
    switch (type) {
      case 'E':
        Map<String, dynamic> savedata = {
          'eng_sign': Converted64EngSign,
          'paction': "Signature",
          'requestNo': reqNo.toString(),
          'site': Obj.value.data.svcData[0].siteId.toString(),
          'contract': Obj.value.data.svcData[0].contractId.toString(),
          'client_sign': "",
          'assetNo': Obj.value.data.svcData[0].sfitAssetNo.toString(),
          'notAvailable': isclientnot.value ? '1' : '0',
          'customer_id': Obj.value.data.svcData[0].companyId.toString(),
          'reason': isclientnot.value ? reasoncontroller.text.toString() : '',
        };
        log('#########$savedata');
        return savedata;

      case 'C':
        Map<String, dynamic> savedata = {
          'eng_sign': "",
          'paction': "Signature",
          'requestNo': reqNo.toString(),
          'site': Obj.value.data.svcData[0].siteId.toString(),
          'contract': Obj.value.data.svcData[0].contractId.toString(),
          'client_sign': Converted64ClientSign,
          'assetNo': Obj.value.data.svcData[0].sfitAssetNo.toString(),
          'notAvailable': "0",
          'customer_id': Obj.value.data.svcData[0].companyId.toString(),
          'reason': "",
          'customerName': cusnamecontroller.text.toString(),
          // 'customerName': 'cyber cus sign test',
        };
        log('#########$savedata');
        return savedata;
      default:
    }
  }

  clearEngineerPad() {
    engineersignatureGlobalKey.currentState!.clear();
    engAccess = true;
    isSignedEng = false;
  }

  clearClientPad() {
    clientsignatureGlobalKey.currentState!.clear();
    cliAccess = true;
    isSignedCli = false;
  }

  bool handleOnDrawStart() {
    isSignedEng = true;
    return false;
  }

  bool handleOnDrawStartCli() {
    isSignedCli = true;
    return false;
  }
}
