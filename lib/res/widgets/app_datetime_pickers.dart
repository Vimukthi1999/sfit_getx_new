import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_custom_text_styles.dart';

/// normal picker
Widget buildformDateTimePicker(String title, String value, BuildContext context, bool isdate,  void Function() click) {
  return Container(
    // margin: EdgeInsets.symmetric(vertical: 10.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        appreqtxt(title),
        Container(
          height: 55.w,
          decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 1.w), borderRadius: BorderRadius.all(Radius.circular(0))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: apphintTxt(value
                    // '${pickedDateFrom.day} / ${pickedDateFrom.month} / ${pickedDateFrom.year}'
                    ),
              ),
              Container(
                height: 55.h,
                width: 55.w,
                color: Colors.grey[300],
                child: IconButton(
                  icon: Icon(
                    isdate ? Icons.calendar_today : Icons.access_time_rounded,
                    color: Theme.of(context).primaryColor,
                    size: 25.w,
                  ),
                  // tooltip: 'Tap to open date picker',
                  onPressed: click,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

/// add later time picker
  Widget buildformAddLaterTimePicker(String title, String value,Widget widget) {
    return Container(
      // margin: EdgeInsets.symmetric(vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          appreqtxt(title),
          Container(
            height: 55.w,
            decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 1.w), borderRadius: BorderRadius.all(Radius.circular(0))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: apphintTxt(value
                      // '${pickedDateFrom.day} / ${pickedDateFrom.month} / ${pickedDateFrom.year}'
                      ),
                ),
                Container(
                  height: 55.h,
                  // width: 55.w,
                  color: Colors.grey[300],
                  child: widget
                  
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
