// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../res/theme/app_colors.dart';
import '../../../res/widgets/app_button.dart';
import '../../../res/widgets/app_custom_text_styles.dart';
import '../../../res/widgets/app_datetime_pickers.dart';
import '../../../res/widgets/app_drop_down.dart';
import '../../../res/widgets/app_header.dart';
import '../../data/models/serials_chips.dart';
import 'sfedit_controller.dart';
import 'views/preview_view.dart';

class SfeditView extends GetView<SfeditController> {
  var argumentData = Get.arguments;
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      controller.fetchData(argumentData);
    });
    return SafeArea(
      child: Scaffold(
        // floatingActionButton: FloatingActionButton(onPressed: (){
        //   Utils.getXSuccesssnackBar('wade goda');
        // }),
        key: controller.scaffoldKey,
        drawer: Container(
          color: Colors.grey[350],
          width: Get.width * 0.5,
          height: Get.height,
          child: PreviewView(),
        ),
        body: Obx(
          () => Column(
            children: [
              buildPreviewHeader(
                  context, 'Edit Field Service Entries', controller.openDrower),
              Expanded(
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  controller: controller.sfeditviewScroll,
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
                                    child: Container(
                                        child: item(
                                            true,
                                            'Company Name',
                                            controller.Obj.value.data
                                                    ?.svcData[0].companyName
                                                    .toString() ??
                                                'N/A')),
                                  ),
                                  SizedBox(width: 10.w),
                                  Expanded(
                                    child: Container(
                                      child: item(
                                          true,
                                          'Site',
                                          controller.Obj.value.data?.svcData[0]
                                                  .siteName
                                                  .toString() ??
                                              'N/A'),
                                    ),
                                  ),
                                  // const SizedBox(width: 5),
                                ],
                              ),

                              Row(
                                children: [
                                  Expanded(
                                    child: item(
                                        true,
                                        'Contracts',
                                        controller.Obj.value.data?.svcData[0]
                                                .contractDescription
                                                .toString() ??
                                            'N/A'),
                                  ),
                                  SizedBox(width: 10.w),
                                  Expanded(
                                    child: item(
                                        false,
                                        'Asset No',
                                        controller.Obj.value.data?.svcData[0]
                                                .sfitAssetNo
                                                .toString() ??
                                            'N/A'),
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
                              appcardviewTitle('SERVICE RECORD FORM'),

                              SizedBox(height: 20.w),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          left: 10.w, bottom: 20.w),
                                      child: buildformDateTimePicker(
                                          'Request Date',
                                          controller.requestDate.value,
                                          context,
                                          true, () {
                                        controller.pickRequestDate(context);
                                      }),
                                    ),
                                    // child: item(true, 'Request Date', controller.Obj.value.data?.svcData[0].requestedDate.toString() ?? 'N/A'),
                                  ),
                                  SizedBox(width: 10.w),
                                  Expanded(
                                    child: item(
                                        true,
                                        'Request No',
                                        controller.Obj.value.data?.svcData[0]
                                                .requisitionNo
                                                .toString() ??
                                            'N/A'),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: item(
                                        true,
                                        'Request Time',
                                        controller.Obj.value.data?.svcData[0]
                                                .requestedTime
                                                .toString() ??
                                            'N/A'),
                                  ),
                                  SizedBox(width: 10.w),
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          left: 10.w, bottom: 20.w),
                                      child: buildformDateTimePicker(
                                          'Service Date',
                                          controller.serviceDate.value,
                                          context,
                                          true, () {
                                        controller.pickServiceDate(context);
                                      }),
                                    ),
                                    // child: item(true, 'Service Date', controller.Obj.value.data?.svcData[0].startDate.toString() ?? 'N/A'),
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: warrantyCheckBox(),
                                  ),
                                  SizedBox(width: 20.w),
                                  Expanded(
                                    child: Container(
                                      child: Obx(() =>
                                          buildformAddLaterTimePicker(
                                              'Start Time',
                                              controller.startTime.value,
                                              startTime(
                                                  context,
                                                  controller.isStartTimeAddLater
                                                      .value, () {
                                                controller
                                                    .pickStartTime(context);
                                              }))),
                                    ),
                                    // child: item(true, 'Start Time', controller.Obj.value.data?.svcData[0].noStarttime.toString() == '1' ? 'To Be Determined' : controller.Obj.value.data?.svcData[0].startTime.toString() ?? 'N/A'),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.h),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          left: 10.w, bottom: 20.w),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          appreqtxt('Priority Level'),
                                          Container(
                                              height: 55.w,
                                              width: 200.w,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                color: Colors.black,
                                                width: 1.w,
                                                style: BorderStyle.solid,
                                              )),
                                              child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Obx(
                                                    () => Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            controller
                                                                .dePriority(
                                                                    controller
                                                                        .priority
                                                                        .value);
                                                          },
                                                          child: Icon(
                                                            Icons
                                                                .indeterminate_check_box_rounded,
                                                            size: 55.w,
                                                            color: controller
                                                                        .priority
                                                                        .value ==
                                                                    1
                                                                ? Colors.grey
                                                                : Colors.black,
                                                          ),
                                                        ),
                                                        Container(
                                                          child: Text(
                                                            controller
                                                                .priority.value
                                                                .toString(),
                                                            style: TextStyle(
                                                                fontSize:
                                                                    18.sp),
                                                          ),
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            controller
                                                                .inPriority(
                                                                    controller
                                                                        .priority
                                                                        .value);
                                                          },
                                                          child: Icon(
                                                            Icons
                                                                .add_box_rounded,
                                                            size: 55.w,
                                                            color: controller
                                                                        .priority
                                                                        .value ==
                                                                    3
                                                                ? Colors.grey
                                                                : Colors.black,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ))),
                                        ],
                                      ),
                                    ),

                                    // child: item(true, 'Priority Level', controller.Obj.value.data?.svcData[0].priorityLevel.toString() ?? 'N/A'),
                                  ),
                                  SizedBox(width: 10.w),
                                  Expanded(
                                    child: Container(
                                      child: Obx(() =>
                                          buildformAddLaterTimePicker(
                                              'End Time',
                                              controller.endTime.value,
                                              endTime(
                                                  context,
                                                  controller.isEndTimeAddLater
                                                      .value, () {
                                                controller.pickEndTime(context);
                                              }))),
                                    ),
                                    // child: item(true, 'End Time', controller.Obj.value.data?.svcData[0].noEndtime.toString() == '1' ? 'To Be Determined' : controller.Obj.value.data?.svcData[0].endTime.toString() ?? 'N/A'),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.h),
                              Row(
                                children: [
                                  Expanded(
                                    child: item(
                                        false,
                                        'Engineer',
                                        controller.Obj.value.data?.svcData[0]
                                                .empname
                                                .toString() ??
                                            'N/A'),
                                  ),
                                  SizedBox(width: 10.w),
                                  Expanded(
                                    child: item(
                                        true,
                                        'Travel Time',
                                        controller.Obj.value.data?.svcData[0]
                                                .travelTime
                                                .toString() ??
                                            'N/A'),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: item(false, 'Total Hours Changed',
                                        controller.totaltiemcalculated.value),
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
                              SizedBox(height: 10.h),
                              Row(
                                children: [
                                  Expanded(
                                    child: item(
                                        false,
                                        'Product Type',
                                        controller.desProductType.value
                                            .toString()),
                                  ),
                                  SizedBox(width: 10.w),
                                  Expanded(
                                    child: item(
                                        true,
                                        'Serial/Ticket Number',
                                        controller.Obj.value.data?.svcData[0]
                                                .ticketId
                                                .toString() ??
                                            'N/A'),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          left: 10.w, bottom: 20.w),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          appreqtxt('Type of hours'),
                                          Obx(
                                            () => customDropDowns(
                                                controller.selectedtypeofhours
                                                    .value, () {
                                              Future.delayed(
                                                  const Duration(seconds: 1),
                                                  () {
                                                dpTypeofHoursWidget();
                                              });
                                            }),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // child: item(true, 'Type of Hours', controller.desTypeofHours.value.toString()),
                                  ),
                                  SizedBox(width: 20.w),
                                  Expanded(
                                    child: Container(
                                      child: item(false, 'Labour',
                                          controller.valueofLabourHours.value),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          left: 10.w, bottom: 20.w),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          appreqtxt('To be paid in'),
                                          Obx(
                                            () => customDropDowns(
                                                controller.selectedtobepaidin
                                                    .value, () {
                                              Future.delayed(
                                                  const Duration(seconds: 1),
                                                  () {
                                                dpToBePaidInWidget();
                                              });
                                            }),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // child: item(true, 'To be Paid In', controller.Obj.value.data?.svcData[0].duedaysInvoice.toString() ?? 'N/A'),
                                  ),
                                  SizedBox(width: 20.w),
                                  Expanded(
                                    child: Container(),
                                  ),
                                ],
                              ),

                              buildexpandItems(
                                  true,
                                  'Problem',
                                  'As Stated or Requested by the Client',
                                  controller.problemcontroller),
                              buildexpandItems(
                                  false,
                                  'Findings',
                                  'Initial Investigation',
                                  controller.findingcontroller),
                              buildexpandItems(false, 'Work Undertaken', '',
                                  controller.workUndercontroller),
                              buildexpandItems(false, 'Recommendations', '',
                                  controller.recommendationcontroller),
                              buildexpandItems(false, 'Action Task', '',
                                  controller.actiontaskcontroller),

                              SizedBox(height: 5.h),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(10.w),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        appcardviewTitle(
                                            'PART COST FOR SERVICE FORM'),
                                        SizedBox(height: 25.h),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  appnormaltxt('Items'),
                                                  Obx(
                                                    () => customDropDowns(
                                                        controller.selecteditem
                                                            .value, () async {
                                                      // await controller.fetchItems();
                                                      controller.serialchips
                                                          .clear();
                                                      controller.filteritem('');
                                                      controller.selecteditem
                                                          .value = 'Choose one';
                                                      controller
                                                          .idofselecteditem
                                                          .value = '';
                                                      Future.delayed(
                                                          const Duration(
                                                              seconds: 1), () {
                                                        dpItemsWidget();
                                                      });
                                                    }),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(width: 10.w),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  appnormaltxt(
                                                      'Search by Serials'),
                                                  TextField(
                                                    // controller: _controller,
                                                    decoration: InputDecoration(
                                                      hintText:
                                                          "Search Serials",
                                                      suffixIcon: Icon(
                                                        Icons.search_rounded,
                                                        size: 55.w,
                                                      ),
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(4.r),
                                                        ),
                                                      ),
                                                    ),
                                                    style: TextStyle(
                                                        fontSize: 16.sp),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 20.h),
                                        Container(
                                          child: SingleChildScrollView(
                                              physics: BouncingScrollPhysics(),
                                              child: Obx(() => ChiperBox())),
                                          width: Get.width,
                                          height: 200.h,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                            color: Colors.black,
                                            width: 1.w,
                                            style: BorderStyle.solid,
                                          )),
                                        ),
                                        SizedBox(height: 20.h),
                                        Container(
                                          child: SingleChildScrollView(
                                            child: Container(
                                              height: 300.h,
                                              child: Column(
                                                children: [
                                                  tableHeader(),
                                                  Divider(
                                                    color: Colors.black,
                                                    thickness: 1.w,
                                                    indent: 20.w,
                                                    endIndent: 20.w,
                                                  ),
                                                  Obx(() => tableData()),
                                                  SizedBox(height: 10.h),
                                                  Divider(
                                                    color: Colors.black,
                                                    thickness: 1.w,
                                                    indent: 20.w,
                                                    endIndent: 20.w,
                                                  ),
                                                  Align(
                                                    child: Obx(() => Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      20.w,
                                                                  vertical:
                                                                      8.w),
                                                          child: appnormaltxt(
                                                              "Total Cost : " +
                                                                  controller
                                                                      .totalcost
                                                                      .value
                                                                      .toStringAsFixed(
                                                                          3)),
                                                        )),
                                                    alignment:
                                                        Alignment.centerRight,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            physics: BouncingScrollPhysics(),
                                          ),
                                          width: Get.width,
                                          height: 300.h,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                            color: Colors.black,
                                            width: 1.w,
                                            style: BorderStyle.solid,
                                          )),
                                        ),
                                        // SizedBox(height: 20.h),
                                        // Obx(
                                        //   () => Align(
                                        //     alignment: Alignment.centerRight,
                                        //     child: Container(
                                        //       width: 200,
                                        //       child: appLoadingButton(Theme.of(context).primaryColor, controller.submitAllData, 'Save', controller.isAdding.value),
                                        //     ),
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: 20.h),
                              Obx(
                                () => Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                    width: 200.w,
                                    child: appLoadingButton(
                                        Theme.of(context).primaryColor,
                                        controller.editAllData
                                        //   () {
                                        // log('******${controller.toJson()}');
                                        // log('******${controller.requestdate}');
                                        // log('******${controller.serviceDate}');
                                        // log('******${controller.servicedate}');
                                        // log('******${controller.startTime}');
                                        // log('******${controller.starttime}');
                                        // log('******${controller.endTime}');
                                        // log('******${controller.endtime}');
                                        // }
                                        ,
                                        'Update',
                                        controller.isUpdating.value),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    //-----------------------------------------------

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

                    // buildTblcard(context),
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
            SizedBox(height: 10.h),
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
                    // value: controller.Obj.value.data?.svcData[0].warranty.toString() == '0' ? false : true,
                    value: controller.iswarrenty.value,
                    onChanged: (val) {
                      controller.iswarrenty.value = val!;
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

  // start time
  Widget startTime(BuildContext context, bool ischeck, void Function() click) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 8.w),
          child: Transform.scale(
            scale: 1.25,
            child: Checkbox(
              checkColor: Colors.white,
              activeColor: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2.r),
              ),
              value: ischeck,
              onChanged: (val) {
                ischeck = val!;
                controller.isStartTimeAddLater.value = val;
                if (ischeck) {
                  controller.startTime.value = 'Add Later';
                  controller.sTime = '15000';
                  controller.totaltiemcalculated.value =
                      controller.calculateTotalTime();
                } else {
                  controller.startTime.value = 'hh:mm';
                }
              },
            ),
          ),
        ),
        SizedBox(width: 5.w),
        Padding(
          padding: EdgeInsets.only(right: 8.w, top: 4.h),
          child: appnormaltxt('Add Later'),
        ),
        Container(
          height: 55.h,
          width: 55.w,
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(
                color: Colors.black,
                width: 1.0,
              ),
            ),
          ),
          child: IconButton(
            icon: Icon(
              Icons.access_time_rounded,
              color: Theme.of(context).primaryColor,
              size: 25.w,
            ),
            // tooltip: 'Tap to open date picker',
            onPressed: ischeck ? null : click,
          ),
        )
      ],
    );
  }

// end time
  Widget endTime(BuildContext context, bool ischeck, void Function() click) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 8.w),
          child: Transform.scale(
            scale: 1.25,
            child: Checkbox(
              checkColor: Colors.white,
              activeColor: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2.r),
              ),
              value: ischeck,
              onChanged: (val) {
                ischeck = val!;
                controller.isEndTimeAddLater.value = val;

                if (ischeck) {
                  controller.endTime.value = 'Add Later';
                  controller.eTime = '15000';
                  controller.totaltiemcalculated.value =
                      controller.calculateTotalTime();
                } else {
                  controller.endTime.value = 'hh:mm';
                }
              },
            ),
          ),
        ),
        SizedBox(width: 5.w),
        Padding(
          padding: EdgeInsets.only(right: 8.w, top: 4.h),
          child: appnormaltxt('Add Later'),
        ),
        Container(
          height: 55.h,
          width: 55.w,
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(
                color: Colors.black,
                width: 1.0,
              ),
            ),
          ),
          child: IconButton(
            icon: Icon(
              Icons.access_time_rounded,
              color: Theme.of(context).primaryColor,
              size: 25.w,
            ),
            // tooltip: 'Tap to open date picker',
            onPressed: ischeck ? null : click,
          ),
        )
      ],
    );
  }

  // table card
  // Widget buildTblcard(BuildContext context) {
  //   return Padding(
  //     padding: const EdgeInsets.all(10),
  //     child: Card(
  //       child: Column(
  //         children: [
  //           // data table
  //           Container(
  //             width: double.infinity,
  //             child: Obx(
  //               () => controller.myData.length == 0
  //                   ? NoDataTable()
  //                   : PaginatedDataTable(
  //                       rowsPerPage: controller.rowsPerPage.value,
  //                       columnSpacing: 8,
  //                       columns: [
  //                         DataColumn(label: appitemtableHeadertxt('ITEM')),
  //                         DataColumn(label: appitemtableHeadertxt('DESCRIPTION')),
  //                         DataColumn(label: appitemtableHeadertxt('COST')),
  //                         DataColumn(label: appitemtableHeadertxt('PURPOSE')),
  //                         DataColumn(label: appitemtableHeadertxt('SERIAL NO')),
  //                         DataColumn(label: appitemtableHeadertxt('QTY')),
  //                       ],
  //                       source: RowSource(
  //                         myData: controller.myData,
  //                         count: controller.myData.length,
  //                       ),
  //                       availableRowsPerPage: const <int>[2, 5, 7, 50],
  //                       onRowsPerPageChanged: (value) {
  //                         controller.rowsPerPage.value = value!;
  //                       },
  //                     ),
  //             ),
  //           ),
  //           Align(
  //             child: Obx(() => Padding(
  //                   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
  //                   child: appnormaltxt("Total Cost : " + controller.totalcost.value.toString()),
  //                 )),
  //             alignment: Alignment.centerRight,
  //           ),
  //           SizedBox(height: 5.h),
  //           Padding(
  //             padding: EdgeInsets.all(8.0.w),
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.end,
  //               children: [
  //                 SizedBox(
  //                         width: 200.w,
  //                         child: appButton(() {
  //                           Get.back();
  //                         }, 'OK', AppColor.mainBlueColor))

  //               ],
  //             ),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // table header
  Widget tableHeader() {
    return Padding(
      padding: EdgeInsets.all(3.w).copyWith(bottom: 0, top: 10.h),
      child: Row(
        children: [
          apptableHeadertxt('Item'),
          SizedBox(width: 5.w),
          apptableHeadertxt('Description'),
          SizedBox(width: 5.w),
          apptableHeadertxt('Cost'),
          SizedBox(width: 5.w),
          apptableHeadertxt('Purpose'),
          SizedBox(width: 5.w),
          apptableHeadertxt('Serial No'),
          SizedBox(width: 5.w),
          apptableHeadertxt('Quantity'),
          SizedBox(width: 5.w),
          apptableHeadertxt('Option'),
        ],
      ),
    );
  }

// table data
  Widget tableData() {
    return Expanded(
      child: Container(
        child: ListView.separated(
          itemCount: controller.wshopinfo.length,
          physics: BouncingScrollPhysics(),
          separatorBuilder: (context, index) {
            return Divider(
              thickness: 1.w,
              color: Colors.black12,
              endIndent: 20.w,
              indent: 20.w,
            );
          },
          //itemCount: snapshot.data.length,
          itemBuilder: (BuildContext content, int index) {
            var data = controller.wshopinfo[index];
            return Padding(
              padding: EdgeInsets.all(3.h),
              child: Row(
                children: [
                  apptableDatatxt(data.item.toString()),
                  SizedBox(width: 5.w),
                  apptableDatatxt(data.itemDes.toString()),
                  SizedBox(width: 5.w),
                  apptableDatatxt(data.sp.toString()),
                  SizedBox(width: 5.w),
                  apptableDatatxt(data.purpose.toString()),
                  SizedBox(width: 5.w),
                  apptableDatatxt(data.serialNo.toString()),
                  SizedBox(width: 5.w),
                  apptableDatatxt(data.quantity.toString()),
                  SizedBox(width: 5.w),
                  Expanded(
                      child: IconButton(
                    onPressed: () {
                      print('deleting ---> $index');

                      // int reIndex = 100;

                      try {
                        String reSerialNo = data.serialNo.toString();

                        print(controller.serialchips.length + 1);

                        controller.serialchips.add(SerialChips(
                            index: controller.predicchipscount,
                            serial_no: reSerialNo));

                        controller.wshopinfo.removeAt(index);

                        controller.predicchipscount++;
                        controller.totalCost();

                        // blistOfDrofDownValues.add(DropDownTypesSerialNumbers(index: 1000,serial_no: 'dasun'));
                      } catch (e) {
                        print(e.toString());
                      }
                    },
                    icon: Icon(
                      Icons.delete,
                      size: 25.w,
                    ),
                  )),
                ],
              ),
            );
          },
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
                SizedBox(width: 5.w),
                Expanded(
                  child: Center(child: appitemtableHeadertxt('DESCRIPTION')),
                ),
                SizedBox(width: 5.w),
                Expanded(
                  child: Center(child: appitemtableHeadertxt('COST')),
                ),
                SizedBox(width: 5.w),
                Expanded(
                  child: Center(child: appitemtableHeadertxt('PURPOSE')),
                ),
                SizedBox(width: 5.w),
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

  // chipper box serial numbers
  Widget ChiperBox() {
    return Wrap(
      spacing: 20.w,
      runSpacing: 5.h,
      alignment: WrapAlignment.center,
      children: controller.serialchips
          .map((chip) => Chip(
                label: Text(chip.serial_no, style: TextStyle(fontSize: 16.sp)),
                deleteIcon: const Icon(Icons.add),
                onDeleted: () async {
                  await controller.serielInfo(
                    chip.serial_no,
                    chip.index,
                    chip.serial_no,
                  );
                },
              ))
          .toList(),
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
              margin: EdgeInsets.only(top: 7.h),
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

  Widget buildexpandItems(bool isreq, String title, String hint,
      TextEditingController txtcontroller) {
    return Padding(
      padding: EdgeInsets.only(left: 10.w, bottom: 15.w),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: 55.w,
        ),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
            color: Colors.black,
            width: 1.w,
            style: BorderStyle.solid,
          )),
          child: ExpansionTile(
            maintainState: true,
            childrenPadding: EdgeInsets.all(15.w).copyWith(top: 0),
            title: isreq
                ? appreqtxt(
                    title,
                  )
                : appnormaltxt(
                    title,
                  ),
            children: <Widget>[
              TextField(
                style: TextStyle(fontSize: 18.sp),
                decoration: InputDecoration(
                  // border: InputBorder.none,
                  hintText: hint,
                  hintStyle: TextStyle(color: Colors.black, fontSize: 15.sp),
                ),
                maxLines: 3,
                controller: txtcontroller,
                onTapOutside: (event) {
                  print('onTapOutside');
                  FocusManager.instance.primaryFocus?.unfocus();
                },
              ),
            ],
            onExpansionChanged: (isExpanded) => {},
          ),
        ),
      ),
    );
  }

// type of hours dp
  Future<void> dpTypeofHoursWidget() async {
    int listlength = controller.ftypeofhourslist.length;

    if (listlength > 0) {
      Get.bottomSheet(
          Obx(
            () => Column(
              children: [
                // TextField(
                //   // controller: _controller,
                //   // decoration: appdpfiledDecoration(),
                //   onChanged: (val) {
                //     print(val);
                //     // controller.filterCompany(val.toString());
                //   },
                // ),
                // SizedBox(height: 5),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: controller.ftypeofhourslist.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        onTap: () {
                          controller.selectedtypeofhours.value =
                              controller.ftypeofhourslist[index].dropValue;

                          controller.idofselectedtypeofhours.value = controller
                              .ftypeofhourslist[index].dropId
                              .toString();

                          controller.getLabourHours(
                              controller.idofselectedtypeofhours.value,
                              controller.idofselectedcontarct,
                              controller.totaltiemcalculated.value ==
                                      'To Be Determined'
                                  ? ''
                                  : controller.totaltiemcalculated.value
                                      .toString());

                          log(controller.ftypeofhourslist[index].dropValue);
                          Get.back();
                        },
                        leading: Icon(
                          Icons.add,
                          size: 20.w,
                        ),
                        title: appDashBoardlblTxt(
                            controller.ftypeofhourslist[index].dropValue),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35), side: BorderSide(width: 5, color: Colors.black)),
          backgroundColor: AppColor.dpBgcolor,
          isDismissible: true);
    } else {
      log('me time ake error akk nisa dp load wenne  na');
    }
  }

// to be paid in dp
  Future<void> dpToBePaidInWidget() async {
    int listlength = controller.ftobepaidinlist.length;

    if (listlength > 0) {
      Get.bottomSheet(
          Obx(
            () => Column(
              children: [
                // TextField(
                //   // controller: _controller,
                //   // decoration: appdpfiledDecoration(),
                //   onChanged: (val) {
                //     print(val);
                //     // controller.filterCompany(val.toString());
                //   },
                // ),
                // SizedBox(height: 5.h),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: controller.ftobepaidinlist.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        onTap: () {
                          controller.selectedtobepaidin.value =
                              controller.ftobepaidinlist[index].dropValue;

                          controller.idofselectedtobepaidin.value = controller
                              .ftobepaidinlist[index].dropId
                              .toString();

                          log(controller.ftobepaidinlist[index].dropValue);
                          Get.back();
                        },
                        leading: Icon(
                          Icons.add,
                          size: 20.w,
                        ),
                        title: appDashBoardlblTxt(
                            controller.ftobepaidinlist[index].dropValue),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35), side: BorderSide(width: 5, color: Colors.black)),
          backgroundColor: AppColor.dpBgcolor,
          isDismissible: true);
    } else {
      log('me time ake error akk nisa dp load wenne  na');
    }
  }

  // item drop down bottom sheet
  Future<void> dpItemsWidget() async {
    int listlength = controller.fitemslist.length;

    if (listlength > 0) {
      Get.bottomSheet(
          Obx(
            () => Column(
              children: [
                TextField(
                  // controller: _controller,
                  decoration: InputDecoration(
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(4.r),
                      ),
                    ),
                  ),
                  onChanged: (val) {
                    // print(val);
                    controller.filteritem(val.toString());
                  },
                  style: TextStyle(fontSize: 16.sp),
                ),
                SizedBox(height: 5.h),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: controller.fitemslist.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        onTap: () {
                          controller.selecteditem.value =
                              controller.fitemslist[index].itemDes;

                          controller.idofselecteditem.value =
                              controller.fitemslist[index].itemCode.toString();

                          controller.searchBySeriels(
                              controller.idofselecteditem.value);

                          log(controller.fitemslist[index].itemDes);
                          Get.back();
                        },
                        leading: Icon(
                          Icons.add,
                          size: 20.w,
                        ),
                        title: appDashBoardlblTxt(
                            controller.fitemslist[index].itemDes),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35), side: BorderSide(width: 5, color: Colors.black)),
          backgroundColor: AppColor.dpBgcolor,
          isDismissible: true);
    } else {
      log('me time ake error akk nisa dp load wenne  na');
    }
  }
}
