import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:sfit_getx/res/theme/app_colors.dart';
import 'package:sfit_getx/res/widgets/app_req_no_box.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../../../res/widgets/app_button.dart';
import '../../../../res/widgets/app_custom_text_styles.dart';
import '../../../../res/widgets/app_drop_down.dart';
import '../../../../res/widgets/app_txtfiled_decoration.dart';
import '../serviceform_controller.dart';

class SteponeView extends GetView<ServiceformController> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.w),
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
              appcardviewTitle('ADD SERVICE RECORD FORM'),
              SizedBox(height: 25.h),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        appnormaltxt('Your Requisition Number'),
                        Obx(() => reqBox(controller.reqNo.value)),
                      ],
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        appreqtxt('Engineer'),
                        Obx(
                          () => customDropDowns(
                              controller.selectedengineer.value, () {
                            controller.filterEngineer('');
                            Future.delayed(const Duration(seconds: 1), () {
                              dpEngineerWidget();
                            });
                          }),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Center(
                child: ToggleSwitch(
                  minHeight: 50.w,
                  minWidth: 200.w,
                  customWidths: [200.w, 200.w],
                  initialLabelIndex: controller.tog.value,
                  totalSwitches: 2,
                  labels: ['Enter by Asset Code', 'Enter by Contract'],
                  customTextStyles: [
                    TextStyle(
                      fontSize: 16.sp,
                      // fontWeight: FontWeight.bold,
                      color: Colors.black,
                    )
                  ],
                  onToggle: (index) {
                    print('switched to: $index');
                    controller.tog.value = index!;
                    if (index == 0) {
                      //when click clear enter by asset code
                      controller.clearSelectedValues(3);
                    } else {
                      //when click clear enter by contract
                      controller.clearSelectedValues(4);
                    }
                  },
                ),
              ),
              SizedBox(height: 20.h),
              Obx(() => controller.tog.value == 0
                  ? asset(context)
                  : contract(context)),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  /// enter by asset code
  Widget asset(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 375.w,
          child: TextField(
            controller: controller.assetcontroller,
            decoration: InputDecoration(
              hintText: "Enter Asset Code",
              suffixIcon: InkWell(
                onTap: () async {
                  var isAddNewAsset = await controller.checkAsset();
                  // print('********$a');
                  if (isAddNewAsset) {
                    needShowCreateAsset();
                  }
                },
                child: Icon(
                  Icons.check_box_rounded,
                  color: Colors.black,
                  size: 55.w,
                ),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(width: 1.w, color: Colors.black),
                borderRadius: BorderRadius.all(
                  Radius.circular(4.r),
                ),
              ),
            ),
            style: TextStyle(fontSize: 16.sp),
            textInputAction: TextInputAction.done,
          ),
        ),
        SizedBox(height: 20.h),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  appreqtxt('Company Name'),
                  Obx(
                    () => Container(
                        height: 55.w,
                        width: Get.width,
                        decoration: BoxDecoration(
                            border: Border.all(
                          color: Colors.black,
                          width: 1.w,
                          style: BorderStyle.solid,
                        )),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: apphintTxt(controller.setCompany.value))),
                  ),
                ],
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  appreqtxt('Site'),
                  Obx(
                    () => Container(
                        height: 55.w,
                        width: Get.width,
                        decoration: BoxDecoration(
                            border: Border.all(
                          color: Colors.black,
                          width: 1.w,
                          style: BorderStyle.solid,
                        )),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: apphintTxt(controller.setSite.value))),
                  ),
                ],
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  appreqtxt('Contracts'),
                  Obx(
                    () =>
                        customDropDowns(controller.selectedcontract.value, () {
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
      ],
    );
  }

  /// enter by contract
  Widget contract(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  appreqtxt('Company Name'),
                  Obx(
                    () => customDropDowns(controller.selectedcompany.value,
                        () async {
                      // await controller.fetchCompany();
                      controller.filterCompany('');
                      controller.clearSelectedValues(1);
                      Future.delayed(
                        const Duration(seconds: 1),
                        () {
                          dpCompanyWidget();
                        },
                      );
                    }),
                  ),
                ],
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  appreqtxt('Site'),
                  Obx(
                    () => customDropDowns(controller.selectedsite.value, () {
                      controller.filterSite('');
                      controller.clearSelectedValues(2);
                      Future.delayed(
                        const Duration(seconds: 1),
                        () {
                          dpSiteWidget();
                        },
                      );
                    }),
                  ),
                ],
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  appreqtxt('Contracts'),
                  Obx(
                    () =>
                        customDropDowns(controller.selectedcontract.value, () {
                      controller.filterContract('');
                      controller.clearSelectedValues(6);
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
        SizedBox(height: 20.h),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  appreqtxt('Asset No'),
                  Obx(
                    () => customDropDowns(controller.selectedassetno.value, () {
                      Future.delayed(const Duration(seconds: 1), () {
                        dpAssetCodeWidget();
                      });
                    }),
                  ),
                ],
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: SizedBox(),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: SizedBox(),
            ),
          ],
        ),
      ],
    );
  }

  // create asset dialog
  void createAsset() {
    Get.defaultDialog(
      title: "Add a New Asset",
      titlePadding: EdgeInsets.all(10.w),
      content: WillPopScope(
        onWillPop: () async => false,
        child: SizedBox(
          width: Get.width,
          // height: Get.height-50,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(8.w),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            appnormaltxt('Asset Code :'),
                            Container(
                              height: 55.w,
                              width: Get.width,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                color: Colors.black,
                                width: 1.w,
                                style: BorderStyle.solid,
                              )),
                              child: Padding(
                                padding: EdgeInsets.all(8.w),
                                child: TextField(
                                  controller: controller.assetcontroller,
                                  decoration: InputDecoration(
                                    // hintText: '--------',
                                    // hintStyle: TextStyle(color: Colors.black, fontSize: 15.sp),
                                    border: InputBorder.none,
                                  ),
                                  style: TextStyle(fontSize: 18.sp),
                                  textAlign: TextAlign.start,
                                  readOnly: true,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 20.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            appnormaltxt('Machine Type :'),
                            Obx(
                              () => customDropDowns(
                                  controller.selectedmachinetype.value, () {
                                Future.delayed(const Duration(seconds: 1), () {
                                  dpMachineTypeWidget();
                                });
                              }),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      SizedBox(height: 10.h),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            appnormaltxt('Company :'),
                            Obx(
                              () => customDropDowns(
                                  controller.selectedcompany.value, () async {
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
                      SizedBox(width: 20.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            appnormaltxt('Site'),
                            Obx(
                              () => customDropDowns(
                                  controller.selectedsite.value, () {
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
                      SizedBox(width: 20.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            appnormaltxt('Contract :'),
                            Obx(
                              () => customDropDowns(
                                  controller.selectedcontract.value, () {
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
                  SizedBox(height: 25.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 100.w,
                        child: appButton(() async {
                          await controller.clearSelectedValues(7);
                          Get.back();
                        }, 'Cancel', AppColor.mainBlueColor),
                      ),
                      SizedBox(width: 20.w),
                      SizedBox(
                        width: 100.w,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: appButton(() async {
                            // var a =
                            await controller.saveAssetCode();

                            // if (a) {
                            //   Get.back();
                            // }
                          }, 'Add', AppColor.mainBlueColor),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      titleStyle: TextStyle(color: Colors.black, fontSize: 18.sp),
      radius: 5.r,
    );
  }

  // get access for shown create asset dialog
  void needShowCreateAsset() {
    Get.defaultDialog(
      title: "Do You Want To Add Asset ?",
      titlePadding: EdgeInsets.all(10.w),
      content: SizedBox(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8.w),
            child: Column(
              children: [
                SizedBox(height: 15.w),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: 100.w,
                        child: appButton(() async {
                          Get.back();

                          await controller.fetchMachineType();
                          createAsset();
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
      titleStyle: TextStyle(color: Colors.black, fontSize: 18.sp),
      radius: 5.r,
      barrierDismissible: false,
    );
  }

  // engineer drop down bottom sheet
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
              SizedBox(height: 5.h),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: controller.fengineerlist.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      onTap: () {
                        controller.selectedengineer.value =
                            controller.fengineerlist[index].dropValue;

                        controller.idofselectedengineer.value =
                            controller.fengineerlist[index].dropId.toString();

                        controller
                            .getReqNo(controller.idofselectedengineer.value);

                        log(controller.fengineerlist[index].dropId);
                        Get.back();
                      },
                      leading: Icon(
                        Icons.add,
                        size: 20.w,
                      ),
                      title: appDashBoardlblTxt(
                          controller.fengineerlist[index].dropValue),
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

  // company dp
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
                        controller.selectedcompany.value =
                            controller.fcompanylist[index].dropValue;

                        controller.idofselectedcompany.value =
                            controller.fcompanylist[index].dropId.toString();

                        log(controller.fcompanylist[index].dropValue);
                        Get.back();

                        controller.fetchSite(
                            controller.idofselectedcompany.value.toString());
                      },
                      leading: Icon(
                        Icons.add,
                        size: 20.w,
                      ),
                      title: appDashBoardlblTxt(
                          controller.fcompanylist[index].dropValue),
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

  // site dp
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
                      onTap: () async {
                        controller.selectedsite.value =
                            controller.fsitelist[index].dropValue;

                        controller.idofselectedsite.value =
                            controller.fsitelist[index].dropId.toString();

                        log(controller.fsitelist[index].dropId);
                        Get.back();

                        controller.fetchContarct(
                            controller.idofselectedsite.toString());

                        // fill some preview info
                        await controller.fillSomePreviewInfo(
                            controller.idofselectedsite.value);
                      },
                      leading: Icon(
                        Icons.add,
                        size: 20.w,
                      ),
                      title: appDashBoardlblTxt(
                          controller.fsitelist[index].dropValue),
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

  // contract dp
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
                      onTap: () async {
                        controller.selectedcontract.value =
                            controller.fcontarctlist[index].dropValue;

                        controller.idofselectedcontarct.value =
                            controller.fcontarctlist[index].dropId.toString();

                        if (controller.tog.value == 1) {
                          await controller.fetchAssetCodes(
                              controller.idofselectedcontarct.value);
                        }

                        if (controller.totaltiemcalculated.value !=
                                'To Be Determined' &&
                            controller.idofselectedtypeofhours.value != '') {
                          controller.getLabourHours(
                            controller.idofselectedtypeofhours.value,
                            controller.idofselectedcontarct.value,
                            // controller.totaltiemcalculated.value == 'To Be Determined' ? '' :
                            controller.totaltiemcalculated.value.toString(),
                          );
                        }

                        log(controller.fcontarctlist[index].dropId);
                        Get.back();
                      },
                      leading: Icon(
                        Icons.add,
                        size: 20.w,
                      ),
                      title: appDashBoardlblTxt(
                          controller.fcontarctlist[index].dropValue),
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

// contract dp
  Future<void> dpAssetCodeWidget() async {
    int listlength = controller.fassetnoelist.length;

    if (listlength > 0) {
      Get.bottomSheet(
        Obx(
          () => Column(
            children: [
              // TextField(
              //   // controller: _controller,
              //   decoration: appdpfiledDecoration(),
              //   onChanged: (val) {
              //     print(val);
              //     controller.fil(val.toString());
              //   },
              //   style: TextStyle(fontSize: 16.sp),
              // ),
              // SizedBox(height: 5.h),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: controller.fassetnoelist.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      onTap: () async {
                        controller.selectedassetno.value =
                            controller.fassetnoelist[index].dropValue;

                        controller.idofselectedassetno.value =
                            controller.fassetnoelist[index].dropId.toString();

                        log(controller.fassetnoelist[index].dropId);

                        Get.back();
                        await controller.checkAssetEnterByContract(
                            controller.idofselectedassetno.value);
                      },
                      leading: Icon(
                        Icons.add,
                        size: 20.w,
                      ),
                      title: appDashBoardlblTxt(
                          controller.fassetnoelist[index].dropValue),
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

// product type dp
  Future<void> dpProductTypeWidget() async {
    int listlength = controller.fproducttypelist.length;

    if (listlength > 0) {
      Get.bottomSheet(
        Obx(
          () => Column(
            children: [
              // TextField(
              //   // controller: _controller,
              //   decoration: appdpfiledDecoration(),
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
                  itemCount: controller.fproducttypelist.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      onTap: () {
                        controller.selectedproducttype.value =
                            controller.fproducttypelist[index].dropValue;

                        controller.idofselectedproducttype.value = controller
                            .fproducttypelist[index].dropId
                            .toString();

                        log(controller.fproducttypelist[index].dropValue);
                        Get.back();
                      },
                      leading: Icon(
                        Icons.add,
                        size: 20.w,
                      ),
                      title: appDashBoardlblTxt(
                          controller.fproducttypelist[index].dropValue),
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

// machine type dp
  Future<void> dpMachineTypeWidget() async {
    int listlength = controller.fmachinetypelist.length;

    if (listlength > 0) {
      Get.bottomSheet(
        Obx(
          () => Column(
            children: [
              // TextField(
              //   // controller: _controller,
              //   decoration: appdpfiledDecoration(),
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
                  itemCount: controller.fmachinetypelist.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      onTap: () {
                        controller.selectedmachinetype.value =
                            controller.fmachinetypelist[index].typeName;

                        controller.idofselectedmachinetype.value = controller
                            .fmachinetypelist[index].typeId
                            .toString();

                        log(controller.fmachinetypelist[index].typeName);
                        Get.back();
                      },
                      leading: Icon(
                        Icons.add,
                        size: 20.w,
                      ),
                      title: appDashBoardlblTxt(
                          controller.fmachinetypelist[index].typeName),
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
}
