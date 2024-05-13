import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sfit_getx/app/data/models/serials_chips.dart';

import '../../../../res/theme/app_colors.dart';
import '../../../../res/widgets/app_button.dart';
import '../../../../res/widgets/app_custom_text_styles.dart';
import '../../../../res/widgets/app_drop_down.dart';
import '../serviceform_controller.dart';

class StepfourView extends GetView<ServiceformController> {
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
                    appcardviewTitle('PART COST FOR SERVICE FORM'),
                    SizedBox(height: 25.h),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              appnormaltxt('Items'),
                              Obx(
                                () => customDropDowns(controller.selecteditem.value, () async {
                                  // await controller.fetchItems();
                                  controller.serialchips.clear();
                                  controller.filteritem('');
                                  controller.selecteditem.value = 'Choose one';
                                  controller.idofselecteditem.value = '';
                                  Future.delayed(const Duration(seconds: 1), () {
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              appnormaltxt('Search by Serials'),
                              TextField(
                                // controller: _controller,
                                decoration: InputDecoration(
                                  hintText: "Search Serials",
                                  suffixIcon: Icon(
                                    Icons.search_rounded,
                                    size: 55.w,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(4.r),
                                    ),
                                  ),
                                ),
                                style: TextStyle(fontSize: 16.sp),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Container(
                      child: SingleChildScrollView(physics: BouncingScrollPhysics(), child: Obx(() => ChiperBox())),
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
                                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.w),
                                      child: appnormaltxt("Total Cost : " + controller.totalcost.value.toStringAsFixed(3)),
                                    )),
                                alignment: Alignment.centerRight,
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
                    SizedBox(height: 20.h),
                    Obx(
                      () => Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          width: 200.w,
                          child: appLoadingButton(Theme.of(context).primaryColor, controller.submitAllData, 'Save', controller.isAdding.value),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
                        controller.selecteditem.value = controller.fitemslist[index].itemDes;

                        controller.idofselecteditem.value = controller.fitemslist[index].itemCode.toString();

                        controller.searchBySeriels(controller.idofselecteditem.value);

                        log(controller.fitemslist[index].itemDes);
                        Get.back();
                      },
                      leading: Icon(
                        Icons.add,
                        size: 20.w,
                      ),
                      title: appDashBoardlblTxt(controller.fitemslist[index].itemDes),
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

// chipper box serial numbers
  Widget ChiperBox() {
    return Wrap(
      spacing: 20.w,
      runSpacing: 5.h,
      alignment: WrapAlignment.center,
      children: controller.serialchips
          .map((chip) => Chip(
                label: Text(
                  chip.serial_no,
                  style: TextStyle(fontSize: 16.sp),
                ),
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
          itemCount: controller.serialinfolist.length,
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
            var data = controller.serialinfolist[index];
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

                        controller.serialchips.add(SerialChips(index: controller.predicchipscount, serial_no: reSerialNo));

                        controller.serialinfolist.removeAt(index);

                        controller.predicchipscount++;
                        controller.totalCost();

                        //blistOfDrofDownValues.add(DropDownTypesSerialNumbers(index: 1000,serial_no: 'dasun'));

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
}
