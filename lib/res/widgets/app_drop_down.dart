import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sfit_getx/res/theme/app_colors.dart';

import 'app_custom_text_styles.dart';

Widget customDropDowns(String hintTxt, Function function) {
  return Container(
    height: 55.w,
    decoration: BoxDecoration(
        border: Border.all(
      color: Colors.black,
      width: 1.0.w,
      style: BorderStyle.solid,
    )),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: apphintTxt(
            hintTxt,
            // textAlign: TextAlign.right,
          ),
        ),
        IconButton(
          onPressed: () {
            function();
          },
          icon: Icon(
            Icons.arrow_drop_down_circle,
            color: AppColor.mainBlueColor,
            size: 25.w,
          ),
          padding: EdgeInsets.only(right: 4.w),
        )
      ],
    ),
  );
}
