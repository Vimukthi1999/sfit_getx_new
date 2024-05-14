// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sfit_getx/app/modules/sfview/row_source.dart';
import 'package:sfit_getx/app/modules/sfview/views/preview_view.dart';
import 'package:sfit_getx/res/theme/app_colors.dart';
import 'package:sfit_getx/res/widgets/app_button.dart';
import '../../../res/widgets/app_custom_text_styles.dart';
import '../../../res/widgets/app_header.dart';
import 'sfview_controller.dart';

class SfviewView extends GetView<SfviewController> {
  var argumentData = Get.arguments;
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      controller.fetchData(argumentData[0]);
    });
    return SafeArea(
      child: Scaffold(
        key: controller.scaffoldKey,
        drawer: Container(
          color: Colors.grey[350],
          width: Get.width * 0.5,
          height: Get.height,
          child: PreviewView(),
        ),
        body: 
            Obx(
              () => Column(
                children: [
                  buildPreviewHeader(context, argumentData[1] == 'view' ? 'View Service Entries' : 'Delete Service Entries', controller.openDrower),
                  Expanded(
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      controller: controller.sfviewMainlist,
                      children: [
                        // add service record form
                        Padding(
                          padding: EdgeInsets.all(10.w),
                          child: Card(
                            shadowColor: Colors.black,
                            elevation: 2.w,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(10.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // card title
                                  appcardviewTitle('ADD SERVICE RECORD FORM'),
                                  SizedBox(height: 20.h),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(child: item(true, 'Company Name', controller.Obj.value.data?.svcData[0].companyName.toString() ?? 'N/A')),
                                      ),
                                      SizedBox(width: 10.w),
                                      Expanded(
                                        child: Container(
                                          child: item(true, 'Site', controller.Obj.value.data?.svcData[0].siteName.toString() ?? 'N/A'),
                                        ),
                                      ),
                                      // const SizedBox(width: 5),
                                    ],
                                  ),
        
                                  Row(
                                    children: [
                                      Expanded(
                                        child: item(true, 'Contracts', controller.Obj.value.data?.svcData[0].contractDescription.toString() ?? 'N/A'),
                                      ),
                                      SizedBox(width: 10.w),
                                      Expanded(
                                        child: item(false, 'Asset No', controller.Obj.value.data?.svcData[0].sfitAssetNo.toString() ?? 'N/A'),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        // service recode form
                        Padding(
                          padding: EdgeInsets.all(10.w),
                          child: Card(
                            shadowColor: Colors.black,
                            elevation: 2.w,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(10.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // card title
                                  appcardviewTitle('ADD SERVICE RECORD FORM'),
        
                                  SizedBox(height: 20.w),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: item(true, 'Request Date', controller.Obj.value.data?.svcData[0].requestedDate.toString() ?? 'N/A'),
                                      ),
                                      SizedBox(width: 10.w),
                                      Expanded(
                                        child: item(true, 'Request No', controller.Obj.value.data?.svcData[0].requisitionNo.toString() ?? 'N/A'),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: item(true, 'Request Time', controller.Obj.value.data?.svcData[0].requestedTime.toString() ?? 'N/A'),
                                      ),
                                      SizedBox(width: 10.w),
                                      Expanded(
                                        child: item(true, 'Service Date', controller.Obj.value.data?.svcData[0].startDate.toString() ?? 'N/A'),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: warrantyCheckBox(),
                                      ),
                                      const SizedBox(width: 20),
                                      Expanded(
                                        child: item(true, 'Start Time', controller.Obj.value.data?.svcData[0].noStarttime.toString() == '1' ? 'To Be Determined' : controller.Obj.value.data?.svcData[0].startTime.toString() ?? 'N/A'),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: item(true, 'Priority Level', controller.Obj.value.data?.svcData[0].priorityLevel.toString() ?? 'N/A'),
                                      ),
                                      SizedBox(width: 10.w),
                                      Expanded(
                                        child: item(true, 'End Time', controller.Obj.value.data?.svcData[0].noEndtime.toString() == '1' ? 'To Be Determined' : controller.Obj.value.data?.svcData[0].endTime.toString() ?? 'N/A'),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: item(false, 'Engineer', controller.Obj.value.data?.svcData[0].empname.toString() ?? 'N/A'),
                                      ),
                                      SizedBox(width: 10.w),
                                      Expanded(
                                        child: item(true, 'Travel Time', controller.Obj.value.data?.svcData[0].travelTime.toString() ?? 'N/A'),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: item(false, 'Total Hours Changed', controller.Obj.value.data?.svcData[0].totalTime.toString() ?? 'N/A'),
                                      ),
                                      SizedBox(width: 10.w),
                                      Expanded(
                                        child: Container(),
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    color: Colors.grey,
                                    thickness: 1.w,
                                  ),
                                  SizedBox(height: 5.h),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: item(false, 'Product Type', controller.desProductType.value.toString()),
                                      ),
                                      SizedBox(width: 10.w),
                                      Expanded(
                                        child: Container(
                                          child: item(false, 'Serial/Ticket Number', controller.Obj.value.data?.svcData[0].srlIntgrtd.toString() ?? 'N/A'),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: item(true, 'Type of Hours', controller.desTypeofHours.value.toString()),
                                      ),
                                      const SizedBox(width: 20),
                                      Expanded(
                                        child: Container(
                                          child: item(false, 'Labour', controller.Obj.value.data?.svcData[0].agreedLabourCost.toString() ?? 'N/A'),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: item(true, 'To be Paid In', controller.Obj.value.data?.svcData[0].duedaysInvoice.toString() ?? 'N/A'),
                                      ),
                                      const SizedBox(width: 20),
                                      Expanded(
                                        child: Container(),
                                      ),
                                    ],
                                  ),
                                  // problems
                                  Row(
                                    children: [
                                      Expanded(
                                        child: item(false, 'Problem ', controller.Obj.value.data?.svcData[0].problems.toString() ?? 'N/A'),
                                      ),
                                    ],
                                  ),
                                  // findings
                                  Row(
                                    children: [
                                      Expanded(
                                        child: item(false, 'Findings', controller.Obj.value.data?.svcData[0].findings.toString() ?? 'N/A'),
                                      ),
                                    ],
                                  ),
                                  // work undertaken
                                  Row(
                                    children: [
                                      Expanded(
                                        child: item(false, 'Work Undertaken', controller.Obj.value.data?.svcData[0].workUndertaken.toString() ?? 'N/A'),
                                      ),
                                    ],
                                  ),
                                  // recommendation
                                  Row(
                                    children: [
                                      Expanded(
                                        child: item(false, 'Recommendations', controller.Obj.value.data?.svcData[0].recommendations.toString() ?? 'N/A'),
                                      ),
                                    ],
                                  ),
                                  // action task
                                  Row(
                                    children: [
                                      Expanded(
                                        child: item(false, 'Action Task', controller.Obj.value.data?.svcData[0].actionTask.toString() ?? 'N/A'),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // part cost for service from
                        // Padding(
                        //   padding: EdgeInsets.all(10.w),
                        //   child: Card(
                        //     shadowColor: Colors.black,
                        //     elevation: 2,
                        //     shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(10.r),
                        //     ),
                        //     child: Padding(
                        //       padding: EdgeInsets.all(10.w),
                        //       child: Column(
                        //         crossAxisAlignment: CrossAxisAlignment.start,
                        //         children: [
                        //           // card title
                        //           appcardviewTitle('PART COST FOR SERVICE FORM'),
                        //           SizedBox(height: 20.h),
                        //           // Container(
                        //           //   width: double.infinity,
                        //           //   child: Container(child: hasData ? buildDataTable() : buildNoDataTable()
                        //           //       // Visibility(
                        //           //       //   visible: hasData,
                        //           //       //   child: buildDataTable(),
                        //           //       // ),
                        //           //       ),
                        //           // ),
                        //           SizedBox(height: 20.h),
                        //           const Divider(color: Colors.grey),
                        //           // show btn pnl
                        //           // buildButtonPnl(),
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // ),
        
                        buildTblcard(context),
                      ],
                    ),
                  )
                ],
              ),
            ),
          
      ),
    );
  }

  // check box
  Widget warrantyCheckBox() {
    return Padding(
      padding: EdgeInsets.only(left: 10.w),
      child: SizedBox(
        // height: 90.h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'In Warranty',
              style: TextStyle(
                fontSize: 18.sp,
              ),
            ),
            SizedBox(height: 8.h),
            Container(
              color: Colors.black12,
              child: Transform.scale(
                scale: 1.75.w,
                child: Obx(
                  () => Checkbox(
                    checkColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                    value: controller.Obj.value.data?.svcData[0].warranty.toString() == '0' ? false : true,
                    // value: controller.iswarrenty.value,
                    onChanged: (val) {
                      // controller.iswarrenty.value = val!;
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // table card
  Widget buildTblcard(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.w),
      child: Card(
        shadowColor: Colors.black,
                            elevation: 2.w,
        child: Column(
          children: [
            // data table
            Container(
              width: double.infinity,
              child: Obx(
                () => controller.myData.length == 0
                    ? NoDataTable()
                    : PaginatedDataTable(
                        rowsPerPage: controller.rowsPerPage.value,
                        columnSpacing: 20.w,
                        dataRowMinHeight: 40.w,
                        columns: [
                          DataColumn(label: appitemtableHeadertxt('ITEM')),
                          DataColumn(label: appitemtableHeadertxt('DESCRIPTION')),
                          DataColumn(label: appitemtableHeadertxt('COST')),
                          DataColumn(label: appitemtableHeadertxt('PURPOSE')),
                          DataColumn(label: appitemtableHeadertxt('SERIAL NO')),
                          DataColumn(label: appitemtableHeadertxt('QTY')),
                        ],
                        source: RowSource(
                          myData: controller.myData,
                          count: controller.myData.length,
                        ),
                        availableRowsPerPage: const <int>[2, 5, 7, 50],
                        onRowsPerPageChanged: (value) {
                          controller.rowsPerPage.value = value!;
                        },
                      ),
              ),
            ),
            Align(
              child: Obx(() => Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.w),
                    child: appnormaltxt("Total Cost : " + controller.totalcost.value.toString()),
                  )),
              alignment: Alignment.centerRight,
            ),
            SizedBox(height: 5.w),
            Padding(
              padding: EdgeInsets.all(8.0.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  argumentData[1] == 'view'
                      ? SizedBox(
                          width: 200.w,
                          child: appButton(() {
                            Get.back();
                          }, 'OK', AppColor.mainBlueColor))
                      : SizedBox(
                          width: 200.w,
                          child: appLoadingButton(Colors.red, () {
                            // showRequestAppDialog(context, icon: Icons.warning_amber_rounded, description: 'Do you need delete this recode ?', yes: () {}, no: () {});
                            needShowDeletePermision();
                          }, 'Delete', false),
                        )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget NoDataTable() {
    return Container(
      child: Column(
        children: [
          // table topis
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h).copyWith(bottom: 5.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Center(child: appitemtableHeadertxt('ITEM')),
                ),
                Expanded(
                  child: Center(child: appitemtableHeadertxt('DESCRIPTION')),
                ),
                Expanded(
                  child: Center(child: appitemtableHeadertxt('COST')),
                ),
                Expanded(
                  child: Center(child: appitemtableHeadertxt('PURPOSE')),
                ),
                Expanded(
                  child: Center(child: appitemtableHeadertxt('QTY')),
                ),
              ],
            ),
          ),

          Divider(
            thickness: 1.w,
            color: Colors.black12,
            endIndent: 20.w,
            indent: 20.w,
          ),
          // msg
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                appitemtableDatatxt(
                  'has not data',
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget item(bool isreq, String title, String value) {
    return Container(
      padding: EdgeInsets.only(left: 10.w, bottom: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RichText(
            text: TextSpan(
              text: title,
              style: TextStyle(fontSize: 18.sp, color: Colors.black),
              children: [
                TextSpan(
                  text: ' *',
                  style: TextStyle(
                    color: isreq ? Colors.red : Colors.transparent,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                  ),
                )
              ],
            ),
            textAlign: TextAlign.left,
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: 55.w,
            ),
            child: Container(
              margin: EdgeInsets.only(top: 7.w),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.all(
                  Radius.circular(3.r),
                ),
              ),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Text(
                      value,
                      style: TextStyle(fontSize: 18.sp),
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }

  // delete permision dialog
  void needShowDeletePermision() {
    Get.defaultDialog(
      title: 'Do you need delete this recode ?',
      content: SizedBox(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8.w),
            child: Column(
              children: [
                SizedBox(height: 15.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 100.w,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: appButton(() {
                          Get.back();
                        }, 'No', AppColor.mainBlueColor),
                      ),
                    ),
                    SizedBox(width: 20.w),
                    SizedBox(
                        width: 100.w,
                        child: appLoadingButton(
                          AppColor.mainBlueColor,
                          () async {
                          // Get.back();
                          controller.deleteServiceForm();
                        }, 'Yes', controller.isDeleting.value)),
                    
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      titleStyle: TextStyle(color: Colors.black, fontSize: 18.sp),
      titlePadding: EdgeInsets.all(20.w).copyWith(bottom: 0),
      radius: 5.r,
    );
  }
}
