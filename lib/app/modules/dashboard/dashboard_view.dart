import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:sfit_getx/app/routes/app_pages.dart';
import 'package:sfit_getx/res/theme/app_colors.dart';
import 'package:sfit_getx/res/widgets/app_button.dart';

import '../../../res/widgets/app_custom_text_styles.dart';
import '../../../res/widgets/app_drop_down.dart';
import '../../../res/widgets/app_txtfiled_decoration.dart';
import 'dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // floatingActionButton: FloatingActionButton(onPressed: () {
        //   // log(controller.temsearchoption.values.toString());
        //   controller.isrefresh.value = false;
        // }),
        body: SingleChildScrollView(
          // physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              // buildHeader(),
              buildDPcard(context),
              SizedBox(height: 5.h),
              Obx(() => buildTblcard(context)),
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
            Container(
              width: double.infinity,
              height: 70.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
                  Container(
                    width: 300.w,
                    padding: EdgeInsets.all(10.w),
                    child: TextField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search,size: 30.w,),
                        hintText: 'Requisition Number',
                        hintStyle: TextStyle(fontSize: 18.sp),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.r),
                          borderSide: const BorderSide(color: Colors.red),
                        ),
                      ),
                      controller: controller.controllerSearch,
                      style: TextStyle(fontSize: 18.sp),
                      onChanged: (value) {
                        controller.filterText.value = value;
                        controller.currentPage.value = 1; // Reset to the first page when filtering
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15.w),
            Obx(
              () => SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  color: controller.isrefresh.value ? Colors.transparent : Colors.transparent,
                  height: 300.h,
                  width: 1394.w + 300.w,
                  child: Column(
                    children: [
                      Container(
                        // width: Get.width,
                        // width: 500.w,
                        // height: 50,
                        child: Row(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(width: 16.w),
                            SizedBox(width: 170.w, child: appitemtableHeadertxt('FORM NO')),
                            SizedBox(width: 16.w),
                            SizedBox(width: 200.w, child: appitemtableHeadertxt('CUSTOMER')),
                            SizedBox(width: 16.w),
                            SizedBox(width: 200.w, child: appitemtableHeadertxt('CONTRACT ID')),
                            SizedBox(width: 16.w),
                            SizedBox(width: 115.w, child: appitemtableHeadertxt('SERVICE DATE')),
                            SizedBox(width: 16.w),
                            SizedBox(width: 120.w,child: appitemtableHeadertxt('REQUEST DATE')),
                            SizedBox(width: 16.w),
                            SizedBox(width: 120.w,child: appitemtableHeadertxt('ENGINEER')),
                            SizedBox(width: 16.w),
                            SizedBox(width: 125.w,child: appitemtableHeadertxt('SIGN ENGINEER')),
                            SizedBox(width: 16.w),
                            SizedBox(
                              width: 200.w,child: appitemtableHeadertxt('SIGN CUSTOMER')),
                            SizedBox(width: 16.w),
                            appitemtableHeadertxt('OPTION'),
                          ],
                        ),
                      ),
                      Divider(
                              thickness: 2.w,
                              color: Colors.black,
                              endIndent: 20.w,
                              indent: 20.w,
                            ),
                      Expanded(
                        child: ListView.separated(
                          itemCount: controller.fetchFilterDate().length,
                          itemBuilder: (context, index) {
                            final Obj = controller.fetchFilterDate()[index];

                            ///------------------------------\\\

                            bool isengOk = false;
                            bool iscusOk = false;
                            bool isIcon = true;

                            isengOk = Obj.signEngineer.toString() == '1' ? true : false;
                            iscusOk = Obj.signCustomer.toString() == '1' ? true : false;

                            if (Obj.signCustomer.toString().isEmpty || Obj.signCustomer.toString().length > 1) {
                              isIcon = false;
                            } else {
                              if (Obj.signCustomer == '1') iscusOk = true;
                            }

                            ///--------------------------------\\\
                            return Row(
                              children: [
                                SizedBox(width: 16.w), // Add spacing if needed
                                // Text(item.companyName.toString()),

                                SizedBox(width: 170.w, child: appitemtableDatatxt(Obj.requisitionNo.toString())),
                                SizedBox(width: 16.w),
                                SizedBox(
                                  width: 200.w,
                                  child: appitemtableDatatxt(
                                    Obj.companyName.toString(),
                                  ),
                                ),
                                SizedBox(width: 16.w),
                                SizedBox(width: 200.w, child: appitemtableDatatxt(Obj.contractId.toString())),
                                SizedBox(width: 16.w),

                                SizedBox(
                                  width: 115.w,child: appitemtableDatatxt(Obj.startDate.toString())),
                                SizedBox(width: 16.w),
                                SizedBox(
                                  width: 120.w,child: appitemtableDatatxt(Obj.requestedDate.toString())),
                                SizedBox(width: 16.w),
                                SizedBox(
                                  width: 120.w,child: appitemtableDatatxt(Obj.engineer.toString())),
                                SizedBox(width: 16.w),
                                SizedBox(width: 125.w,
                                  child: Center(
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
                                SizedBox(width: 16.w),
                                SizedBox(
                                  width: 200.w,
                                  child: Center(
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
                                  ),
                                ),
                                SizedBox(width: 16.w),
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
                                    Visibility(
                                      visible: Obj.option.email,
                                      child: Padding(
                                        padding: EdgeInsets.only(right: 5.h),
                                        child: IconButton(
                                          icon: const Icon(Icons.email),
                                          onPressed: () async {
                                            controller.sendEmail(Obj);
                                            controller.isrefresh.value = !controller.isrefresh.value;
                                          },
                                          iconSize: 23.w,
                                          color: Colors.blue[700],
                                        ),
                                      ),
                                    ),

                                    // email forword // Option.emailSent.value
                                    Visibility(
                                      visible: Obj.option.emailSent,
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

                                    // $
                                    Visibility(
                                      visible: Obj.option.signature,
                                      child: Padding(
                                        padding: EdgeInsets.only(right: 5.h),
                                        child: IconButton(
                                          icon: const FaIcon(FontAwesomeIcons.signature),
                                          onPressed: () async {
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
                                  ],
                                ),

                                // item['ismailed']
                                //     ? IconButton(
                                //         icon: Icon(Icons.delete),
                                //         onPressed: () {
                                //           // controller.deleteItem(item);
                                //           item['ismailed'] = false;
                                //           // item['ismailed'] = !item['ismailed'];
                                //           controller.isrefresh.value = !controller.isrefresh.value;
                                //         },
                                //       )
                                //     : IconButton(
                                //         icon: Icon(Icons.check_circle_outline),
                                //         onPressed: () {
                                //           // controller.deleteItem(item);
                                //         },
                                //       ),

                                SizedBox(width: 16.w), // Add spacing if needed
                              ],
                            );
                          },
                          separatorBuilder: (context, index) {
                            return Divider(
                              thickness: 2.w,
                              color: Colors.black12,
                              endIndent: 20.w,
                              indent: 20.w,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // },

            Padding(
              padding: EdgeInsets.only(right: 8.w, bottom: 8.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 150.w,
                    height: 35.w,
                    child: ElevatedButton(
                      onPressed: controller.currentPage.value > 1
                          ? () {
                              controller.currentPage.value--;
                            }
                          : null,
                      child: Text(
                        'Previous Page',
                        style: TextStyle(fontSize: 16.sp),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Text(
                    'Page ${controller.currentPage.value} of ${controller.totalPageCount}',
                    style: TextStyle(fontSize: 16.sp),
                  ),
                  SizedBox(width: 16.w),
                  SizedBox(
                    width: 150.w,
                    height: 35.w,
                    child: ElevatedButton(
                      onPressed: controller.currentPage.value < (controller.filteredData.length / controller.itemsPerPage.value).ceil()
                          ? () {
                              controller.currentPage.value++;
                            }
                          : null,
                      child: Text(
                        'Next Page',
                        style: TextStyle(fontSize: 16.sp),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Obx(
            //   () => Container(
            //     height: 300,
            //     child: ListView.builder(
            //       itemCount: controller.paginatedData.length,
            //       itemBuilder: (context, index) {
            //         final item = controller.paginatedData[index];
            //         // return ListTile(
            //         //   title: Text(item['name']),
            //         //   subtitle: Row(
            //         //     children: [
            //         //       Text(item['description']),
            //         //       Text(item['description']),
            //         //       Text(item['description']),
            //         //       Text(item['description']),
            //         //       Text(item['description']),
            //         //       IconButton(
            //         //         icon: Icon(Icons.edit),
            //         //         onPressed: () {
            //         //           _editItem(item);
            //         //         },
            //         //       ),
            //         //       IconButton(
            //         //         icon: Icon(Icons.delete),
            //         //         onPressed: () {
            //         //           _deleteItem(item);
            //         //         },
            //         //       ),
            //         //     ],
            //         //   ),
            //         //   // trailing: Row(
            //         //   //   mainAxisSize: MainAxisSize.min,
            //         //   //   children: [
            //         //   //     IconButton(
            //         //   //       icon: Icon(Icons.edit),
            //         //   //       onPressed: () {
            //         //   //         _editItem(item);
            //         //   //       },
            //         //   //     ),
            //         //   //     IconButton(
            //         //   //       icon: Icon(Icons.delete),
            //         //   //       onPressed: () {
            //         //   //         _deleteItem(item);
            //         //   //       },
            //         //   //     ),
            //         //   //   ],
            //         //   // ),
            //         // );

            //         return SingleChildScrollView(
            //           scrollDirection: Axis.horizontal,
            //           child: Row(
            //             children: [
            //               SizedBox(width: 16.w), // Add spacing if needed
            //               Text(item['name']),
            //               SizedBox(width: 16.w), // Add spacing if needed
            //               Text(item['description']),
            //               SizedBox(width: 16.w),
            //               SizedBox(width: 16.w), // Add spacing if needed
            //               Text(item['name']),
            //               SizedBox(width: 16.w), // Add spacing if needed
            //               Text(item['description']),
            //               SizedBox(width: 16.w), // Add spacing if needed
            //               IconButton(
            //                 icon: Icon(Icons.edit),
            //                 onPressed: () {
            //                   // _editItem(item);
            //                 },
            //               ),
            //               IconButton(
            //                 icon: Icon(Icons.delete),
            //                 onPressed: () {
            //                   // _deleteItem(item);
            //                 },
            //               ),
            //               SizedBox(width: 16.w), // Add spacing if needed
            //             ],
            //           ),
            //         );
            //       },
            //     ),
            //   ),
            // ),
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
