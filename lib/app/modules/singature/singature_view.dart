// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'package:get/get.dart';
import '../../../res/widgets/app_header.dart';
import 'singature_controller.dart';
import 'views/preview_view.dart';

class SingatureView extends GetView<SingatureController> {
  var argumentData = Get.arguments;
  @override
  Widget build(BuildContext context) {
    controller.fetchData(argumentData);
    return SafeArea(
      child: Scaffold(
        key: controller.scaffoldKey,
        // floatingActionButton: FloatingActionButton(onPressed: () {
        //   Future.delayed(Duration.zero, () {
        //     Get.toNamed(Routes.DASHBOARD);
        //   });
        // }),
        drawer: Container(
          color: Colors.grey[350],
          width: Get.width * 0.5,
          height: Get.height,
          child: PreviewView(),
        ),
        body: Column(
          children: [
            // buildPreviewHeader(context, 'Service Record Form', controller.openDrower),
            buildSignPreviewHeader(
                context, 'Service Record Form', controller.openDrower),
            Expanded(
              child: ListView(
                physics: BouncingScrollPhysics(),
                controller: controller.viewScrollController,
                children: [
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
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                normaltxt('Your Requisition Number'),
                                SizedBox(width: 20.w),
                                reqnoBox(argumentData["reqno"].toString()),
                              ],
                            ),
                            SizedBox(height: 20.h),
                            // engineer signpad
                            Obx(
                              () => Visibility(
                                // visible: !controller.clientSignPad.value,
                                visible: controller.engineerSignPad.value,
                                child: Card(
                                  margin: EdgeInsets.symmetric(horizontal: 30.h)
                                      .copyWith(bottom: 5.h),
                                  color: const Color(0xffff0f0f0),
                                  shadowColor: Colors.black,
                                  elevation: 2.w,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(1.r),
                                  ),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(top: 1.h),
                                        child: Container(
                                          color: Colors.white,
                                          height: 50.h,
                                          child: Padding(
                                            padding:
                                                EdgeInsets.only(left: 10.w),
                                            child: Row(
                                              children: [
                                                FaIcon(
                                                  FontAwesomeIcons.penToSquare,
                                                  size: 20.w,
                                                ),
                                                SizedBox(width: 10.w),
                                                normaltxt(
                                                    'Engineer\'s Signature')
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(15.w),
                                        child: Container(
                                          height: 200.h,
                                          // width: Get.width - 100,
                                          // color: Colors.red,
                                          child: SfSignaturePad(
                                            backgroundColor: Colors.white,
                                            key: controller
                                                .engineersignatureGlobalKey,
                                            strokeColor: Colors.blue,
                                            minimumStrokeWidth: 3.w,
                                            maximumStrokeWidth: 3.w,
                                            onDrawStart:
                                                controller.handleOnDrawStart,
                                          ),
                                        ),
                                      ),
                                      // SizedBox(height: 20.h),
                                      Padding(
                                        padding: EdgeInsets.only(left: 15.w),
                                        child: clientnotavailableCheckBox(),
                                      ),

                                      Obx(
                                        () => Visibility(
                                          visible: controller.isclientnot.value,
                                          child: Padding(
                                            padding: EdgeInsets.all(15.w),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                color: Colors.black,
                                                width: 1.w,
                                                style: BorderStyle.solid,
                                              )),
                                              child: Padding(
                                                padding:
                                                    EdgeInsets.only(left: 10.w),
                                                child: TextField(
                                                  decoration: InputDecoration(),
                                                  maxLines: 3,
                                                  controller: controller
                                                      .reasoncontroller,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),

                                      Padding(
                                        padding: EdgeInsets.only(
                                            right: 15.w, bottom: 8.h),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Container(
                                                height: 45.w,
                                                width: 50.w,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey[50],
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.r),
                                                ),
                                                child: IconButton(
                                                    onPressed: () {
                                                      controller
                                                          .clearEngineerPad();
                                                    },
                                                    icon: FaIcon(
                                                      FontAwesomeIcons.eraser,
                                                      size: 30.w,
                                                    ))),
                                            SizedBox(width: 20.w),
                                            submitButton(
                                                Theme.of(context).primaryColor,
                                                () {
                                              controller.saveEngeerSign(
                                                  argumentData["reqno"]
                                                      .toString());
                                            },
                                                'Submit Signature',
                                                controller
                                                    .isEngSignLoading.value),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10.h),

                            // client signpad
                            Obx(
                              () => Visibility(
                                visible: controller.clientSignPad.value,
                                child: Card(
                                  margin: EdgeInsets.symmetric(horizontal: 30.h)
                                      .copyWith(bottom: 5.h),
                                  color: const Color(0xffff0f0f0),
                                  shadowColor: Colors.black,
                                  elevation: 2.w,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(1.r),
                                  ),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(top: 1.h),
                                        child: Container(
                                          color: Colors.white,
                                          height: 50.h,
                                          child: Padding(
                                            padding:
                                                EdgeInsets.only(left: 10.w),
                                            child: Row(
                                              children: [
                                                FaIcon(
                                                  FontAwesomeIcons.penToSquare,
                                                  size: 20.w,
                                                ),
                                                SizedBox(width: 10.w),
                                                normaltxt('Client\'s Signature')
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(15.w),
                                        child: Container(
                                          height: 200.h,
                                          // width: Get.width - 100,
                                          // color: Colors.red,
                                          child: SfSignaturePad(
                                            backgroundColor: Colors.white,
                                            key: controller
                                                .clientsignatureGlobalKey,
                                            strokeColor: Colors.blue,
                                            minimumStrokeWidth: 3.w,
                                            maximumStrokeWidth: 3.w,
                                            onDrawStart:
                                                controller.handleOnDrawStartCli,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10.h),
                                      Padding(
                                        padding: EdgeInsets.all(15.w),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                            color: Colors.black,
                                            width: 1.w,
                                            style: BorderStyle.solid,
                                          )),
                                          child: Padding(
                                            padding:
                                                EdgeInsets.only(left: 10.w),
                                            child: TextField(
                                              decoration: InputDecoration(
                                                hintText: "Customer Name",
                                                hintStyle: TextStyle(
                                                  fontSize: 16.sp,
                                                ),
                                              ),
                                              style: TextStyle(fontSize: 16.sp),
                                              textInputAction:
                                                  TextInputAction.done,
                                              maxLines: 1,
                                              controller:
                                                  controller.cusnamecontroller,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            right: 15.w, bottom: 8.h),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Container(
                                                height: 45.w,
                                                width: 50.w,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey[50],
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.r),
                                                ),
                                                child: IconButton(
                                                    onPressed: () {
                                                      controller
                                                          .clearClientPad();
                                                    },
                                                    icon: FaIcon(
                                                      FontAwesomeIcons.eraser,
                                                      size: 30.w,
                                                    ))),
                                            SizedBox(width: 20.w),
                                            submitButton(
                                                Theme.of(context).primaryColor,
                                                () {
                                              controller.saveClientSign(
                                                  argumentData["reqno"]
                                                      .toString());
                                            },
                                                'Submit Signature',
                                                controller
                                                    .isCliSignLoading.value),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // check box
  Widget clientnotavailableCheckBox() {
    return SizedBox(
      // height: 90.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            // color: Colors.black12,
            child: Transform.scale(
              scale: 1.5.w,
              child: Obx(
                () => Checkbox(
                  checkColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                  value: controller.isclientnot.value,
                  onChanged: (val) {
                    controller.isclientnot.value = val!;
                  },
                ),
              ),
            ),
          ),
          SizedBox(width: 11.h),
          normaltxt(
            'Client Not Available',
          ),
        ],
      ),
    );
  }

  Widget reqnoBox(String reqno) {
    return Container(
      // height: 55.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: Colors.black12,
      ),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      child: Center(
        child: Text(
          reqno,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.black26,
              fontWeight: FontWeight.bold,
              fontSize: 16.sp),
        ),
      ),
    );
  }

  Widget normaltxt(String txt) {
    return Text(
      txt,
      style: TextStyle(
        fontSize: 18.sp,
        color: Colors.black,
      ),
    );
  }

  Widget submitButton(
      Color? color, void Function() click, String btntxt, bool needLoad) {
    return InkWell(
      onTap: click,
      child: Container(
        width: 200.w,
        height: 45.w,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(5.r),
        ),
        child: Center(
          child: needLoad
              ? const CircularProgressIndicator.adaptive(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                )
              : Text(
                  btntxt,
                  style: TextStyle(fontSize: 18.sp, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
        ),
      ),
    );
  }
}
