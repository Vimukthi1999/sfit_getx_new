import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../../res/widgets/app_custom_text_styles.dart';
import '../serviceform_controller.dart';

class PreviewView extends GetView<ServiceformController> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      controller: controller.previewScroll,
      child: Padding(
        padding: EdgeInsets.all(10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //<----------- title ------------
            appcardviewTitle('Field Service Entries'),
            SizedBox(height: 15.h),
            //<----------- company ------------
            // item('Company', controller.selectedcompany.value == 'Choose one' ? 'N/A' : controller.selectedcompany.value),

            item(
              'Company',
              controller.tog.value == 0
                  ? controller.setCompany.value
                  : controller.selectedcompany.value == 'Choose one'
                      ? 'N/A'
                      : controller.selectedcompany.value,
            ),

            //<----------- srf no ------------
            item('SRF-No', ''),

            //<----------- site ------------
            item(
              'Site',
              controller.tog.value == 0
                  ? controller.setSite.value
                  : controller.selectedsite.value == 'Choose one'
                      ? 'N/A'
                      : controller.selectedsite.value,
            ),

            //<----------- address ------------
            item('Address', controller.preAddress.value),

            //<----------- city ------------
            item('City', controller.preCity.value),

            //<----------- post code ------------
            item('Post Code', controller.prePostCode.value),

            //<----------- tel ------------
            item('Tel', controller.preTel.value),

            //<----------- fax ------------
            item('Fax', controller.preFax.value),

            //<----------- email ------------
            item('Email', controller.preEmail.value),

            //<----------- contract id ------------
            item(
                'Contract ID',
                controller.idofselectedcontarct.value == ''
                    ? 'N/A'
                    : controller.idofselectedcontarct.value),

            //<----------- contract ------------
            item(
                'Contract',
                controller.selectedcontract.value == 'Choose one'
                    ? 'N/A'
                    : controller.selectedcontract.value),

            //<----------- asset no ------------
            item(
              'SFIT Asset No',
              controller.tog.value == 0
                  ? controller.assetcontroller.text.isEmpty
                      ? 'N/A'
                      : controller.assetcontroller.text
                  : controller.selectedassetno.value == 'Choose one'
                      ? 'N/A'
                      : controller.selectedassetno.value,
            ),

            SizedBox(height: 10.h),

            //<----------- divider ------------
            dividItem('ATERA RECORD'),
            SizedBox(height: 10.h),
            dividItem('SERVICE FORM RELATED'),
            SizedBox(height: 10.h),
            dividItem('TICKETS RELATED'),
            //<----------- divider ------------
          ],
        ),
      ),
    );
  }

  Widget item(String question, String answer) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Text(
              '$question :',
              style: TextStyle(
                fontSize: 16.sp,
              ),
            ),
          ),
          Expanded(
            child: Text(
              answer,
              style: TextStyle(
                fontSize: 16.sp,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget dividItem(String txt) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Divider(
            color: Colors.black12,
            thickness: 3,
            indent: 20,
            endIndent: 20,
          ),
        ),
        Text(
          txt,
          style: TextStyle(
            fontSize: 16.sp,
          ),
        ),
        Expanded(
          child: Divider(
            color: Colors.black12,
            thickness: 3,
            indent: 20,
            endIndent: 20,
          ),
        ),
      ],
    );
  }
}
