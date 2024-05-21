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

  String sTime = '15000';
  String eTime = '15000';
  String tTime = '15000';

  var totaltiemcalculated = 'To Be Determined'.obs;

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
          await getProductType(
              Obj.value.data.svcData[0].equipmentType.toString());

          // setup step2 "Total Hours Charged" value
          setupTotalHoursCharged(
            Obj.value.data.svcData[0].startTime.toString(),
            Obj.value.data.svcData[0].noStarttime.toString(),
            Obj.value.data.svcData[0].endTime.toString(),
            Obj.value.data.svcData[0].noEndtime.toString(),
            Obj.value.data.svcData[0].travelTime.toString(),
          );

          // setup wshop info to list
          if (resdata['data']['wshop_info'].isNotEmpty) {
            for (var element in resdata['data']['wshop_info']) {
              var getItems = WshopInfo.fromJson(element);
              myData.add(getItems);
            }
            totalcost.value =
                Obj.value.data?.svcData[0].agreedPartCost.toString() ?? '0.0';
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

  // setup step2 "Total Hours Charged" value
  setupTotalHoursCharged(
    String start_time,
    String no_starttime,
    String end_time,
    String no_endtime,
    String travel_time,
  ) {
    /// start time
    no_starttime == '1' ? sTime = '15000' : sTime = convertToMin(start_time);

    /// end time
    no_endtime == '1' ? eTime = '15000' : eTime = convertToMin(end_time);

    /// travel time
    tTime = convertToMin(travel_time);
    // print("hour --" + ihou.toString() + "min ---" + imin.toString());

    totaltiemcalculated.value = calculateTotalTime();
  }

  // convert all times to min
  String convertToMin(String time) {
    final splitted = time.split(':');
    int imin = int.parse(splitted[1]);
    int ihou = int.parse(splitted[0]);
    int sth = ihou * 60;
    int totalTimeIn = imin + sth;
    return totalTimeIn.toString();
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

  //<--------------- calculation of total time in step 2 ----------------
  String calculateTotalTime() {
    if (sTime == '' || (sTime == '15000' && eTime == '15000')) {
      if (tTime == '15000') {
        // totalTimeValue = 'To Be Determined';
        return 'To Be Determined';
      } else {
        int total = int.parse(tTime);

        var h = total / 60;
        var i = total % 60;

        int ii = h.toInt();

        String a = ii.toString().padLeft(2, '0');
        String b = i.toString().padLeft(2, '0');

        if (total < 0) {
          return 'To Be Determined';
        }
        // return a + ':' + b;
        return get_total_hours_changed(a, b);
      }
    } else if (sTime.isNotEmpty && eTime == '15000') {
      if (tTime == '15000') {
        // totalTimeValue = 'To Be Determined';
        return 'To Be Determined';
      } else {
        int total = int.parse(tTime);

        var h = total / 60;
        var i = total % 60;

        int ii = h.toInt();

        String a = ii.toString().padLeft(2, '0');
        String b = i.toString().padLeft(2, '0');

        if (total < 0) {
          return 'To Be Determined';
        }
        // return a + ':' + b;
        return get_total_hours_changed(a, b);
      }
    } else if (eTime.isNotEmpty && sTime == '15000') {
      if (tTime == '15000') {
        int total = int.parse(eTime);

        var h = total / 60;
        var i = total % 60;

        int ii = h.toInt();

        String a = ii.toString().padLeft(2, '0');
        String b = i.toString().padLeft(2, '0');

        if (total < 0) {
          return 'To Be Determined';
        }
        // return a + ':' + b;
        return get_total_hours_changed(a, b);
      } else {
        int st = int.parse(tTime);
        int et = int.parse(eTime);
        int total = et + st;

        var h = total / 60;
        var i = total % 60;

        int ii = h.toInt();

        String a = ii.toString().padLeft(2, '0');
        // String a = h.toStringAsFixed(0).toString().padLeft(2, '0');
        String b = i.toString().padLeft(2, '0');

        if (total < 0) {
          return 'To Be Determined';
        }
        // return a + ':' + b;
        return get_total_hours_changed(a, b);
      }
    } else {
      if (tTime == '15000') {
        int st = int.parse(sTime);
        int et = int.parse(eTime);
        int total = et - st;

        var h = total / 60;
        var i = total % 60;

        int ii = h.toInt();

        String a = ii.toString().padLeft(2, '0');
        // String a = h.toStringAsFixed(0).toString().padLeft(2, '0');    //  time 12.5 -----> 13
        String b = i.toString().padLeft(2, '0');

        if (total < 0) {
          return 'To Be Determined';
        }
        // return a + ':' + b;
        return get_total_hours_changed(a, b);
      } else {
        int st = int.parse(sTime);
        int et = int.parse(eTime);
        int tt = int.parse(tTime);
        int total = (et - st) + tt;

        var h = total / 60;
        var i = total % 60;

        int ii = h.toInt();

        String a = ii.toString().padLeft(2, '0');
        String b = i.toString().padLeft(2, '0');

        if (total < 0) {
          return 'To Be Determined';
        }
        // return a + ':' + b;
        return get_total_hours_changed(a, b);
      }
    }
  }

  String get_total_hours_changed(String hours, String mintute) {
    String formattedDuration = '';
    try {
      // int convert_mintute = (int.parse(hours) * 60) + (int.parse(mintute) * 60);
      int convert_mintute = (int.parse(hours) * 60) + (int.parse(mintute));

      if (convert_mintute < 60) {
        print('One h');
        formattedDuration = '1:00';
      } else {
        int r = convert_mintute % 60;
        int e = convert_mintute ~/ 60;

        if (r == 0) {
          print("your are in 1st part --- ${e} h");
          formattedDuration = '${e}:00';
        } else if (r <= 30) {
          print("your are in 1st part --- ${e} 30 min");
          // duration = Duration(seconds: (e * 60 + 30 * 60));
          // print(duration); // prints: 0:01:00
          formattedDuration = '${e}:30';
        } else {
          print("your are in 1st part --- ${e + 1} h");
          formattedDuration = '${e + 1}:00';
          // duration = Duration(seconds: ((e + 1) * 60));
          // print(duration); // prints: 0:01:00
        }

        // formattedDuration = '${duration.inHours}:${(duration.inMinutes % 60).toString().padLeft(2, '0')}';
        // print(formattedDuration); // prints: 2:30
      }
    } catch (e) {
      formattedDuration = '---';
      print(e.toString());
    }

    return formattedDuration;
  }

  //<--------------- calculation of total time in step 2 ----------------
}
