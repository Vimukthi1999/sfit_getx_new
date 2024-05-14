import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sfit_getx/app/data/models/asset_code_details_model.dart';
import 'package:sfit_getx/app/data/models/asset_code_dp_model.dart';
import 'package:sfit_getx/app/data/models/items_dp_model.dart';
import 'package:sfit_getx/app/data/models/machine_dp_model.dart';
import 'package:sfit_getx/app/data/models/serial_info_model.dart';
import 'package:sfit_getx/app/data/models/serials_chips.dart';
import 'package:sfit_getx/app/data/models/to_be_paid_in_dp_model.dart';
import 'package:sfit_getx/app/data/models/type_of_hours_model.dart';
import 'package:sfit_getx/app/routes/app_pages.dart';

import '../../../res/app_url.dart';
import '../../../res/theme/app_colors.dart';
import '../../../res/widgets/app_button.dart';
import '../../../res/widgets/app_custom_text_styles.dart';
import '../../../utils/utils.dart';
import '../../data/models/company_dp_model.dart';
import '../../data/models/contract_dp_model.dart';
import '../../data/models/engineer_dp_model.dart';
import '../../data/models/productype_dp_model.dart';
import '../../data/models/send_serial_infotosave_model.dart';
import '../../data/models/site_dp_model.dart';
import '../../data/network/dio_client.dart';

class ServiceformController extends GetxController {
  DioClient dioClient = DioClient();
  var currentStep = 0.obs;
  var scaffoldKey = GlobalKey<ScaffoldState>();

  ScrollController sfviewMainlist = ScrollController();

  void openDrower() {
    scaffoldKey.currentState!.openDrawer();
  }

  void closeDrower() {
    scaffoldKey.currentState!.openEndDrawer();
  }

  ///<--------------- step 01 variables ------------------------>
  var reqNo = 'xxxxx'.obs;
  var tog = 0.obs;

  // enter by asset variables
  var setCompany = 'N/A'.obs;
  var setSite = 'N/A'.obs;

// selected dp values
  var selectedengineer = 'Choose one'.obs;
  var selectedcompany = 'Choose one'.obs;
  var selectedsite = 'Choose one'.obs;
  var selectedcontract = 'Choose one'.obs;
  var selectedmachinetype = 'Choose one'.obs;
  var selectedassetno = 'Choose one'.obs;

  // id of selected dp values
  var idofselectedengineer = ''.obs;
  var idofselectedcompany = ''.obs;
  var idofselectedsite = ''.obs;
  var idofselectedcontarct = ''.obs;
  var idofselectedmachinetype = ''.obs;
  var idofselectedassetno = ''.obs;

  // dp lists
  var engineerlist = <DatumEngineer>[].obs;
  var companylist = <DatumCompany>[].obs;
  var sitelist = <DatumSite>[].obs;
  var contarctlist = <DatumContract>[].obs;
  var machinetypelist = <MachineTypeList>[].obs;
  var assetnoelist = <DatumAssetCode>[].obs;

  ///

  // filter dp lists
  var fcompanylist = <DatumCompany>[].obs;
  var fsitelist = <DatumSite>[].obs;
  var fcontarctlist = <DatumContract>[].obs;
  var fengineerlist = <DatumEngineer>[].obs;

  var fmachinetypelist = <MachineTypeList>[].obs;
  var fassetnoelist = <DatumAssetCode>[].obs;

  TextEditingController assetcontroller = TextEditingController();

  /// <--------------- close step 01 variables ------------------------>

  /// <--------------- step 02 variables ------------------------>
  var priority = 1.obs;
  var iswarrenty = false.obs;
  var isStartTimeAddLater = false.obs;
  var isEndTimeAddLater = false.obs;

  // for select date picker
  DateTime? requestdate, servicedate;
  TimeOfDay? requesttime, starttime, endtime, traveltime;

  var todayDate = DateTime.now();
  var nowTime = TimeOfDay(hour: 9, minute: 0);

  var requestDate = 'dd/mm/yyyy'.obs;
  var requestTime = 'hh:mm'.obs;

  var serviceDate = 'dd/mm/yyyy'.obs;

  var startTime = 'hh:mm'.obs;
  var endTime = 'hh:mm'.obs;
  var travelTime = 'hh:mm'.obs;
  var totaltiemcalculated = 'To Be Determined'.obs;

  var starttimeAddlater = false.obs;
  var endtimeAddlater = false.obs;

  TextEditingController traveltimecontroller = TextEditingController();
  String sTime = '15000';
  String eTime = '15000';
  String tTime = '15000';

  /// <--------------- close step 02 variables ------------------------>

  /// <--------------- step 03 variables ------------------------>

  var tobepaidinlist = <DatumToBePaidIn>[].obs;
  var producttypelist = <DatumProductType>[].obs;
  var typeofhourslist = <DatumTypeofHours>[].obs;

  var ftobepaidinlist = <DatumToBePaidIn>[].obs;
  var fproducttypelist = <DatumProductType>[].obs;
  var ftypeofhourslist = <DatumTypeofHours>[].obs;

  var selectedtobepaidin = 'Choose one'.obs;
  var selectedproducttype = 'Choose one'.obs;
  var selectedtypeofhours = 'Choose one'.obs;

  var idofselectedtobepaidin = ''.obs;
  var idofselectedproducttype = ''.obs;
  var idofselectedtypeofhours = ''.obs;

  TextEditingController ticketNocontroller = TextEditingController();
  TextEditingController problemcontroller = TextEditingController();
  TextEditingController findingcontroller = TextEditingController();
  TextEditingController workUndercontroller = TextEditingController();
  TextEditingController recommendationcontroller = TextEditingController();
  TextEditingController actiontaskcontroller = TextEditingController();

  var valueofLabourHours = ''.obs;

  /// <--------------- close step 03 variables ------------------------>

  /// <--------------- step 04 variables ------------------------>
  var itemslist = <DatumItems>[].obs;
  var fitemslist = <DatumItems>[].obs;

  var serialchips = <SerialChips>[].obs;
  var serialinfolist = <SerialData>[].obs;

  var selecteditem = 'Choose one'.obs;
  var idofselecteditem = ''.obs;

  int predicchipscount = 999999999999999999;

  var totalcost = 0.0.obs;

  List convertedSerialInfoList = [];

  var isAdding = false.obs;

  /// <--------------- close step 04 variables ------------------------>
  /// preview view
  ScrollController previewScroll = ScrollController();

  @override
  void onInit() {
    super.onInit();
    // set values
    fetchCompany();
    fetchEngineer();
    fetchToBePaidIn();
    fetchProductType();
    fetchTypeofHours();
    fetchItems();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    scaffoldKey.currentState?.dispose();
  }

  // setup priority level
  void inPriority(int lvl) {
    if (lvl < 3) {
      priority++;
    }
  }

  void dePriority(int lvl) {
    if (lvl > 1) {
      priority--;
    }
  }

  fetchEngineer() {
    engineerlist.clear();
    fengineerlist.clear();

    dioClient.get(AppUrl.engineerdp).then((value) {
      // print(value.toString());
      var objC = EngineerDpModel.fromJson(value);
      if (value['success']) {
        for (var element in objC.data) {
          // log(element.dropId);
          engineerlist.add(element);
        }
        fengineerlist.addAll(engineerlist);
      } else {
        log('featch values are null');
        Utils.getXsnackBar('Not Found', objC.message.toString());
      }
    }).onError((error, stackTrace) {
      log(error.toString());
    });
  }

  filterEngineer(String value) {
    fengineerlist.clear();
    if (value.toString() == '') {
      fengineerlist.addAll(engineerlist);
    } else {
      fengineerlist.addAll(engineerlist.where((croplist) {
        return croplist.dropValue
            .toLowerCase()
            .contains(value.toLowerCase().toString());
      }).toList());
    }
  }

  fetchCompany() {
    companylist.clear();
    fcompanylist.clear();

    dioClient.get(AppUrl.customerdp).then((value) {
      var objC = CompanyDpModel.fromJson(value);
      if (value['success']) {
        for (var element in objC.data) {
          // log(element.dropId);
          companylist.add(element);
        }
        fcompanylist.addAll(companylist);
      } else {
        log('featch values are null');
        Utils.getXsnackBar('Not Found', objC.message.toString());
      }
    }).onError((error, stackTrace) {
      log(error.toString());
    });
  }

  filterCompany(String value) {
    fcompanylist.clear();
    if (value.toString() == '') {
      fcompanylist.addAll(companylist);
    } else {
      fcompanylist.addAll(companylist.where((croplist) {
        return croplist.dropValue
            .toLowerCase()
            .contains(value.toLowerCase().toString());
      }).toList());
    }
  }

  fetchSite(String selectcompanyid) {
    sitelist.clear();
    fsitelist.clear();

    // clearing old selection values
    selectedcontract.value = 'Choose one';
    idofselectedcontarct.value = '';

    dioClient.get(AppUrl.sitedp + selectcompanyid).then((value) {
      // print(value.toString());
      var objC = SiteDpModel.fromJson(value);
      if (value['success']) {
        for (var element in objC.data) {
          // log(element.dropId);
          sitelist.add(element);
        }

        fsitelist.addAll(sitelist);
      } else {
        log('featch values are null');
        Utils.getXsnackBar('Not Found', objC.message.toString());
      }
    }).onError((error, stackTrace) {
      log(error.toString());
    });
  }

  filterSite(String value) {
    fsitelist.clear();
    if (value.toString() == '') {
      fsitelist.addAll(sitelist);
    } else {
      fsitelist.addAll(sitelist.where((croplist) {
        return croplist.dropValue
            .toLowerCase()
            .contains(value.toLowerCase().toString());
      }).toList());
    }
  }

  fetchContarct(String selectsiteid) {
    contarctlist.clear();
    fcontarctlist.clear();

    dioClient.get(AppUrl.contractdp + selectsiteid).then((value) {
      // print(value.toString());
      var objC = ContractDpModel.fromJson(value);
      if (value['success']) {
        for (var element in objC.data) {
          // log(element.dropId);
          contarctlist.add(element);
        }
        fcontarctlist.addAll(contarctlist);
      } else {
        log('featch values are null');
        Utils.getXsnackBar('Not Found', objC.message.toString());
      }
    }).onError((error, stackTrace) {
      log(error.toString());
    });
  }

  filterContract(String value) {
    fcontarctlist.clear();
    if (value.toString() == '') {
      fcontarctlist.addAll(contarctlist);
    } else {
      fcontarctlist.addAll(contarctlist.where((croplist) {
        return croplist.dropValue
            .toLowerCase()
            .contains(value.toLowerCase().toString());
      }).toList());
    }
  }

  fetchMachineType() {
    machinetypelist.clear();
    fmachinetypelist.clear();

    dioClient.get(AppUrl.machinetypedp).then((value) {
      var objC = MachineTypeModel.fromJson(value['data']);
      if (value['success']) {
        for (var element in objC.machineTypeList) {
          // log(element.dropId);
          machinetypelist.add(element);
        }
        fmachinetypelist.addAll(machinetypelist);
      } else {
        log('featch values are null');
        Utils.getXsnackBar('Not Found', 'Machine types not found');
      }
    }).onError((error, stackTrace) {
      log(error.toString());
    });
  }

  Future<bool> checkAsset() async {
    bool isAddNewAsset = false;

    if (assetcontroller.text.isEmpty) {
      Utils.getXsnackBar('', 'Please Enter Asset Code.');
      return false;
    }
    await dioClient
        .get(AppUrl.checkasset + assetcontroller.text)
        .then((value) async {
      // 9036
      log(value.toString());

      if (!value.containsKey('data')) {
        // show add asset dialog
        log('--- show add asset dialog ---');
        isAddNewAsset = true;
        return isAddNewAsset;
      }

      if (value.containsKey('data')) {
        var obj = AssetCodeDetailsModel.fromJson(value);
        log('--- ${obj} ---${obj.data.contractDet.length}');

        if (obj.data.contractDet.isEmpty) {
          // # company,site purawanna
          selectedcompany.value = obj.data.companyDet.companyName.toString();
          selectedsite.value = obj.data.siteDet.siteName.toString();

          idofselectedcompany.value = obj.data.companyDet.companyId.toString();

          idofselectedsite.value = obj.data.siteDet.siteId.toString();

          fetchContarct(obj.data.siteDet.siteId);
          // # site eke id eka yawala contrack list eka purawanna
          return isAddNewAsset;
        }

        if (obj.data.contractDet.length == 1) {
          // data okkoma company,site,contract walata purawanna
          setCompany.value = obj.data.companyDet.companyName.toString();
          setSite.value = obj.data.siteDet.siteName.toString();
          selectedcontract.value = obj.data.contractDet[0].contractDescription;

          idofselectedcompany.value = obj.data.companyDet.companyId.toString();

          idofselectedsite.value = obj.data.siteDet.siteId.toString();

          idofselectedcontarct.value =
              await obj.data.contractDet[0].contractId.toString();

          if (totaltiemcalculated.value != 'To Be Determined' &&
              idofselectedtypeofhours.value != '') {
            getLabourHours(
              idofselectedtypeofhours.value,
              idofselectedcontarct.value,
              // totaltiemcalculated.value == 'To Be Determined' ? '' :
              totaltiemcalculated.value.toString(),
            );
          }

          return isAddNewAsset;
        }

        if (obj.data.contractDet.length > 1) {
          // contract dropdown list ekata purawanna
          contarctlist.clear();
          fcontarctlist.clear();

          for (var element in obj.data.contractDet) {
            var cMap = {
              "drop_id": element.contractId,
              "drop_value": element.contractDescription,
            };
            var obj = DatumContract.fromJson(cMap);
            contarctlist.add(obj);
          }
          fcontarctlist.addAll(contarctlist);
          // contarctlist.value = obj.data.contractDet;
          setCompany.value = obj.data.companyDet.companyName.toString();
          setSite.value = obj.data.siteDet.siteName.toString();
          // selectedcontract.value = obj.data.contractDet[0].contractDescription;

          idofselectedcompany.value = obj.data.companyDet.companyId.toString();

          idofselectedsite.value = obj.data.siteDet.siteId.toString();

          return isAddNewAsset;
        }
        // return a
      }
    }).onError((error, stackTrace) {
      log(error.toString());
    });
    return isAddNewAsset;
  }

  saveAssetCode() {
    if (assetcontroller.text.isEmpty) {
      Utils.getXsnackBar('Required', 'Asset Code is required');
      return;
    }
    if (idofselectedmachinetype == '') {
      Utils.getXsnackBar('Required', 'Machine Type is required');
      return;
    }
    if (idofselectedcompany == '') {
      Utils.getXsnackBar('Required', 'Company is required');
      return;
    }
    if (idofselectedsite == '') {
      Utils.getXsnackBar('Required', 'Site is required');
      return;
    }
    if (idofselectedcontarct == '') {
      Utils.getXsnackBar('Required', 'Contract is required');
      return;
    }
    try {
      var postJson = toJson(1);

      dioClient.post(AppUrl.saveassetcode, postJson).then((value) async {
        if (value['success']) {
          log(value.toString());
          Get.back();
          Utils.getXSuccesssnackBar(value['message']);
          clearSelectedValues(7);
          await checkAsset();
        }
      }).onError((error, stackTrace) {
        log('message -- $error');
      });
    } catch (e) {
      print(e);
    }
  }

  fetchAssetCodes(String contractID) {
    assetnoelist.clear();
    fassetnoelist.clear();

    dioClient.get(AppUrl.getassetforcontract + contractID).then((value) {
      var objC = AssetCodeDpModel.fromJson(value);
      if (value['success']) {
        for (var element in objC.data) {
          // log(element.dropId);
          assetnoelist.add(element);
        }
        fassetnoelist.addAll(assetnoelist);
      } else {
        log('featch values are null');
        Utils.getXsnackBar('Not Found', 'Machine types not found');
      }
    }).onError((error, stackTrace) {
      log(error.toString());
    });
  }

  getReqNo(String engID) {
    dioClient.get(AppUrl.reqnoo + engID).then((value) {
      log('---------' + value.toString());
      if (value['success']) {
        reqNo.value = value['data']['requistion_number'];
      } else {
        log('featch values are null');
        Utils.getXsnackBar('Not Found', 'Machine types not found');
      }
    }).onError((error, stackTrace) {
      log(error.toString());
    });
  }

  /// <--------------- close step 01 functions ------------------------>

  /// <--------------- step 02 funtions ------------------------>

  // for request date button
  Future<void> pickRequestDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: requestdate ?? initialDate,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime.now().subtract(const Duration(days: 0)),
    );
    if (newDate == null) return;
    requestdate = newDate;

    requestDate.value = getDateFormatText(requestdate);
  }

  // for select request time button
  Future pickRequestTime(BuildContext context) async {
    final initialTime = const TimeOfDay(hour: 9, minute: 0);
    final newTime = await showTimePicker(
      context: context,
      initialTime: requesttime ?? initialTime,
    );
    if (newTime == null) return;

    requesttime = newTime;
    requestTime.value = getTimeFormatText(requesttime, "R");
  }

  // for service date button
  Future pickServiceDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: servicedate ?? initialDate,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime.now().subtract(const Duration(days: 0)),

      //     builder: (context, child) {
      //   return Column(
      //     children: <Widget>[
      //       Padding(
      //         padding: const EdgeInsets.only(top: 50.0),
      //         child: Container(
      //           height: 500,
      //           width: Get.width,
      //           child: child,
      //         ),
      //       ),
      //     ],
      //   );
      // }
    );
    if (newDate == null) return;

    servicedate = newDate;
    serviceDate.value = getDateFormatText(servicedate);
  }

  // for select start time button
  Future pickStartTime(BuildContext context) async {
    final initialTime = const TimeOfDay(hour: 9, minute: 0);
    final newTime = await showTimePicker(
      context: context,
      initialTime: starttime ?? initialTime,
    );
    if (newTime == null) return;
    starttime = newTime;
    startTime.value = getTimeFormatText(starttime, "S");
  }

  // for select end time button
  Future pickEndTime(BuildContext context) async {
    final initialTime = const TimeOfDay(hour: 9, minute: 0);
    final newTime = await showTimePicker(
      context: context,
      initialTime: endtime ?? initialTime,
    );
    if (newTime == null) return;

    endtime = newTime;
    endTime.value = getTimeFormatText(endtime, "E");
  }

  // for select travel time button
  Future pickTravelTime(BuildContext context) async {
    final initialTime = const TimeOfDay(hour: 9, minute: 0);
    final newTime = await showTimePicker(
      context: context,
      initialTime: traveltime ?? initialTime,
    );
    if (newTime == null) return;

    traveltime = newTime;
  }

  String getDateFormatText(DateTime? date) {
    if (date == null) {
      return 'dd/mm/yyyy';
    } else {
      return DateFormat('dd/MM/yyyy').format(date);
    }
  }

  String getTimeFormatText(TimeOfDay? time, String isStart) {
    if (time == null) {
      return 'hh:mm';
    } else {
      final hours = time.hour.toString().padLeft(2, '0');
      final minutes = time.minute.toString().padLeft(2, '0');
      int h = int.parse(hours) * 60;
      int m = int.parse(minutes);
      int totalTimeInMinutes = h + m;
      if (isStart == "S") {
        sTime = totalTimeInMinutes.toString();
        totaltiemcalculated.value = calculateTotalTime();
      } else if (isStart == "E") {
        eTime = totalTimeInMinutes.toString();
        totaltiemcalculated.value = calculateTotalTime();
      }
      if (totaltiemcalculated.value != 'To Be Determined' &&
          idofselectedtypeofhours.value != '') {
        getLabourHours(
          idofselectedtypeofhours.value,
          idofselectedcontarct.value,
          // totaltiemcalculated.value == 'To Be Determined' ? '' :
          totaltiemcalculated.value.toString(),
        );
      }
      return '$hours:$minutes';
    }
  }

  void genTraveltime() {
    try {
      String getVal = traveltimecontroller.text;
      // String getVal = val;
      String hours;
      String minutes;
      final splitted = getVal.split(':');
      int imin = int.parse(splitted[1]);
      int ihou = int.parse(splitted[0]);

      if (imin >= 60) {
        int total = imin - 60;
        minutes = total.toString().padLeft(2, '0');

        int totalhours = ihou + 1;
        hours = totalhours.toString().padLeft(2, '0');

        traveltimecontroller.text = '$hours:$minutes';
      }
      int h = ihou * 60;
      int totalTimeIn = imin + h;
      tTime = totalTimeIn.toString();

      travelTime.value = totalTimeIn.toString();

      print(totalTimeIn);
      totaltiemcalculated.value = calculateTotalTime();
      if (totaltiemcalculated.value != 'To Be Determined' &&
          idofselectedtypeofhours.value != '') {
        getLabourHours(
          idofselectedtypeofhours.value,
          idofselectedcontarct.value,
          // totaltiemcalculated.value == 'To Be Determined' ? '' :
          totaltiemcalculated.value.toString(),
        );
      }
    } catch (e) {
      print(e.toString());
    }
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

  /// <--------------- close step 02 funtions ------------------------>

  /// <--------------- step 03 functions ------------------------>

  fetchToBePaidIn() {
    tobepaidinlist.clear();
    ftobepaidinlist.clear();

    dioClient.get(AppUrl.tobepaidindp).then((value) {
      var objC = ToBePaidInDpModel.fromJson(value);
      if (value['success']) {
        for (var element in objC.data) {
          // log(element.dropId);
          tobepaidinlist.add(element);
        }
        ftobepaidinlist.addAll(tobepaidinlist);
      } else {
        log('featch values are null');
        Utils.getXsnackBar('Not Found', 'To be paid types not found');
      }

      log('bwjebjwbwjw--------------------------' + value.toString());
    }).onError((error, stackTrace) {
      log(error.toString());
    });
  }

  fetchProductType() {
    producttypelist.clear();
    fproducttypelist.clear();

    dioClient.get(AppUrl.producttypedp).then((value) {
      // print(value.toString());
      var objC = ProductTypeDpModel.fromJson(value);
      if (value['success']) {
        for (var element in objC.data) {
          // log(element.dropId);
          producttypelist.add(element);
        }
        fproducttypelist.addAll(producttypelist);
      } else {
        log('featch values are null');
        Utils.getXsnackBar('Not Found', objC.message.toString());
      }
    }).onError((error, stackTrace) {
      log(error.toString());
    });
  }

  fetchTypeofHours() {
    typeofhourslist.clear();
    ftypeofhourslist.clear();

    dioClient.get(AppUrl.typeofhoursdp).then((value) {
      // print(value.toString());
      var objC = TypeofHoursDpModel.fromJson(value);
      if (value['success']) {
        for (var element in objC.data) {
          // log(element.dropId);
          typeofhourslist.add(element);
        }
        ftypeofhourslist.addAll(typeofhourslist);
      } else {
        log('featch values are null');
        Utils.getXsnackBar('Not Found', objC.message.toString());
      }
    }).onError((error, stackTrace) {
      log(error.toString());
    });
  }

  /// labour hour = id of type of hours + id of contract + total time calculated
  Future<void> getLabourHours(
      String idofTypeofHours, String contractID, String totaleTime) async {
    if (idofTypeofHours.isEmpty || idofTypeofHours == '') {
      Utils.getXsnackBar('Required', 'Type of hours field is required');
      return;
    }
    if (contractID.isEmpty || contractID == '') {
      Utils.getXsnackBar('Required', 'Contract field is required');
      return;
    }
    if (totaleTime == '' || totaleTime == 'To Be Determined') {
      Utils.getXsnackBar('Required', 'Total time can not be empty');
      return;
    }

    log('*****$idofTypeofHours,$contractID,$totaleTime');
    dioClient
        .get(AppUrl.labourhour +
            idofTypeofHours +
            '&ctrct_val=' +
            contractID +
            '&ttl_val=' +
            totaleTime)
        .then((value) {
      if (value['success']) {
        valueofLabourHours.value = value['data']['labour_value'].toString();
      } else {
        log('featch values are null');
        Utils.getXsnackBar('Not Found', 'Failed Generating Labour Hours');
      }
    }).onError((error, stackTrace) {
      log(error.toString());
    });
  }

  /// <--------------- close step 03 funtions ------------------------>
  /// <--------------- step 04 funtions ------------------------>
  fetchItems() {
    itemslist.clear();
    fitemslist.clear();
    serialchips.clear();

    dioClient.get(AppUrl.itemsdp).then((value) {
      var objC = ItemDpModel.fromJson(value);
      if (value['success']) {
        for (var element in objC.data) {
          // log(element.dropId);
          itemslist.add(element);
        }
        fitemslist.addAll(itemslist);
      } else {
        log('featch values are null');
        Utils.getXsnackBar('Not Found', 'Machine types not found');
      }
    }).onError((error, stackTrace) {
      log(error.toString());
    });
  }

  filteritem(String value) {
    fitemslist.clear();
    if (value.toString() == '') {
      fitemslist.addAll(itemslist);
    } else {
      fitemslist.addAll(itemslist.where((croplist) {
        return croplist.itemDes
            .toLowerCase()
            .contains(value.toLowerCase().toString());
      }).toList());
    }
  }

  searchBySeriels(String itemID) {
    serialchips.clear();
    //get(AppUrl.serialchips + itemID + '&customer_id=' + idofselectedcompany.value)
    dioClient.get(AppUrl.serialchips + itemID + '&customer_id=').then((value) {
      if (value['success']) {
        if (value['data'].isNotEmpty) {
          int index = 0;
          for (var element in value['data']) {
            //int index = element;
            var serial_no = element['serial_no'];
            SerialChips serialchipsobj =
                SerialChips(index: index, serial_no: serial_no);

            serialchips.add(serialchipsobj);

            print(index);
            index++;
          }
          return serialchips;
        } else {
          log('featch values are null');
          Utils.getXsnackBar(
              'Not Found', 'Sorry ! currnently not available Serial Numbers');
          return null;
        }
      } else {
        log(value['message'].toString());
        Utils.getXsnackBar('Not Found', value['message']);
      }
    }).onError((error, stackTrace) {
      log(error.toString());
      return null;
    });
  }

  serielInfo(String serialID, int chipIndex, String chipSerial) async {
    await dioClient.get(AppUrl.serialinfo + serialID).then((value) {
      if (value['success']) {
        log(value.toString());
        // var objC = SerialInfoModel.fromJson(value);
        String oldPurpose = value['data']['purpose'];
        if (!((oldPurpose == 'STOCK') || (oldPurpose == 'SFIT')) &&
            (oldPurpose != idofselectedcompany.value))
        // if (((oldPurpose != 'STOCK') || (oldPurpose != 'SFIT')) && oldPurpose == idofselectedcompany.value)
        {
          changePurpose(value, chipIndex, chipSerial);
        } else {
          serialinfolist.add(
            SerialInfoModel.fromJson(value).data,
          );
          serialinfolist.value = List.from(serialinfolist.reversed);
          // delete chip
          deleteChips(chipIndex, chipSerial);
        }
      } else {
        log('featch values are null');
        Utils.getXsnackBar('Not Found', 'Serial Details not found');
      }
    }).onError((error, stackTrace) {
      log(error.toString());
    });
  }

  // get access for shown create asset dialog
  void changePurpose(var val, int cindex, String cserial) {
    val['purpose'] = 'selectedcompany';
    Get.defaultDialog(
      title: "Change Purpose ?",
      titlePadding: EdgeInsets.only(top: 10.h),
      content: SizedBox(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8.w),
            child: Column(
              children: [
                appnormaltxt('You are going to change the current purpose'),
                SizedBox(height: 10.w),
                appnormaltxt(
                  'Purpose : ${val['data']['purpose']} --> New Purpose : ${tog.value == 0 ? setCompany.value : selectedcompany.value}',
                ),
                SizedBox(height: 15.w),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: 100.w,
                        child: appButton(() async {
                          val['data']['purpose'] = idofselectedcompany.value;
                          // val['purpose'] = selectedcompany.value;
                          // log('<<<<<<>>>>>>>'+val.toString());
                          serialinfolist.add(
                            SerialInfoModel.fromJson(val).data,
                          );
                          serialinfolist.value =
                              List.from(serialinfolist.reversed);
                          // delete chip
                          deleteChips(cindex, cserial);
                          Get.back();
                        }, 'Yes', AppColor.mainBlueColor)),
                    SizedBox(width: 10.w),
                    SizedBox(
                      width: 100.w,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: appButton(() {
                          Get.back();
                        }, 'No', AppColor.mainBlueColor),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      titleStyle: TextStyle(color: Colors.black, fontSize: 22.sp),
      radius: 5,
    );
  }

  // delete selected serial numbers from interface
  Future<void> deleteChips(int index, String serial_no) async {
    try {
      print('remove index --> $index');
      final index1 =
          serialchips.indexWhere((element) => element.index == index);

      print('remove 1 index --> $index');

      if (index1 != -1) {
        serialchips.removeAt(index1);
        totalCost();
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void totalCost() {
    totalcost.value = serialinfolist.fold(0, (sum, element) {
      double a = double.parse(element.sp);
      double b = double.parse(element.quantity);
      return sum + (a * b);
    });

    print(totalcost.value);
  }

  submitAllData() async {
    if (idofselectedengineer.value == '') {
      Utils.getXsnackBar('Required', 'Engineer field is required');
      return;
    }
    if (idofselectedcompany == '') {
      Utils.getXsnackBar('Required', 'Company field is required');
      return;
    }
    if (idofselectedsite == '') {
      Utils.getXsnackBar('Required', 'Site field is required');
      return;
    }
    if (idofselectedcontarct == '') {
      Utils.getXsnackBar('Required', 'Contract field is required');
      return;
    }
    // if (idofselectedassetno == '') {
    //   Utils.getXsnackBar('Required', 'Asset No is required');
    //   return;
    // }

    if (requestDate.value == 'dd/mm/yyyy') {
      Utils.getXsnackBar('Required', 'Request date is required');
      return;
    }
    if (requestTime.value == 'hh:mm') {
      Utils.getXsnackBar('Required', 'Request time is required');
      return;
    }
    if (serviceDate.value == 'dd/mm/yyyy') {
      Utils.getXsnackBar('Required', 'Service date is required');
      return;
    }
    if (startTime.value == 'hh:mm') {
      Utils.getXsnackBar('Required', 'Start time is required');
      return;
    }
    if (endTime.value == 'hh:mm') {
      Utils.getXsnackBar('Required', 'End time is required');
      return;
    }
    if (traveltimecontroller.text.isEmpty) {
      Utils.getXsnackBar('Required', 'Travel time is required');
      return;
    }
    if (idofselectedtobepaidin == '') {
      Utils.getXsnackBar('Required', 'To be paid in field is required');
      return;
    }
    // if (idofselectedproducttype == '') {
    //   Utils.getXsnackBar('Required', 'Product type field is required');
    //   return;
    // }
    if (idofselectedtypeofhours == '') {
      Utils.getXsnackBar('Required', 'Type of hours field is required');
      return;
    }
    if (problemcontroller.text.isEmpty) {
      Utils.getXsnackBar('Required', 'Problem field is required');
      return;
    }
    isAdding.value = true;
    toJson(2);
    await dioClient.post(AppUrl.submitalldata, toJson(2)).then((value) {
      log('>><<$value');
      if (value['success']) {
        isAdding.value = false;
        Utils.appDialog('Success', value['message'], () {
          Get.offAllNamed(Routes.DASHBOARD);
          // Get.back();
          // Get.back();
        });
      } else {
        isAdding.value = false;
        Utils.appDialog('Not Success', value['message'], () {
          Get.back();
        });
      }
      log(value.toString());
    }).onError((error, stackTrace) {
      isAdding.value = false;
      log(error.toString());
    });
  }

  /// <--------------- close step 04 funtions ------------------------>
  Map<String, dynamic> toJson(int which) {
    // case 01 add new asset code
    // case 02 save all data
    switch (which) {
      case 1:
        Map<String, dynamic> newassetcodeData = {
          'asset_code': assetcontroller.text.trim().toString(),
          'machine_type': idofselectedmachinetype.toString(),
          'company_id': idofselectedcompany.toString(),
          'site_id': idofselectedsite.toString(),
          'contract_id': idofselectedcontarct.toString(),
        };

        print('saved asset code >> $newassetcodeData');
        return newassetcodeData;
      case 2:
        Map<String, dynamic> submitData = {
          "paction": 'add',
          "site": idofselectedsite.toString(),
          "totalTime": totaltiemcalculated.toString(),
          "assetNo": tog.value == 0
              ? assetcontroller.text.toString()
              : idofselectedassetno.toString(),
          "requestDate": requestDate.toString(),
          "requestTime": requestTime.toString(),
          "customer_id": idofselectedcompany.toString(),
          "serviceDate": serviceDate.toString(),
          "startTime": startTime.toString(),
          "no_starttime": isStartTimeAddLater.value ? '1' : '0',
          "endTime": endTime.toString(),
          "no_endtime": isEndTimeAddLater.value ? '1' : '0',
          "serviceFormType": 'Fldsvc',
          "engineer": idofselectedengineer.toString(),
          "productType": idofselectedproducttype.toString(),
          "priorityLevel": priority.toString(),
          "problem": problemcontroller.text.toString(),
          "typeOfHours": idofselectedtypeofhours.toString(),
          "location": 'TEMP',
          "finding": findingcontroller.text.toString(),
          "workUndertaken": workUndercontroller.text.toString(),
          "labour": valueofLabourHours.toString(),
          "inWarranty": iswarrenty,
          "notAvailable": false,
          "toBePaidIn": idofselectedtobepaidin.toString(),
          "contract": idofselectedcontarct.toString(),
          "travelTime": traveltimecontroller.text.toString(),
          "requestNo": reqNo.value.toString(),
          "sTicketNumber": ticketNocontroller.text.toString(),
          "recommendation": recommendationcontroller.text.toString(),
          "askTask": actiontaskcontroller.text.toString(),
          "partsUsed": convertToSaveAPI(serialinfolist),
        };

        log('submit data >> $submitData');
        return submitData;
      default:
        return {};
    }
  }

  // convert to save - serial info list
  List convertToSaveAPI(List oldList) {
    try {
      if (oldList.isEmpty) {
        return [];
      } else {
        convertedSerialInfoList.clear();
        for (var element in oldList) {
          SendSerialInfoToSaveAPI sendSerialInfoToSaveAPIObj =
              SendSerialInfoToSaveAPI(
            item: element.item,
            itemdes: element.itemDes,
            usr_desc: element.itemDes,
            org_purpose: element.purpose,
            purpose: element.purpose,
            serial: element.serialNo,
            qty: element.quantity,
            cost: element.sp,
            uom: element.uom,
          );

          convertedSerialInfoList.add(sendSerialInfoToSaveAPIObj.toJson());
        }
        return convertedSerialInfoList;
      }
    } on Exception catch (e) {
      log(e.toString());
      return [];
    }
  }

// clearing old selection values
  clearSelectedValues(int which) {
    // case 1 : when click company dp
    // case 2 : when click site dp
    // case 3 : when click clear enter by asset code
    // case 4 : when click clear enter by contract
    // case 5 : when submit all data
    // case 6 : when click contract dp
    // case 7 : when click add or cancel button in add asset dialog box

    switch (which) {
      case 1:
        selectedcompany.value = 'Choose one';
        idofselectedcompany.value = '';

        selectedsite.value = 'Choose one';
        idofselectedsite.value = '';
        sitelist.clear();
        fsitelist.clear();

        selectedcontract.value = 'Choose one';
        idofselectedcontarct.value = '';
        contarctlist.clear();
        fcontarctlist.clear();

        selectedassetno.value = 'Choose one';
        idofselectedassetno.value = '';
        assetnoelist.clear();
        fassetnoelist.clear();

        break;

      case 2:
        selectedsite.value = 'Choose one';
        idofselectedsite.value = '';

        selectedcontract.value = 'Choose one';
        idofselectedcontarct.value = '';
        contarctlist.clear();
        fcontarctlist.clear();

        selectedassetno.value = 'Choose one';
        idofselectedassetno.value = '';
        assetnoelist.clear();
        fassetnoelist.clear();

        break;

      case 3:

        /// incomplete
        selectedcompany.value = 'Choose one';
        idofselectedcompany.value = '';

        selectedsite.value = 'Choose one';
        idofselectedsite.value = '';
        sitelist.clear();
        fsitelist.clear();

        selectedcontract.value = 'Choose one';
        idofselectedcontarct.value = '';
        contarctlist.clear();
        fcontarctlist.clear();

        selectedassetno.value = 'Choose one';
        idofselectedassetno.value = '';
        assetnoelist.clear();
        fassetnoelist.clear();

        break;

      case 4:

        /// incomplete
        assetcontroller.clear();

        setCompany.value = 'N/A';
        setSite.value = 'N/A';
        selectedcontract.value = 'Choose one';

        idofselectedcompany.value = '';
        idofselectedsite.value = '';
        idofselectedcontarct.value = '';

        contarctlist.clear();
        fcontarctlist.clear();

        break;

      case 6:
        selectedcontract.value = 'Choose one';
        idofselectedcontarct.value = '';

        selectedassetno.value = 'Choose one';
        idofselectedassetno.value = '';
        assetnoelist.clear();
        fassetnoelist.clear();

        break;

      case 7:
        selectedmachinetype.value = 'Choose one';
        idofselectedmachinetype.value = '';

        selectedcompany.value = 'Choose one';
        idofselectedcompany.value = '';

        selectedsite.value = 'Choose one';
        idofselectedsite.value = '';

        selectedcontract.value = 'Choose one';
        idofselectedcontarct.value = '';

        break;

      default:
    }
  }
}
