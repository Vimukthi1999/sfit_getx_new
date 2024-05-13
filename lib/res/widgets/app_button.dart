import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Widget appButton(void Function() click, String btntxt, Color? color) {
  return InkWell(
    onTap: click,
    child: Container(
      width: Get.width,
      height: 50.w,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5.r),
      ),
      child: Center(
          child: Text(
        btntxt,
        style: TextStyle(
          fontSize: 16.sp,
          color: Colors.white
        ),
        textAlign: TextAlign.center,
        
      )),
    ),
  );
}

Widget appLoadingButton(Color? color, void Function() click, String btntxt, bool needLoad) {
  return InkWell(
    onTap: click,
    child: Container(
      // width: MediaQuery.of(context).size.width,
      height: 50.w,
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
                style: TextStyle(
                  fontSize: 18.sp,
                  color: Colors.white
                ),
                textAlign: TextAlign.center,
              ),
      ),
    ),
  );
}

Widget appSubButton(BuildContext context, void Function() click, String btntxt) {
  return InkWell(
    onTap: click,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 100,
        height: 50,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Text(btntxt, style: Theme.of(context).textTheme.bodyMedium),
        ),
      ),
    ),
  );
}
