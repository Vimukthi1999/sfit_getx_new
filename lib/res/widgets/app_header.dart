import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sfit_getx/res/image_path/app_imgpaths.dart';
import 'app_custom_text_styles.dart';

Widget buildHeader() {
  return Container(
      //width: 600,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Color.fromRGBO(0, 197, 255, .6),
          Color.fromRGBO(0, 114, 255, 1),
        ]),
      ),
      padding: EdgeInsets.all(10.w).copyWith(left: 5.w),
      alignment: Alignment.topLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                height: 50.h,
                width: 60.w,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage(AppImgPath.logo), fit: BoxFit.fill),
                ),
              ),
              SizedBox(width: 20.w),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      child: appheaderTitle(),
                    ),
                    Container(
                      alignment: Alignment.bottomLeft,
                      child: appheaderSubTitle('FIELD SERVICE ENTRIES'),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),);
}

Widget buildPreviewHeader(BuildContext context, String subTitle,var perviewOpen) {
  return Container(
      //width: 600,
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
          Color.fromRGBO(0, 197, 255, .6),
          Color.fromRGBO(0, 114, 255, 1),
        ]),
      ),
      padding: EdgeInsets.all(10.w).copyWith(left: 5.w),
      alignment: Alignment.topLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    size: 35.w,
                  )),
              SizedBox(width: 20.h),
              // Container(
              //   height: 80,
              //   width: 90,
              //   decoration: const BoxDecoration(
              //     image: DecorationImage(image: AssetImage('assets/images/logo_system_foce.png'), fit: BoxFit.fill),
              //   ),
              // ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(alignment: Alignment.topLeft, child: appheaderTitle()),
                    //SizedBox(height: 10,),

                    Container(
                      alignment: Alignment.bottomLeft,
                      child: appheaderSubTitle(subTitle),
                    )
                  ],
                ),
              ),
            ],
          ),
          InkWell(
            // onTap: () {
            //   // showPreviewDialog(context);
            //   // CustomDrawerButton();
            //   controller.
            // },
            onTap: perviewOpen,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Padding(
                padding: EdgeInsets.all(12.w),
                child: Text(
                  ' PREVIEW ',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ),
          ),
        ],
      ));
}
