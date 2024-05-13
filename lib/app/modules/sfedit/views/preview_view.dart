import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:sfit_getx/app/modules/sfedit/sfedit_controller.dart';

import '../../../../res/widgets/app_custom_text_styles.dart';

class PreviewView extends GetView<SfeditController> {
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
            item('Company', controller.Obj.value.data.svcData[0].companyName ?? 'N/A'),

            //<----------- srf no ------------
            item('SRF-No', controller.Obj.value.data.svcData[0].srfno  ?? 'N/A'),

            //<----------- site ------------
            item('Site', controller.Obj.value.data.svcData[0].siteName  ?? 'N/A'),

            //<----------- address ------------
            item('Address', controller.Obj.value.data.svcData[0].address  ?? 'N/A' ),

            //<----------- city ------------
            item('City', controller.Obj.value.data.siteinfoFrmTkt[0].city  ?? 'N/A' ),

            //<----------- post code ------------
            item('Post Code', controller.Obj.value.data.svcData[0].postcode  ?? 'N/A' ),

            //<----------- tel ------------
            item('Tel', controller.Obj.value.data.svcData[0].phoneNo  ?? 'N/A' ),

            //<----------- fax ------------
            item('Fax', controller.Obj.value.data.svcData[0].fax  ?? 'N/A' ),

            //<----------- email ------------
            item('Email', controller.Obj.value.data.svcData[0].email  ?? 'N/A' ),

            //<----------- contract id ------------
            item('Contract ID', controller.Obj.value.data.svcData[0].contractId  ?? 'N/A' ),

            //<----------- contract ------------
            item('Contract', controller.Obj.value.data.svcData[0].contractDescription  ?? 'N/A' ),

            //<----------- asset no ------------
            item('SFIT Asset No', controller.Obj.value.data.svcData[0].sfitAssetNo  ?? 'N/A' ),

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
