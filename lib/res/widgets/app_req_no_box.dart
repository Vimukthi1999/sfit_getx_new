
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget reqBox(String reqno) {
  return Container(
    height: 55.w,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.r),
      color: Colors.black12,
    ),
    padding: EdgeInsets.symmetric(horizontal: 30.w
    ),
    child: Center(
      child: Text(
        reqno,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.black26, fontWeight: FontWeight.bold,
        fontSize: 16.sp),
      ),
    ),
  );
}
