import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:sfit_getx/app/modules/serviceform/serviceform_controller.dart';
import '../../../../res/time_text_formatter.dart';
import '../../../../res/widgets/app_custom_text_styles.dart';
import '../../../../res/widgets/app_datetime_pickers.dart';

class SteptwoView extends GetView<ServiceformController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
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
                      appcardviewTitle('SERVICE RECORD FORM'),
                      SizedBox(height: 25.w),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                        alignment: Alignment.centerLeft,
                                        child: Obx(
                                          () => Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  controller.dePriority(
                                                      controller
                                                          .priority.value);
                                                },
                                                child: Icon(
                                                  Icons
                                                      .indeterminate_check_box_rounded,
                                                  size: 55.w,
                                                  color: controller
                                                              .priority.value ==
                                                          1
                                                      ? Colors.grey
                                                      : Colors.black,
                                                ),
                                              ),
                                              Container(
                                                child: Text(
                                                  controller.priority.value
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 18.sp),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  controller.inPriority(
                                                      controller
                                                          .priority.value);
                                                },
                                                child: Icon(
                                                  Icons.add_box_rounded,
                                                  size: 55.w,
                                                  color: controller
                                                              .priority.value ==
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
                          SizedBox(width: 10.w),
                          Expanded(child: buildInWarrentyCheckBox(context)),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: buildformDateTimePicker(
                                  'Request Date',
                                  controller.requestDate.value,
                                  context,
                                  true, () {
                                controller.pickRequestDate(context);
                              }),
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: Container(
                              child: buildformDateTimePicker(
                                  'Request Time',
                                  controller.requestTime.value,
                                  context,
                                  false, () {
                                controller.pickRequestTime(context);
                              }),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: buildformDateTimePicker(
                                  'Service Date',
                                  controller.serviceDate.value,
                                  context,
                                  true, () {
                                controller.pickServiceDate(context);
                              }),
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: Container(
                              child: Obx(() => buildformAddLaterTimePicker(
                                  'Start Time',
                                  controller.startTime.value,
                                  startTime(context,
                                      controller.isStartTimeAddLater.value, () {
                                    controller.pickStartTime(context);
                                  }))),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: Obx(() => buildformAddLaterTimePicker(
                                  'End Time',
                                  controller.endTime.value,
                                  endTime(context,
                                      controller.isEndTimeAddLater.value, () {
                                    controller.pickEndTime(context);
                                  }))),
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                appreqtxt('Travel Time:'),
                                Container(
                                  height: 55.w,
                                  width: Get.width,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                    color: Colors.black,
                                    width: 1.0,
                                    style: BorderStyle.solid,
                                  )),
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(20.h, 0, 0, 0),
                                    child: Center(
                                      child: TextField(
                                        controller:
                                            controller.traveltimecontroller,
                                        decoration: InputDecoration(
                                          hintText: 'hh:mm',
                                          hintStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15.sp),
                                          border: InputBorder.none,
                                        ),
                                        keyboardType: TextInputType.number,
                                        textInputAction: TextInputAction.done,
                                        inputFormatters: <TextInputFormatter>[
                                          TimeTextInputFormatter()
                                          // This input formatter will do the job
                                        ],
                                        onTap: () {
                                          controller.traveltimecontroller
                                              .selection = TextSelection(
                                            baseOffset: 0,
                                            extentOffset: controller
                                                .traveltimecontroller
                                                .value
                                                .text
                                                .length,
                                          );
                                          controller.traveltimecontroller
                                              .clear();
                                        },
                                        onEditingComplete: () {
                                          FocusScope.of(context).unfocus();
                                          controller.genTraveltime();
                                        },
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
                                appnormaltxt('Total Time Calculated'),
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
                                          child: apphintTxt(controller
                                              .totaltiemcalculated.value))),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: SizedBox(),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // check box
  Widget buildInWarrentyCheckBox(BuildContext context) {
    return Obx(() => SizedBox(
          height: 55.w,
          child: Row(
            children: [
              Transform.scale(
                scale: 1.75.w,
                child: Checkbox(
                  checkColor: Colors.white,
                  activeColor: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                  value: controller.iswarrenty.value,
                  onChanged: (val) {
                    controller.iswarrenty.value = val!;
                  },
                ),
              ),
              SizedBox(width: 15.h),
              Center(child: appnormaltxt('In Warranty')),
            ],
          ),
        ));
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
}
