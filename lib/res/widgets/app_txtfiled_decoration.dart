import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

InputDecoration appTxtfiledDecoration(String hint) {
  return InputDecoration(border: const OutlineInputBorder(), focusedBorder: const OutlineInputBorder(), hintText: hint, hintStyle: TextStyle(color: Colors.grey, fontSize: 18.sp)
      // hintStyle: Theme.of(context).textTheme.caption,
      );
}

InputDecoration appdpfiledDecoration() {
  return InputDecoration(
    hintText: "Search",
    prefixIcon: Icon(Icons.search,size: 20.w,),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(4.0),
      ),
    ),
  );
}
