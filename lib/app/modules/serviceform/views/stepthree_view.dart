import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../../res/theme/app_colors.dart';
import '../../../../res/widgets/app_custom_text_styles.dart';
import '../../../../res/widgets/app_drop_down.dart';
import '../serviceform_controller.dart';

class StepthreeView extends GetView<ServiceformController> {
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
              Padding(
                padding: EdgeInsets.all(10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // appcardviewTitle('SERVICE RECORD FORM'),
                    // SizedBox(height: 25.h),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              appreqtxt('To be paid in'),
                              Obx(
                                () => customDropDowns(controller.selectedtobepaidin.value, () {
                                  Future.delayed(const Duration(seconds: 1), () {
                                    dpToBePaidInWidget();
                                  });
                                }),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(child: SizedBox()),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              appnormaltxt('Product Type'),
                              Obx(
                                () => customDropDowns(controller.selectedproducttype.value, () {
                                  Future.delayed(const Duration(seconds: 1), () {
                                    dpProductTypeWidget();
                                  });
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
                              appnormaltxt('Serial/Ticket Number'),
                              Container(
                                height: 55.w,
                                width: Get.width,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                  color: Colors.black,
                                  width: 1.w,
                                  style: BorderStyle.solid,
                                )),
                                child: Center(
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(10.w, 0, 0, 0),
                                    child: TextField(
                                      controller: controller.ticketNocontroller,
                                      decoration: InputDecoration(
                                        hintText: '--------',
                                        hintStyle: TextStyle(color: Colors.black, fontSize: 15.sp),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              appreqtxt('Type of hours'),
                              Obx(
                                () => customDropDowns(controller.selectedtypeofhours.value, () {
                                  Future.delayed(const Duration(seconds: 1), () {
                                    dpTypeofHoursWidget();
                                  });
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
                              appnormaltxt('Labour'),
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
                                    child: Align(alignment: Alignment.centerLeft, child: apphintTxt(controller.valueofLabourHours.value))),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),

                    buildexpandItems(true, 'Problem', 'As Stated or Requested by the Client', controller.problemcontroller),
                    buildexpandItems(false, 'Findings', 'Initial Investigation', controller.findingcontroller),
                    buildexpandItems(false, 'Work Undertaken', '', controller.workUndercontroller),
                    buildexpandItems(false, 'Recommendations', '', controller.recommendationcontroller),
                    buildexpandItems(false, 'Action Task', '', controller.actiontaskcontroller),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildexpandItems(bool isreq, String title, String hint, TextEditingController txtcontroller) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15.w),
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
              ),
            ],
            onExpansionChanged: (isExpanded) => {},
          ),
        ),
      ),
    );
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
              //   decoration: appdpfiledDecoration(),
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
                        controller.selectedtobepaidin.value = controller.ftobepaidinlist[index].dropValue;

                        controller.idofselectedtobepaidin.value = controller.ftobepaidinlist[index].dropId.toString();

                        log(controller.ftobepaidinlist[index].dropValue);
                        Get.back();
                      },
                      leading: Icon(Icons.add,size: 20.w,),
                      title: appDashBoardlblTxt(controller.ftobepaidinlist[index].dropValue),
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
              SizedBox(height: 5),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: controller.fproducttypelist.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      onTap: () {
                        controller.selectedproducttype.value = controller.fproducttypelist[index].dropValue;

                        controller.idofselectedproducttype.value = controller.fproducttypelist[index].dropId.toString();

                        log(controller.fproducttypelist[index].dropValue);
                        Get.back();
                      },
                      leading: Icon(Icons.add,size: 20.w,),
                      title: appDashBoardlblTxt(controller.fproducttypelist[index].dropValue),
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
                  itemCount: controller.ftypeofhourslist.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      onTap: () {
                        controller.selectedtypeofhours.value = controller.ftypeofhourslist[index].dropValue;

                        controller.idofselectedtypeofhours.value = controller.ftypeofhourslist[index].dropId.toString();
                        Get.back();
                        controller.getLabourHours(controller.idofselectedtypeofhours.value, controller.idofselectedcontarct.value, 
                        // controller.totaltiemcalculated.value == 'To Be Determined' ? '' : 
                        controller.totaltiemcalculated.value.toString());

                        log(controller.ftypeofhourslist[index].dropValue);
                      },
                      leading: Icon(Icons.add,size: 20.w,),
                      title: appDashBoardlblTxt(controller.ftypeofhourslist[index].dropValue),
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
