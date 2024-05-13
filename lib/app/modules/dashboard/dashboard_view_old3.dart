import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:sfit_getx/app/routes/app_pages.dart';
import 'package:sfit_getx/res/theme/app_colors.dart';
import 'package:sfit_getx/res/widgets/app_button.dart';
import 'package:sfit_getx/res/widgets/app_header.dart';

import '../../../res/widgets/app_custom_text_styles.dart';
import '../../../res/widgets/app_drop_down.dart';
import '../../../res/widgets/app_txtfiled_decoration.dart';
import 'dashboard_controller.dart';
import 'row_source.dart';

class DashboardView extends GetView<DashboardController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // floatingActionButton: FloatingActionButton(onPressed: () {
        //   // log(controller.temsearchoption.values.toString());
          
        // }),
        body: SingleChildScrollView(
          // physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              buildHeader(),
              buildDPcard(context),
              SizedBox(height: 5.h),
              buildTblcard(context),
            ],
          ),
        ),
      ),
    );
  }

// dp card
  Widget buildDPcard(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.w),
      child: Card(
        shadowColor: Colors.black,
        elevation: 2,
        child: Container(
          padding: EdgeInsets.all(10.w).copyWith(bottom: 0, top: 5),
          child: Column(
            children: [
              // dates
              Container(
                width: double.infinity,
                // height: 100.h,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        child: buildCustomDatePicker('Date : From', context, true),
                      ),
                    ),
                    SizedBox(width: 40.w),
                    Expanded(
                      child: Container(
                        child: buildCustomDatePicker('Date : To', context, false),
                      ),
                    ),
                    SizedBox(width: 40.w),
                    Expanded(
                      child: buildIgnoreDateCheckBox(context),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5.h),
              // drop downs ---> customer/site/contract
              Container(
                width: double.infinity,
                // height: 100.h,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          appDashBoardlblTxt('Customer'),
                          Obx(
                            () => customDropDowns(controller.selectedcompany.value, () async {
                              // await controller.fetchCompany();
                              controller.filterCompany('');
                              controller.clearSelectedValues(1);
                              Future.delayed(const Duration(seconds: 1), () {
                                dpCompanyWidget();
                              });
                            }),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 40.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          appDashBoardlblTxt('Site'),
                          Obx(
                            () => customDropDowns(controller.selectedsite.value, () {
                              controller.filterSite('');
                              controller.clearSelectedValues(2);
                              Future.delayed(const Duration(seconds: 1), () {
                                dpSiteWidget();
                              });
                            }),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 40.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          appDashBoardlblTxt('Contract'),
                          Obx(
                            () => customDropDowns(controller.selectedcontract.value, () {
                              controller.filterContract('');
                              Future.delayed(const Duration(seconds: 1), () {
                                dpContractWidget();
                              });
                            }),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5.h),
              // drop downs ---> order by/ engineer
              Container(
                width: double.infinity,
                // height: 100.h,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          appDashBoardlblTxt('Order By'),
                          Obx(
                            () => customDropDowns(controller.selectedorderby.value, () {
                              Future.delayed(const Duration(seconds: 1), () {
                                dpOrderbyWidget();
                              });
                            }),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 40.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          appDashBoardlblTxt('Engineer'),
                          Obx(
                            () => customDropDowns(controller.selectedengineer.value, () {
                              controller.filterEngineer('');
                              Future.delayed(const Duration(seconds: 1), () {
                                dpEngineerWidget();
                              });
                            }),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 40.w),
                    Expanded(
                      child: Container(
                        width: 100,
                        child: appButton(() {
                          controller.clearSelectedValues(3);
                        }, 'Clear', Colors.grey[400]),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              // buttons
              Container(
                width: double.infinity,
                // height: 100.h,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 15.h),
                  child: Row(
                    children: [
                      Expanded(child: SizedBox()),
                      SizedBox(width: 40.w),
                      Expanded(
                        child: appButton(() {
                          Get.toNamed(Routes.SERVICEFORM);
                        }, 'Add Field Service Entry', Colors.green),
                      ),
                      SizedBox(width: 40.w),
                      Expanded(
                        child: Obx(
                          () => appLoadingButton(Theme.of(context).primaryColor, controller.searchForm, 'Search', controller.isSearching.value),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

// table card
  Widget buildTblcard(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.w),
      child: Card(
        child: Column(
          children: [
            // Container(
            //   width: double.infinity,
            //   height: 70,
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Container(),
            //       Container(
            //         width: 300,
            //         padding: EdgeInsets.all(10),
            //         child: TextField(
            //           textAlign: TextAlign.center,
            //           decoration: InputDecoration(
            //             prefixIcon: const Icon(Icons.search),
            //             hintText: 'Requisition Number',
            //             border: OutlineInputBorder(
            //               borderRadius: BorderRadius.circular(15),
            //               borderSide: const BorderSide(color: Colors.red),
            //             ),
            //           ),
            //           controller: controller.controllerSearch,
            //           style: const TextStyle(fontSize: 20),
            //           onChanged: (val) {
            //             // requisition_no = val;
            //             print('requisition_no -----> $val');
            //             // sorting data
            //             controller.sortingData(val);
            //             // setState(() {
            //             // });
            //             // controller.searchTbl(val);
            //           },
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // // data table
            Container(
              width: double.infinity,
              child: Obx(
                () => PaginatedDataTable(
                  rowsPerPage: controller.rowsPerPage.value,
                  columnSpacing: 20.w,
                  dataRowHeight: 50.w,
                  columns: [
                    DataColumn(label: appitemtableHeadertxt('FORM NO')),
                    DataColumn(label: appitemtableHeadertxt('CUSTOMER')),
                    DataColumn(label: appitemtableHeadertxt('CONTRACT ID')),
                    DataColumn(label: appitemtableHeadertxt('SERVICE DATE')),
                    DataColumn(label: appitemtableHeadertxt('REQUEST DATE')),
                    DataColumn(label: appitemtableHeadertxt('ENGINEER')),
                    DataColumn(label: appitemtableHeadertxt('SIGN ENGINEER')),
                    DataColumn(label: appitemtableHeadertxt('SIGN CUSTOMER')),
                    DataColumn(label: appitemtableHeadertxt('OPTION')),
                  ],
                  source: RowSource(
                    myData: controller.temmyData,
                    count: controller.temmyData.length,
                  ),
                  availableRowsPerPage: const <int>[2, 5, 7, 50],
                  onRowsPerPageChanged: (value) {
                    controller.rowsPerPage.value = value!;
                  },
                  // initialFirstRowIndex: controller.initrowindex.value,
                  showFirstLastButtons: false,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // table
  // Widget buildDataTable(BuildContext context) {
  //   return SingleChildScrollView(
  //     child: Column(
  //       children: [
  //         // table
  //         Container(
  //           width: double.infinity,
  //           color: Theme.of(context)
  //           .primaryColor,
  //           child: PaginatedDataTable(
  //             // showCheckboxColumn: true,
  //             source: controller.data,
  //             columns: const [
  //               DataColumn(label: Text('FORM NO')),
  //               DataColumn(label: Text('CUSTOMER')),
  //               DataColumn(label: Text('CONTRACT ID')),
  //               DataColumn(label: Text('SERVICE DATE')),
  //               DataColumn(label: Text('REQUEST DATE')),
  //               DataColumn(label: Text('ENGINEER')),
  //               DataColumn(label: Text('SIGN ENGINEER')),
  //               DataColumn(label: Text('SIGN CUSTOMER')),
  //               DataColumn(label: Text('OPTION')),
  //             ],
  //             columnSpacing: 30,
  //             showFirstLastButtons: true,
  //             rowsPerPage: _rowsPerPage,
  //             availableRowsPerPage: const <int>[5, 10, 25, 50],
  //             onRowsPerPageChanged: (value) {
  //               // setState(() {
  //               //   _rowsPerPage = value!;
  //               // });
  //             },
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

// date picker
  Widget buildCustomDatePicker(String title, BuildContext context, bool isFrom) {
    return Container(
      margin: EdgeInsets.only(top: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(color: Colors.black, fontSize: 16.sp),
          ),
          SizedBox(
            height: 5.h,
          ),
          Container(
            height: 55.w,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 1.0.w),
              // borderRadius: BorderRadius.all(
              //   Radius.circular(0),
              // ),
            ),
            child: Padding(
              padding: EdgeInsets.all(4.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: Obx(
                      () => Text(
                        isFrom ? controller.startdate.value : controller.enddate.value,
                        // '${pickedDateFrom.day} / ${pickedDateFrom.month} / ${pickedDateFrom.year}'

                        textAlign: TextAlign.right,
                        style: TextStyle(color: Colors.black, fontSize: 15.sp),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.calendar_today,
                      color: Theme.of(context).primaryColor,
                      size: 25.w,
                    ),
                    tooltip: 'Tap to open date picker',
                    onPressed: () {
                      isFrom ? controller.fromDate(context) : controller.toDate(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

// check box
  Widget buildIgnoreDateCheckBox(BuildContext context) {
    return Obx(() => Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            Row(
              children: [
                Container(
                  // height: 30,
                  // width: 30,
                  child: Transform.scale(
                    scale: 1.75.w,
                    child: Checkbox(
                      checkColor: Colors.white,
                      activeColor: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                      value: controller.isCheckIgnoreDate.value,
                      onChanged: (val) {
                        controller.isCheckIgnoreDate.value = val!;
                      },
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                Text(
                  'Ignore Date',
                  style: TextStyle(fontSize: 16.sp),
                ),
              ],
            ),
          ],
        ));
  }

// drop down bottom sheet
  Future<void> dpCompanyWidget() async {
    int listlength = controller.fcompanylist.length;

    if (listlength > 0) {
      Get.bottomSheet(
        Obx(
          () => Column(
            children: [
              TextField(
                // controller: _controller,
                decoration: appdpfiledDecoration(),
                onChanged: (val) {
                  print(val);
                  controller.filterCompany(val.toString());
                },
                style: TextStyle(fontSize: 16.sp),
              ),
              SizedBox(height: 5.h),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: controller.fcompanylist.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      onTap: () {
                        controller.selectedcompany.value = controller.fcompanylist[index].dropValue;

                        controller.idofselectedcompany.value = controller.fcompanylist[index].dropId.toString();

                        log(controller.fcompanylist[index].dropValue);
                        Get.back();

                        controller.fetchSite(controller.idofselectedcompany.value.toString());
                      },
                      leading: Icon(
                        Icons.add,
                        size: 20.w,
                      ),
                      title: appDashBoardlblTxt(controller.fcompanylist[index].dropValue),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35), side: BorderSide(width: 5, color: Colors.black)),
        backgroundColor: AppColor.dpBgcolor,
        isDismissible: true,
      );
    } else {
      log('me time ake error akk nisa dp load wenne  na');
    }
  }

  Future<void> dpSiteWidget() async {
    int listlength = controller.fsitelist.length;

    if (listlength > 0) {
      Get.bottomSheet(
        Obx(
          () => Column(
            children: [
              TextField(
                // controller: _controller,
                decoration: appdpfiledDecoration(),
                onChanged: (val) {
                  print(val);
                  controller.filterSite(val.toString());
                },
                style: TextStyle(fontSize: 16.sp),
              ),
              SizedBox(height: 5.h),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: controller.fsitelist.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      onTap: () {
                        controller.selectedsite.value = controller.fsitelist[index].dropValue;

                        controller.idofselectedsite.value = controller.fsitelist[index].dropId.toString();

                        log(controller.fsitelist[index].dropId);
                        Get.back();

                        controller.fetchContarct(controller.idofselectedsite.value.toString());
                      },
                      leading: Icon(
                        Icons.add,
                        size: 20.w,
                      ),
                      title: appDashBoardlblTxt(controller.fsitelist[index].dropValue),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35), side: BorderSide(width: 5, color: Colors.black)),
        backgroundColor: AppColor.dpBgcolor,
        isDismissible: true,
      );
    } else {
      log('me time ake error akk nisa dp load wenne  na');
    }
  }

  Future<void> dpContractWidget() async {
    int listlength = controller.fcontarctlist.length;

    if (listlength > 0) {
      Get.bottomSheet(
        Obx(
          () => Column(
            children: [
              TextField(
                // controller: _controller,
                decoration: appdpfiledDecoration(),
                onChanged: (val) {
                  print(val);
                  controller.filterContract(val.toString());
                },
                style: TextStyle(fontSize: 16.sp),
              ),
              SizedBox(height: 5.h),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: controller.fcontarctlist.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      onTap: () {
                        controller.selectedcontract.value = controller.fcontarctlist[index].dropValue;

                        controller.idofselectedcontarct.value = controller.fcontarctlist[index].dropId.toString();

                        log(controller.fcontarctlist[index].dropId);
                        Get.back();
                      },
                      leading: Icon(
                        Icons.add,
                        size: 20.w,
                      ),
                      title: appDashBoardlblTxt(controller.fcontarctlist[index].dropValue),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35), side: BorderSide(width: 5, color: Colors.black)),
        backgroundColor: AppColor.dpBgcolor,
        isDismissible: true,
      );
    } else {
      log('me time ake error akk nisa dp load wenne  na');
    }
  }

  Future<void> dpOrderbyWidget() async {
    Get.bottomSheet(
      Obx(
        () => ListView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemCount: controller.orderbylist.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              onTap: () {
                controller.selectedorderby.value = controller.orderbylist[index]['drop_value'];

                controller.idofselectedoderby.value = controller.orderbylist[index]['drop_id'];

                log(controller.orderbylist[index]['drop_value']);
                Get.back();
              },
              leading: Icon(
                Icons.add,
                size: 20.w,
              ),
              title: appDashBoardlblTxt(controller.orderbylist[index]['drop_value']),
            );
          },
        ),
      ),
      backgroundColor: AppColor.dpBgcolor,
      isDismissible: true,
    );
  }

  Future<void> dpEngineerWidget() async {
    int listlength = controller.fengineerlist.length;

    if (listlength > 0) {
      Get.bottomSheet(
        Obx(
          () => Column(
            children: [
              TextField(
                // controller: _controller,
                decoration: appdpfiledDecoration(),
                onChanged: (val) {
                  print(val);
                  controller.filterEngineer(val.toString());
                },
                style: TextStyle(fontSize: 16.sp),
              ),
              SizedBox(height: 5),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: controller.fengineerlist.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      onTap: () {
                        controller.selectedengineer.value = controller.fengineerlist[index].dropValue;

                        controller.idofselectedengineer.value = controller.fengineerlist[index].dropId.toString();

                        log(controller.fengineerlist[index].dropId);
                        Get.back();
                      },
                      leading: Icon(
                        Icons.add,
                        size: 20.w,
                      ),
                      title: appDashBoardlblTxt(controller.fengineerlist[index].dropValue),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        backgroundColor: AppColor.dpBgcolor,
        isDismissible: true,
      );
    } else {
      log('me time ake error akk nisa dp load wenne  na');
    }
  }
}
