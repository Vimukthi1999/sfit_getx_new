import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../res/theme/app_colors.dart';
import '../res/widgets/app_button.dart';

class Utils {
  // show toast msg
  static toastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.black,
      textColor: Colors.white,
    );
  }

  // show flush error msg
  static void flushBarNav(String message, BuildContext context) {
    showFlushbar(
      context: context,
      flushbar: Flushbar(
        forwardAnimationCurve: Curves.decelerate,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.all(15),
        message: message,
        duration: const Duration(seconds: 5),
        borderRadius: BorderRadius.circular(8),
        flushbarPosition: FlushbarPosition.TOP,
        backgroundColor: Colors.red,
        reverseAnimationCurve: Curves.easeInOut,
        positionOffset: 20,
        onTap: (_) {
          // Navigator.of(context).pushNamed(AppRouteName.myads);
        },
        icon: const Icon(
          Icons.error,
          size: 28,
          color: Colors.white,
        ),
      )..show(context),
    );
  }

  // show flush error msg
  static void flushBarErrorMessage(String message, BuildContext context) {
    showFlushbar(
      context: context,
      flushbar: Flushbar(
        forwardAnimationCurve: Curves.decelerate,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.all(15),
        message: message,
        duration: const Duration(seconds: 5),
        borderRadius: BorderRadius.circular(8),
        flushbarPosition: FlushbarPosition.TOP,
        backgroundColor: Colors.red,
        reverseAnimationCurve: Curves.easeInOut,
        positionOffset: 20,
        icon: Icon(
          Icons.error,
          size: 28.w,
          color: Colors.white,
        ),
      )..show(context),
    );
  }

  // show snack bar
  static snackBar(String message, BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(message, style: TextStyle(
            fontSize: 18.sp,
          color: Colors.white
          ),),
      ),
    );
  }

  static getXsnackBar(
    String title,
    String message,
  ) {
    Get.showSnackbar(
      GetSnackBar(
        // title: title,
        titleText: Padding(
          padding: EdgeInsets.all(10.w).copyWith(bottom: 0),
          child: Text(title, style: TextStyle(fontSize: 18.sp,
          color: Colors.white)),
        ),
        // message: message,
        messageText: Padding(
          padding: EdgeInsets.all(10.w).copyWith(top: 0.w),
          child: Text(message, style: TextStyle(
            fontSize: 18.sp,
          color: Colors.white
          ),),
        ),
        icon: Icon(Icons.warning, size: 30.w,color: Colors.white,),
        duration: const Duration(seconds: 5),
      ),
    );
  }

  static getXSuccesssnackBar(
    String message,
  ) {
    Get.showSnackbar(
      GetSnackBar(
        titleText: Padding(
          padding: EdgeInsets.all(10.w).copyWith(bottom: 0),
          child: Text('Successfull', style: TextStyle(fontSize: 18.sp,
          color: Colors.white)),
        ),
        // title: 'Successfull',
        // message: message,
        messageText: Padding(
          padding: EdgeInsets.all(10.w).copyWith(top: 0.w),
          child: Text(message, style: TextStyle(
            fontSize: 18.sp,
          color: Colors.white
          ),),
        ),
        icon: Icon(Icons.done_outline_rounded, size: 30.w,color: Colors.white,),
        duration: const Duration(seconds: 5),
      ),
    );
  }

  static void appDialog(String status, String msg, void Function() click) {
    Get.defaultDialog(
      barrierDismissible: false,
      title: status,
      content: SizedBox(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8.w),
            child: Column(
              children: [Text(msg, style: TextStyle(fontSize: 18.sp),), SizedBox(height: 15.h), SizedBox(width: 100.w, child: appButton(click, 'Ok', AppColor.mainBlueColor))],
            ),
          ),
        ),
      ),
      titleStyle: TextStyle(color: Colors.black, fontSize: 19.sp),
      titlePadding: EdgeInsets.all(10.w),
      radius: 5.r,
    );
  }

  static void hideLoading() {
    Get.back();
  }

  static void showLoading({String title = "Loading..."}) {
    Get.dialog(
      WillPopScope(
        onWillPop: () async => false,
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Padding(
            padding: EdgeInsets.all(15.w),
            child: Container(
              height: 40.h,
              width: Get.width / 2.w,
              child: Row(
                children: [
                  SizedBox(
                    width: 30.w,
                  ),
                  Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18.sp
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }
}
