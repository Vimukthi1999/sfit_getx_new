import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sfit_getx/app/data/models/company_dp_model.dart';
import 'package:sfit_getx/app/data/models/sf_from_model.dart';
import 'package:sfit_getx/app/data/network/dio_client.dart';
import 'package:sfit_getx/res/app_url.dart';
import 'package:sfit_getx/utils/utils.dart';

import '../../data/models/contract_dp_model.dart';
import '../../data/models/engineer_dp_model.dart';
import '../../data/models/sf_data_model.dart';
import '../../data/models/site_dp_model.dart';

class DashboardController extends GetxController {
  DioClient dioClient = DioClient();
  TextEditingController controllerSearch = TextEditingController();
  // DataTableSource data = DataTableView([]);
  var isCheckIgnoreDate = false.obs;

  // var isemailon = <bool>[].obs;
  var isemailon = <RxBool>[].obs;

  Map<String, dynamic> temsearchoption = {};

  // dp lists
  var companylist = <DatumCompany>[].obs;
  var sitelist = <DatumSite>[].obs;
  var contarctlist = <DatumContract>[].obs;
  var engineerlist = <DatumEngineer>[].obs;

  // filter dp lists
  var fcompanylist = <DatumCompany>[].obs;
  var fsitelist = <DatumSite>[].obs;
  var fcontarctlist = <DatumContract>[].obs;
  var fengineerlist = <DatumEngineer>[].obs;

  // selected dp values
  var selectedcompany = 'Choose one'.obs;
  var selectedsite = 'Choose one'.obs;
  var selectedcontract = 'Choose one'.obs;
  var selectedorderby = 'Choose one'.obs;
  var selectedengineer = 'Choose one'.obs;

  // id of selected dp values
  var idofselectedcompany = ''.obs;
  var idofselectedsite = ''.obs;
  var idofselectedcontarct = ''.obs;
  var idofselectedoderby = ''.obs;
  var idofselectedengineer = ''.obs;

  // time pickers
  DateTime pickedDateFrom = DateTime.now();
  DateTime pickedDateTo = DateTime.now();

  var startdate = ''.obs;
  var enddate = ''.obs;

  // table
  var rowsPerPage = 5.obs;
  var filterData = <Data>[].obs;
  var initrowindex = 0.obs;

  // setter
  void set setAme(String name) {
    selectedsite.value = name;
  }

  var sfBig = SfFromModel(data: []).obs;
  var myData = <DatumSFfrom>[].obs;
  var temmyData = <DatumSFfrom>[].obs;

  var isSearching = false.obs;

  // set order by dp values
  List<Map<String, dynamic>> orderbylist = [
    {'drop_id': "start_date", 'drop_value': "Service date"},
    {'drop_id': "requested_date", 'drop_value': "Requested date"}
  ].obs;

  // -------------------------------------------------

  final RxInt currentPage = 1.obs;
  final RxInt itemsPerPage = 10.obs;
  final RxString filterText = ''.obs;

  var isrefresh = false.obs;

  get filteredData {
    return myData
        .where(
          (item) => item.requisitionNo.toLowerCase().contains(
                filterText.value.toLowerCase(),
              ),
        )
        .toList();
  }

  fetchFilterDate() {
    return filteredData.skip((currentPage.value - 1) * itemsPerPage.value).take(itemsPerPage.value).toList();
  }

  // -------------------------------------------------

  @override
  void onInit() {
    super.onInit();
    // set values
    fetchCompany();
    fetchEngineer();

    startdate.value = DateFormat('dd/MM/yyyy').format(DateTime.now());
    enddate.value = DateFormat('dd/MM/yyyy').format(DateTime.now());

    idofselectedoderby.value = orderbylist[0]['drop_id'];
    selectedorderby.value = orderbylist[0]['drop_value'];
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void fromDate(BuildContext context) async {
    final DateTime? pickeddate = await showDatePicker(context: context, initialDate: pickedDateFrom, firstDate: DateTime(DateTime.now().year - 5), lastDate: DateTime(DateTime.now().year + 5));

    if (pickeddate != null) {
      pickedDateFrom = pickeddate;
      //startdate = pickeddate.toString();
      startdate.value = DateFormat('dd/MM/yyyy').format(pickedDateFrom);
      print(startdate);
    }
  }

  // use for get to date
  void toDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );
    if (picked != null) {
      pickedDateTo = picked;
      // enddate = pickedDateTo.toString();
      enddate.value = DateFormat('dd/MM/yyyy').format(pickedDateTo);
      print(enddate);
    }
  }

  fetchCompany() {
    companylist.clear();
    fcompanylist.clear();

    dioClient.get(AppUrl.customerdp).then((value) {
      // print(value.toString());
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
      // fcompanylist.addAll(companylist.where((croplist) => croplist.companyName.contains(value.toString())).toList());

      fcompanylist.addAll(companylist.where((croplist) {
        return croplist.dropValue.toLowerCase().contains(value.toLowerCase().toString());
      }).toList());
    }
    log('2----------------' + fcompanylist.length.toString());
    log('2++++++++++++++++' + companylist.length.toString());
  }

  fetchSite(String selectcompanyid) {
    sitelist.clear();
    fsitelist.clear();

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
        return croplist.dropValue.toLowerCase().contains(value.toLowerCase().toString());
      }).toList());
    }
  }

  fetchContarct(String selectsiteid) {
    contarctlist.clear();
    fcontarctlist.clear();

    dioClient.get(AppUrl.contractdp + selectsiteid).then((value) {
      var objC = ContractDpModel.fromJson(value);
      if (value['success']) {
        for (var element in objC.data) {
          // log(element.dropId);
          contarctlist.add(element);
        }
        try {
          fcontarctlist.addAll(contarctlist);
        } catch (e) {
          print(e.toString());
        }
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
        return croplist.dropValue.toLowerCase().contains(value.toLowerCase().toString());
      }).toList());
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
        return croplist.dropValue.toLowerCase().contains(value.toLowerCase().toString());
      }).toList());
    }
  }

  // service form search
  void searchForm() {
    myData.clear();
    temmyData.clear();
    controllerSearch.clear();

    //---------------------------------
    isSearching.value = true;
    // isemailon.clear();
    temsearchoption.clear();
    try {
      var postJson = toJson();
      temsearchoption.addAll(postJson);
      // var res = SfFromModel.fromJson(sfitJson);
      log(postJson.toString());

      dioClient.post(AppUrl.search_field_sevice_entries, postJson).then((value) {
        log(value.toString());
        // if (value != null) {
        if (value['data'].length == 0) {
          Utils.getXsnackBar('Not Successfull', 'No Data found');
          isSearching.value = false;
        } else {
          sfBig.value = SfFromModel.fromJson(value);
          // log(sfBig.toString());

          myData.value = sfBig.value.data;
          temmyData.addAll(myData);

          print(myData.length);
          print(temmyData.length);

          isSearching.value = false;

          // print('-------------------------------${sfBig.value.data.toString()}');
        }
      }).onError((error, stackTrace) {
        log('message -- $error');
        isSearching.value = false;
      });
    } catch (e) {
      print(e);
      isSearching.value = false;
    }
  }

  int get totalPageCount {
    return (filteredData.length / itemsPerPage.value).ceil();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> filterqueryParameters = Map<String, dynamic>();

    if (isCheckIgnoreDate.value) {
      filterqueryParameters['from'] = '';
      filterqueryParameters['to'] = '';
      filterqueryParameters['ignr'] = 'on';
    } else {
      filterqueryParameters['from'] = startdate.toString();
      filterqueryParameters['to'] = enddate.toString();
      filterqueryParameters['ignr'] = '';
    }
    filterqueryParameters['customer_id'] = idofselectedcompany;
    filterqueryParameters['site'] = idofselectedsite;
    filterqueryParameters['contract'] = idofselectedcontarct;
    filterqueryParameters['orderBy'] = idofselectedoderby;
    filterqueryParameters['engineer'] = idofselectedengineer;

    print('search data >> $filterqueryParameters');

    return filterqueryParameters;
  }

  // clearing old selection values
  clearSelectedValues(int which) {
    // case 1 : when click company dp
    // case 2 : when click site
    // case 3 : when click clear filter btn

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
        break;

      case 2:
        selectedsite.value = 'Choose one';
        idofselectedsite.value = '';

        selectedcontract.value = 'Choose one';
        idofselectedcontarct.value = '';
        contarctlist.clear();
        fcontarctlist.clear();
        break;

      case 3:
        startdate.value = DateFormat('dd/MM/yyyy').format(DateTime.now());
        enddate.value = DateFormat('dd/MM/yyyy').format(DateTime.now());

        isCheckIgnoreDate.value = false;

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

        // selectedorderby.value = 'Choose one';
        // idofselectedoderby.value = '';

        idofselectedoderby.value = orderbylist[0]['drop_id'];
        selectedorderby.value = orderbylist[0]['drop_value'];

        selectedengineer.value = 'Choose one';
        idofselectedengineer.value = '';

        break;
      default:
    }
  }

  sortingData(String requisition_no) {
    // if (listofsearchdata.isEmpty) {
    //   //plz filter 1st
    // } else {
    //   // sorting
    // }

    // print(listofsearchdata);

    // final sorteddata = listofsearchdata.where((element){
    //   final requisition = element['requisition_no'].toString();
    //   print('<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>$requisition');
    //   return requisition.contains(requisition_no);
    // }).toList();

    // print(sorteddata);

    temmyData.clear();
    isemailon.clear();
    rowsPerPage.value = 5;
    if (requisition_no.toString() == '') {
      temmyData.addAll(myData);
      print(temmyData.length);
    } else {
      temmyData.addAll(myData.where((croplist) {
        return croplist.requisitionNo.contains(requisition_no.toString());
      }).toList());

      print(temmyData.length);
    }
  }

  // send email
  sendEmail(var obj) async {
    try {
      // chage icon
      DioClient dioClient = DioClient();
      await dioClient.get(AppUrl.sendemail + obj.requisitionNo.toString()).then((value) {
        if (value['success']) {
          Utils.getXSuccesssnackBar(value['messages']['send_email']);
          // print(obj);
          obj.option.email = false;
          obj.option.emailSent = true;
          // dashboadController.isemailon[index].value = false;
        } else {
          Utils.getXsnackBar('Not Successfull', value['message'].toString());
        }
      }).onError((error, stackTrace) {
        log(error.toString());
      });
    } catch (e) {
      log(e.toString());
    }
  }
}

Map<String, dynamic> sfitJson = {
  "data": [
    {
      "company_name": " AIM Commercial Catering Equipment Ltd",
      "contract_id": "SFIT01122013ADEAIMG",
      "requisition_no": "220620230817ASW",
      "start_date": "22/06/2023",
      "requested_date": "22/06/2023",
      "engineer": "Allan Wallace",
      "sign_engineer": 1,
      "sign_customer": 0,
      "option": {"edit": false, "delete": false, "view": true, "email_sent": false, "email": true, "signature": true, "print": true}
    },
    {
      "company_name": "AIM Commercial Catering Equipment Ltd",
      "contract_id": "SFIT01122013ADEAIMG",
      "requisition_no": "190520230758ASM",
      "start_date": "19/05/2023",
      "requested_date": "19/05/2023",
      "engineer": "Alan Mcneil",
      "sign_engineer": 1,
      "sign_customer": 0,
      "option": {"edit": false, "delete": false, "view": true, "email_sent": false, "email": true, "signature": true, "print": true}
    }
  ]
};
