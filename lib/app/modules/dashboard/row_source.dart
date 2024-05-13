import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sfit_getx/app/data/models/sf_from_model.dart';
import 'package:sfit_getx/app/modules/dashboard/dashboard_controller.dart';
import 'package:sfit_getx/res/app_url.dart';

import '../../../res/widgets/app_custom_text_styles.dart';
import '../../../utils/utils.dart';
import '../../data/network/dio_client.dart';
import '../../routes/app_pages.dart';

class RowSource extends DataTableSource {
  var myData;
  final count;

  RowSource({required this.myData, required this.count});

  @override
  DataRow? getRow(int index) {
    // print('----------------------------->>> $index');
    // print('----------------------------->>> $rowCount');
    if (index < rowCount) {
      // return getDataRow(myData![index], index);
      return getDataRow(myData![index], index);
    } else {
      return null;
    }
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => count;

  @override
  int get selectedRowCount => 0;
}

DataRow getDataRow(var data, int index) {
  bool isengOk = false;
  bool iscusOk = false;
  bool isIcon = true;

  DatumSFfrom Obj = data;
  final dashboadController = Get.find<DashboardController>();

  print('-------${Obj.requisitionNo}-----------0000000000000----------->>> ${Obj.option.email}');
  print('------------------0000000000000----------->>> $index');

  isengOk = Obj.signEngineer.toString() == '1' ? true : false;
  iscusOk = Obj.signCustomer.toString() == '1' ? true : false;
  // dashboadController.isemailon[index] = Obj.option.email;

  // dashboadController.isemailon.add(Obj.option.email);

  // dashboadController.isemailon.clear();

  // for (var obj in dashboadController.sfBig.value.data) {
  //   dashboadController.isemailon.add(RxBool(obj.option.email));
  // }

  // for (var obj in Obj.option.email) {
  dashboadController.isemailon.add(RxBool(Obj.option.email));
  // }

  print("----------------------------isemailon --- ${dashboadController.isemailon.length}");

  if (Obj.signCustomer.toString().isEmpty || Obj.signCustomer.toString().length > 1) {
    isIcon = false;
  } else {
    if (Obj.signCustomer == '1') iscusOk = true;
  }

  log('signEngineer > ' + '${Obj.signEngineer}' + " ---- " + '${Obj.signCustomer}');
  // dashboadController.isemailon.value = dashboadController.myData[index].option.email;
  // bool isEmailOn = dashboadController.isemailon[index];
  RxBool isEmailOn = dashboadController.isemailon[index];
  return DataRow(
    cells: [
      DataCell(appitemtableDatatxt(Obj.requisitionNo.toString())),
      DataCell(Container(
          width: 200.w,
          child: appitemtableDatatxt(
            Obj.companyName.toString(),
            // overflow: TextOverflow.ellipsis,
          ))),
      DataCell(appitemtableDatatxt(Obj.contractId.toString())),
      DataCell(appitemtableDatatxt(Obj.startDate.toString())),
      DataCell(appitemtableDatatxt(Obj.requestedDate.toString())),
      DataCell(appitemtableDatatxt(Obj.engineer.toString())),
      DataCell(
        Center(
            child: isengOk
                ? FaIcon(
                    FontAwesomeIcons.circleCheck,
                    color: Colors.green,
                    size: 20.w,
                  )
                : FaIcon(
                    FontAwesomeIcons.circleQuestion,
                    size: 20.w,
                  )),
      ),
      DataCell(
        Center(
          child: isIcon
              ? iscusOk
                  ? FaIcon(
                      FontAwesomeIcons.circleCheck,
                      color: Colors.green,
                      size: 20.w,
                    )
                  : FaIcon(
                      FontAwesomeIcons.circleQuestion,
                      size: 20.w,
                    )
              : appitemtableDatatxt(Obj.signCustomer.toString()),

          // child: FaIcon(FontAwesomeIcons.circleQuestion),
        ),
      ),
      DataCell(
        Row(
          children: [
            // edit
            Visibility(
              visible: Obj.option.edit,
              // edit
              child: Padding(
                padding: EdgeInsets.only(right: 5.h),
                child: IconButton(
                  icon: const FaIcon(FontAwesomeIcons.penToSquare),
                  onPressed: () async {
                    Get.toNamed(Routes.SFEDIT, arguments: Obj.requisitionNo.toString());
                  },
                  iconSize: 20.w,
                ),
              ),
            ),

            // delete
            Visibility(
              visible: Obj.option.delete,
              child: Padding(
                padding: EdgeInsets.only(right: 5.h),
                child: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    Get.toNamed(Routes.SFVIEW, arguments: [Obj.requisitionNo.toString(), 'delete']);
                  },
                  iconSize: 23.w,
                  color: Colors.red,
                ),
              ),
            ),

            // search / view
            Visibility(
              visible: Obj.option.view,
              child: Padding(
                padding: EdgeInsets.only(right: 5.h),
                child: IconButton(
                  icon: const Icon(Icons.remove_red_eye_rounded),
                  onPressed: () async {
                    Get.toNamed(Routes.SFVIEW, arguments: [Obj.requisitionNo.toString(), 'view']);
                  },
                  iconSize: 20.w,
                  color: Colors.grey,
                ),
              ),
            ),

            // email
            Obx(
              () => Visibility(
                visible: isEmailOn.value,
                // visible: dashboadController.isemailon[index],
                child: Padding(
                  padding: EdgeInsets.only(right: 5.h),
                  child: IconButton(
                    icon: const Icon(Icons.email),
                    onPressed: () async {
                      try {
                        // chage icon
                        DioClient dioClient = DioClient();
                        dioClient.get(AppUrl.sendemail + Obj.requisitionNo).then((value) {
                          if (value['success']) {
                            Utils.getXSuccesssnackBar(value['messages']['send_email']);
                            dashboadController.isemailon[index].value = false;
                          } else {
                            Utils.getXsnackBar('Not Successfull', value['message'].toString());
                          }
                        }).onError((error, stackTrace) {
                          log(error.toString());
                        });
                      } catch (e) {
                        log(e.toString());
                      }
                    },
                    iconSize: 23.w,
                    color: Colors.blue[700],
                  ),
                ),
              ),
            ),

            // email forword
            Obx(
              () => Visibility(
                visible: !isEmailOn.value,
                // visible: !dashboadController.isemailon[index],
                child: Padding(
                  padding: EdgeInsets.only(right: 5.h),
                  child: IconButton(
                    icon: const FaIcon(FontAwesomeIcons.share),
                    onPressed: () async {
                      // await tableOption.sentEmail(index, reg);
                    },
                    iconSize: 20.w,
                    color: Colors.blue[700],
                  ),
                ),
              ),
            ),

            // $
            Visibility(
              visible: Obj.option.signature,
              child: Padding(
                padding: EdgeInsets.only(right: 5.h),
                child: IconButton(
                  icon: const FaIcon(FontAwesomeIcons.signature),
                  onPressed: () async {
                    // String values = 'index - $index - reg - $reg';

                    // SharedPref sharedPref = SharedPref();
                    // await sharedPref.saveRequisitionNo(reg);

                    // if (!engIsOk) {
                    //   NavigationService.instance.navigateWithValues("/bothsignatures");
                    // } else {
                    //   NavigationService.instance.navigateWithValues("/signature");
                    // }
                    Get.toNamed(Routes.SINGATURE, arguments: {"reqno": Obj.requisitionNo.toString(), "engSign": isengOk});
                  },
                  iconSize: 20.w,
                  color: Colors.green,
                ),
              ),
            ),

            // print
            Visibility(
              visible: Obj.option.print,
              child: Padding(
                padding: EdgeInsets.only(right: 5.h),
                child: IconButton(
                  icon: const FaIcon(FontAwesomeIcons.filePdf),
                  onPressed: () async {
                    Get.toNamed(Routes.PDF, arguments: Obj.requisitionNo.toString());
                  },
                  iconSize: 20.w,
                  color: Colors.blue[900],
                ),
              ),
            ),

            // testing
            // delete
            // Visibility(
            //   visible: true,
            //   child: IconButton(
            //     icon: const Icon(Icons.circle),
            //     onPressed: () async {
            //       print('delete on id - $index $reg');
            //       // try to delete row
            //       // chage icon
            //       print(data[index]);
            //       data.removeAt(index);
            //       notifyListeners();
            //     },
            //     iconSize: 20,
            //     color: Colors.yellow[900],
            //   ),
            // ),
          ],
        ),
      
      ),
    ],
  );
}
