import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sfit_getx/app/data/models/productype_dp_model.dart';
import 'package:sfit_getx/app/data/models/sf_data_model.dart';
import 'package:sfit_getx/app/data/models/wshop_info_model.dart';
import 'package:sfit_getx/app/routes/app_pages.dart';

import '../../../res/app_url.dart';
import '../../../utils/utils.dart';
import '../../data/models/type_of_hours_dp_model.dart';
import '../../data/network/dio_client.dart';

class SfviewController extends GetxController {
  DioClient dioClient = DioClient();
  var scaffoldKey = GlobalKey<ScaffoldState>();

  var iswarrenty = false.obs;
  var Obj = SfDataModel().obs;
  var desTypeofHours = 'N/A'.obs;
  var desProductType = 'N/A'.obs;

  var isDeleting = false.obs;

  TextEditingController controllerSearch = TextEditingController();

  // table
  var rowsPerPage = 5.obs;
  var myData = <WshopInfo>[].obs;

  var totalcost = '0.0'.obs;

  ScrollController sfviewMainlist = ScrollController();

  /// preview view
  ScrollController previewScroll = ScrollController();

  void openDrower() {
    scaffoldKey.currentState!.openDrawer();
  }

  void closeDrower() {
    scaffoldKey.currentState!.openEndDrawer();
  }

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

  fetchData(String reqNo) async {
    log('>>>>>>>>$reqNo');
    Utils.showLoading();
    myData.clear();
    await dioClient.get(AppUrl.fetchdata + reqNo).then((resdata) async {
      log("----------------------" + resdata.toString());
      try {
        if (resdata['success']) {
          Obj.value = SfDataModel.fromJson(resdata);

          // get dp des
          await getTypeofHours(Obj.value.data.svcData[0].typeofwork.toString());
          await getProductType(Obj.value.data.svcData[0].equipmentType.toString());

          // setup wshop info to list
          if (resdata['data']['wshop_info'].isNotEmpty) {
            for (var element in resdata['data']['wshop_info']) {
              var getItems = WshopInfo.fromJson(element);
              myData.add(getItems);
            }
            totalcost.value = Obj.value.data?.svcData[0].agreedPartCost.toString() ?? '0.0';
          }
          print(desTypeofHours);
        }
      } catch (e) {
        log(e.toString());
      } finally {
        Utils.hideLoading();
      }
    }).onError((error, stackTrace) {
      log(error.toString());
    });
  }

  getTypeofHours(String id) async {
    await dioClient.get(AppUrl.typeofhoursdp).then((resdata) {
      try {
        var Obj = TypeOfHoursDpModel.fromJson(resdata);
        for (var element in Obj.data) {
          if (id == element.dropId) {
            desTypeofHours.value = element.dropValue.toString();
            break;
          }
        }
      } catch (e) {
        log(e.toString());
      }
    }).onError((error, stackTrace) {
      log(error.toString());
    });
  }

  getProductType(String id) async {
    await dioClient.get(AppUrl.producttypedp).then((resdata) {
      try {
        log(resdata.toString());
        var Obj = ProductTypeDpModel.fromJson(resdata);
        for (var element in Obj.data) {
          if (id == element.dropId) {
            desProductType.value = element.dropValue.toString();
            break;
          }
        }
      } catch (e) {
        log(e.toString());
      }
    }).onError((error, stackTrace) {
      log(error.toString());
    });
  }

  deleteServiceForm() async {
    isDeleting.value = true;
    await dioClient.post(AppUrl.deleteform, {
      "paction": "delete",
      "requestNo": Obj.value.data.svcData[0].requisitionNo.toString(),
      "contract": Obj.value.data.svcData[0].contractDescription.toString(),
    }).then((resdata) {
      try {
        // log(resdata.toString());
        // Future.delayed(Duration(seconds: 1), () {
        //   Get.offAllNamed(Routes.DASHBOARD);
        // });

        if (resdata['success']) {
       
        Utils.appDialog('Success', resdata['message'], () {
          // Get.offAllNamed(Routes.DASHBOARD);
          Future.delayed(Duration(seconds: 1), () {
             isDeleting.value = false;
          Get.offAllNamed(Routes.DASHBOARD);
        });
          // Get.back();
          // Get.back();
        });
      } else {
        isDeleting.value = false;
        Utils.appDialog('Not Success', resdata['message'], () {
          Get.back();
        });
      }
      } catch (e) {
        log(e.toString());
        isDeleting.value = false;
      }
    }).onError((error, stackTrace) {
      log(error.toString());
      isDeleting.value = false;
    });
  }
}
