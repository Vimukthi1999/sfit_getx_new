import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart';

import '../../../res/app_url.dart';
import '../../../res/theme/app_colors.dart';
import '../../../res/widgets/app_button.dart';
import '../../../utils/utils.dart';
import '../../data/models/items_dp_model.dart';
import '../../data/models/productype_dp_model.dart';
import '../../data/models/send_serial_infotosave_model.dart';
import '../../data/models/serials_chips.dart';
import '../../data/models/sf_data_model.dart';
import '../../data/models/t4.dart';
import '../../data/models/to_be_paid_in_dp_model.dart';
import '../../data/models/type_of_hours_model.dart';
import '../../data/models/wshop_info_model.dart';
import '../../data/network/dio_client.dart';
import '../../routes/app_pages.dart';

class SfeditController extends GetxController {
  DioClient dioClient = DioClient();
  var scaffoldKey = GlobalKey<ScaffoldState>();

  ScrollController sfeditviewScroll = ScrollController();

  /// preview view
  ScrollController previewScroll = ScrollController();

  var Obj = SfDataModel().obs;

  var myData = <WshopInfo>[].obs;

  var totalcost = 0.0.obs;
  var desTypeofHours = 'N/A'.obs;
  var desProductType = 'N/A'.obs;

  var priority = 1.obs;

// for select date picker
  DateTime? requestdate, servicedate;
  TimeOfDay? starttime, endtime;
  var startTime = 'hh:mm'.obs;
  var endTime = 'hh:mm'.obs;
  var totaltiemcalculated = 'To Be Determined'.obs;
  var requestDate = 'dd/mm/yyyy'.obs;
  var serviceDate = 'dd/mm/yyyy'.obs;

  var isStartTimeAddLater = false.obs;
  var isEndTimeAddLater = false.obs;
  String sTime = '15000';
  String eTime = '15000';
  String tTime = '15000';

  var idofselectedsite, assetno, idofselectedcontarct, reqestionNo, traveltime, requestTime, idofselectedengineer;
  var valueofLabourHours = ''.obs;
  var iswarrenty = false.obs;

  var tobepaidinlist = <DatumToBePaidIn>[].obs;
  var typeofhourslist = <DatumTypeofHours>[].obs;

  var ftobepaidinlist = <DatumToBePaidIn>[].obs;
  var ftypeofhourslist = <DatumTypeofHours>[].obs;

  var selectedtobepaidin = 'Choose one'.obs;
  var selectedtypeofhours = 'Choose one'.obs;

  var idofselectedtobepaidin = ''.obs;
  var idofselectedtypeofhours = ''.obs;

  TextEditingController problemcontroller = TextEditingController();
  TextEditingController findingcontroller = TextEditingController();
  TextEditingController workUndercontroller = TextEditingController();
  TextEditingController recommendationcontroller = TextEditingController();
  TextEditingController actiontaskcontroller = TextEditingController();

  var tblhasval = false.obs;
  var wshopinfo = <T4>[].obs;
  var serialchips = <SerialChips>[].obs;
  List convertedSerialInfoList = [];
  // var serialinfolist = <SerialData>[].obs;

  var setCompany = 'N/A'.obs;
  var idofselectedcompany = ''.obs;

  var itemslist = <DatumItems>[].obs;
  var fitemslist = <DatumItems>[].obs;

  var selecteditem = 'Choose one'.obs;
  var idofselecteditem = ''.obs;

  var isUpdating = false.obs;

  int predicchipscount = 999999999999999999;

  void openDrower() {
    scaffoldKey.currentState!.openDrawer();
  }

  void closeDrower() {
    scaffoldKey.currentState!.openEndDrawer();
  }

  @override
  void onInit() {
    super.onInit();
    fetchTypeofHours();
    fetchToBePaidIn();
    fetchItems();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    scaffoldKey.currentState?.dispose();
    sfeditviewScroll.dispose();
    previewScroll.dispose();
    actiontaskcontroller.dispose();
    recommendationcontroller.dispose();
    workUndercontroller.dispose();
    findingcontroller.dispose();
    problemcontroller.dispose();
    super.onClose();
  }

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

  fetchData(String reqNo) {
    // print('>>>>>>>>$reqNo');
    Utils.showLoading();
    myData.clear();
    wshopinfo.clear();
    dioClient.get(AppUrl.fetchdata + reqNo).then((resdata) async {
      log("----------------------" + resdata.toString());
      try {
        Obj.value = SfDataModel.fromJson(resdata);
        var svcdata = Obj.value.data.svcData[0];

        // set company details
        setCompany.value = svcdata.companyName.toString();
        idofselectedcompany.value = svcdata.companyId.toString();
        idofselectedsite = svcdata.siteId.toString();
        assetno = svcdata.sfitAssetNo.toString();
        iswarrenty.value = svcdata.warranty.toString() == '0' ? false : true;
        valueofLabourHours.value = svcdata.agreedLabourCost.toString();
        idofselectedcontarct = svcdata.contractId.toString();
        reqestionNo = svcdata.requisitionNo.toString();
        traveltime = svcdata.travelTime.toString();
        requestTime = svcdata.requestedTime.toString();
        idofselectedengineer = svcdata.engineer.toString();

        // set date time pickers values
        serviceDate.value = svcdata.startDate.toString();
        DateTime sdate = DateFormat('dd/MM/yyyy').parse(svcdata.startDate.toString());
        servicedate = DateTime(sdate.year, sdate.month, sdate.day);

        requestDate.value = svcdata.requestedDate.toString();
        DateTime rdate = DateFormat('dd/MM/yyyy').parse(svcdata.requestedDate.toString());
        requestdate = DateTime(rdate.year, rdate.month, rdate.day);

        if (svcdata.noStarttime.toString() == '1') {
          isStartTimeAddLater.value = true;
          startTime.value = 'Add Later';
        } else {
          startTime.value = svcdata.startTime.toString();
          DateTime st = DateFormat('KK:mm').parse(svcdata.startTime.toString());
          starttime = TimeOfDay.fromDateTime(st);
          final splittedST = svcdata.startTime.toString().split(':');
          int imin = int.parse(splittedST[1]);
          int ihou = int.parse(splittedST[0]);
          int h = ihou * 60;
          int totalTimeST = imin + h;

          sTime = totalTimeST.toString();
        }

        if (svcdata.noEndtime.toString() == '1') {
          isEndTimeAddLater.value = true;
          endTime.value = 'Add Later';
        } else {
          endTime.value = svcdata.endTime.toString();
          DateTime et = DateFormat('KK:mm').parse(svcdata.endTime.toString());
          endtime = TimeOfDay.fromDateTime(et);
          final splittedET = svcdata.startTime.toString().split(':');
          int imin = int.parse(splittedET[1]);
          int ihou = int.parse(splittedET[0]);
          int h = ihou * 60;
          int totalTimeET = imin + h;

          eTime = totalTimeET.toString();
        }

        final splitted = svcdata.travelTime.toString().split(':');
        int imin = int.parse(splitted[1]);
        int ihou = int.parse(splitted[0]);
        int h = ihou * 60;
        int totalTimeIn = imin + h;

        tTime = totalTimeIn.toString();

        totaltiemcalculated.value = calculateTotalTime();

        // set dropdown ids
        idofselectedtypeofhours.value = svcdata.typeofwork.toString();
        idofselectedtobepaidin.value = svcdata.duedaysInvoice.toString();

        // set priority level
        priority.value = int.parse(svcdata.priorityLevel.toString());

        // set text field values
        problemcontroller.text = svcdata.problems.toString();
        findingcontroller.text = svcdata.findings.toString();
        workUndercontroller.text = svcdata.workUndertaken.toString();
        recommendationcontroller.text = svcdata.recommendations.toString();
        actiontaskcontroller.text = svcdata.actionTask.toString();

        // get dp des
        await getTobePaidInDes(idofselectedtobepaidin.value);
        await getTypeofHours(idofselectedtypeofhours.value);
        await getProductType(Obj.value.data.svcData[0].equipmentType.toString());

        // setup wshop info to list
        log('-------------------------------->>>>>>> ${resdata['data']['wshop_info']}');
        if (resdata['data']['wshop_info'].isNotEmpty) {
          for (var element in resdata['data']['wshop_info']) {
            var getItems = T4.fromJson(element);
            wshopinfo.add(getItems);
          }

          tblhasval.value = true;
        }
        // print(desTypeofHours);
      } catch (e) {
        log(e.toString());
      } finally {
        Utils.hideLoading();
      }
    }).onError((error, stackTrace) {
      log(error.toString());
    });
  }

  getTobePaidInDes(String id) async {
    try {
      for (var element in ftobepaidinlist) {
        if (id == element.dropId) {
          selectedtobepaidin.value = element.dropValue.toString();
          break;
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }

  getTypeofHours(String id) async {
    try {
      for (var element in ftypeofhourslist) {
        if (id == element.dropId) {
          selectedtypeofhours.value = element.dropValue.toString();
          break;
        }
      }
    } catch (e) {
      log(e.toString());
    }
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

// for service date button
  Future pickServiceDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: servicedate ?? initialDate,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime.now().subtract(const Duration(days: 0)),
    );
    if (newDate == null) return;

    servicedate = newDate;
    serviceDate.value = getDateFormatText(servicedate);
  }

  String getDateFormatText(DateTime? date) {
    if (date == null) {
      return 'dd/mm/yyyy';
    } else {
      return DateFormat('dd/MM/yyyy').format(date);
    }
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
      return '$hours:$minutes';
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

  Future<void> getLabourHours(String idofTypeofHours, String contractID, String totaleTime) async {
    dioClient.get(AppUrl.labourhour + idofTypeofHours + '&ctrct_val=' + contractID + '&ttl_val=' + totaleTime).then((value) {
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

  serielInfo(String serialID, int chipIndex, String chipSerial) async {
    await dioClient.get(AppUrl.serialinfo + serialID).then((value) {
      if (value['success']) {
        log(value.toString());
        // var objC = SerialInfoModel.fromJson(value);
        String oldPurpose = value['data']['purpose'];
        if (((oldPurpose != 'STOCK') || (oldPurpose != 'SFIT')) && oldPurpose != idofselectedcompany.value) {
          changePurpose(value, chipIndex, chipSerial);
        } else {
          var k = T4(
            item: value['data']['item'].toString(),
            quantity: value['data']['quantity'].toString(),
            purpose: value['data']['purpose'].toString(),
            serialNo: value['data']['serial_no'].toString(),
            sp: value['data']['sp'].toString(),
            itemDes: value['data']['purpose'].toString(),
            userdesc: value['data']['usr_desc'].toString(),
            uom: value['data']['purpose'].toString(),
          );

          wshopinfo.add(k);

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
      content: SizedBox(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text('You are going to change the current purpose'),
                SizedBox(height: 10),
                Text('Purpose : ${val['data']['purpose']} --> New Purpose : ${setCompany.value}'),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: 100,
                        child: appButton(() async {
                          // val['purpose'] = setCompany;
                          // val['purpose'] = selectedcompany.value;

                          var k = T4(
                            item: val['data']['item'].toString(),
                            quantity: val['data']['quantity'].toString(),
                            purpose: val['purpose'] = setCompany,
                            serialNo: val['data']['serial_no'].toString(),
                            sp: val['data']['sp'].toString(),
                            itemDes: val['data']['item_des'].toString(),
                            userdesc: val['data']['item_des'].toString(),
                            uom: val['data']['uom'].toString(),
                          );

                          wshopinfo.add(k);

                          // delete chip
                          deleteChips(cindex, cserial);
                          Get.back();
                        }, 'Yes', AppColor.mainBlueColor)),
                    SizedBox(width: 10),
                    SizedBox(
                      width: 100,
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
      titleStyle: TextStyle(color: Colors.black),
      radius: 5,
    );
  }

  // delete selected serial numbers from interface
  Future<void> deleteChips(int index, String serial_no) async {
    try {
      print('remove index --> $index');
      final index1 = serialchips.indexWhere((element) => element.index == index);

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
    totalcost.value = wshopinfo.fold(0, (sum, element) {
      double a = double.parse(element.sp);
      double b = double.parse(element.quantity);
      return sum + (a * b);
    });

    print(totalcost.value);
  }

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
        return croplist.itemDes.toLowerCase().contains(value.toLowerCase().toString());
      }).toList());
    }
  }

  searchBySeriels(String itemID) {
    serialchips.clear();

    dioClient.get(AppUrl.serialchips + itemID + '&customer_id=' + idofselectedcompany.value).then((value) {
      if (value['success']) {
        if (value['data'].isNotEmpty) {
          int index = 0;
          for (var element in value['data']) {
            //int index = element;
            var serial_no = element['serial_no'];
            SerialChips serialchipsobj = SerialChips(index: index, serial_no: serial_no);

            serialchips.add(serialchipsobj);

            print(index);
            index++;
          }
          return serialchips;
        } else {
          log('featch values are null');
          Utils.getXsnackBar('Not Found', 'Sorry ! currnently not available Serial Numbers');
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

  editAllData() async {
    if (idofselectedengineer == '') {
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
    if (requestTime == 'hh:mm') {
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
    if (traveltime == '') {
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
    isUpdating.value = true;
    // toJson(2);
    await dioClient.post(AppUrl.submitalldata, toJson()).then((value) {
      log('>><<$value');
      if (value['success']) {
        isUpdating.value = false;
        Utils.appDialog('Success', value['message'], () {
          // Get.toNamed(Routes.DASHBOARD);
          Get.offAllNamed(Routes.DASHBOARD);
        });
      } else {
        isUpdating.value = false;
        Utils.appDialog('Not Success', value['message'], () {
          Get.back();
        });
      }
      log(value.toString());
    }).onError((error, stackTrace) {
      isUpdating.value = false;
      log(error.toString());
    });
  }

  /// <--------------- close step 04 funtions ------------------------>
  Map<String, dynamic> toJson() {
    Map<String, dynamic> submitData = {
      "paction": 'edit',
      "site": idofselectedsite.toString(),
      "totalTime": totaltiemcalculated.toString(),
      "assetNo": assetno.toString(),
      "requestDate": requestDate.toString(),
      // "requestTime": requestTime.toString(),
      // "customer_id": idofselectedcompany.toString(),
      "serviceDate": serviceDate.toString(),
      "startTime": startTime.toString(),
      "no_starttime": isStartTimeAddLater.value ? '1' : '0',
      "endTime": endTime.toString(),
      "no_endtime": isEndTimeAddLater.value ? '1' : '0',
      "serviceFormType": 'Fldsvc',
      // "engineer": idofselectedengineer.toString(),
      // "productType": idofselectedproducttype.toString(),
      "priorityLevel": priority.toString(),
      "problem": problemcontroller.text.toString(),
      "typeOfHours": idofselectedtypeofhours.toString(),
      "location": 'TEMP',
      "finding": findingcontroller.text.toString(),
      "workUndertaken": workUndercontroller.text.toString(),
      "labour": valueofLabourHours.toString(),
      "inWarranty": iswarrenty.value ? '1' : '0',
      // "inWarranty": '1',
      // "notAvailable": false,
      "toBePaidIn": idofselectedtobepaidin.toString(),
      "contract": idofselectedcontarct.toString(),
      // "travelTime": traveltimecontroller.text.toString(),
      "requestNo": reqestionNo.toString(),
      // "sTicketNumber": ticketNocontroller.text.toString(),
      "recommendation": recommendationcontroller.text.toString(),
      "askTask": actiontaskcontroller.text.toString(),
      "partsUsed": convertToSaveAPI(wshopinfo),
    };

    log('submit data >> $submitData');
    return submitData;
  }

  // convert to save - serial info list
  List convertToSaveAPI(List oldList) {
    try {
      if (oldList.isEmpty) {
        return [];
      } else {
        convertedSerialInfoList.clear();
        for (var element in oldList) {
          SendSerialInfoToSaveAPI sendSerialInfoToSaveAPIObj = SendSerialInfoToSaveAPI(
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
}
