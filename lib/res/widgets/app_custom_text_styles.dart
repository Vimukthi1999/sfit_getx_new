import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// required label
Widget appfReqTxt(String txt) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 5, top: 5),
    child: Text.rich(
      TextSpan(
        text: txt,
        children: const [
          TextSpan(
            text: ' *',
            style: TextStyle(color: Colors.red),
          ),
        ],
        style: const TextStyle(color: Colors.black54),
      ),
    ),
  );
}

/// header title
Widget appheaderTitle() {
  return Text(
    'System Force I.T.',
    style: TextStyle(
      fontSize: 38.sp,
      fontWeight: FontWeight.bold,
    ),
  );
}

/// header sub title
Widget appheaderSubTitle(String txt) {
  return Text(
    txt,
    style: TextStyle(
      fontSize: 24.sp,
      fontWeight: FontWeight.normal,
      color: Colors.black54,
    ),
  );
}

/// header sub title
Widget appcardviewTitle(String txt) {
  return Text(
    txt,
    style: TextStyle(
      fontSize: 18.sp,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
  );
}

/// dp hint lables
Widget apphintTxt(String txt) {
  return Padding(
    padding: EdgeInsets.fromLTRB(10.w, 0, 0, 0),
    child: Text(
      txt,
      style: TextStyle(color: Colors.black, fontSize: 15.sp),
    ),
  );
}

/// service forms create screen lable
Widget appnormaltxt(String txt) {
  return Padding(
    padding: EdgeInsets.only(bottom: 5.h),
    child: Text(
      txt,
      style: TextStyle(
        fontSize: 18.sp,
        color: Colors.black,
      ),
    ),
  );
}

/// service forms create screen req lable
Widget appreqtxt(String txt) {
  return Padding(
    padding: EdgeInsets.only(bottom: 5.h),
    child: Text.rich(
      TextSpan(
        text: txt,
        style: TextStyle(
          fontSize: 18.sp,
          color: Colors.black,
        ),
        children: [
          TextSpan(
            text: ' *',
            style: TextStyle(
              color: Colors.red,
              fontSize: 16.sp,
            ),
          ),
        ],
      ),
    ),
  );
}

/// table header
Widget apptableHeadertxt(String txt) {
  return Expanded(
    child: Center(
      child: Text(
        txt,
        textAlign: TextAlign.center,
        style: TextStyle( fontSize: 18.sp),
      ),
    ),
  );
}

/// table header
Widget apptableDatatxt(String txt) {
  return Expanded(
    child: Center(
      child: Text(
        txt,
        textAlign: TextAlign.center,
        style: TextStyle( fontSize: 17.sp),
      ),
    ),
  );
}

/// item table header
Widget appitemtableHeadertxt(String txt) {
  return Text(
    txt,
    textAlign: TextAlign.start,
    style: TextStyle( fontSize: 17.sp),
  );
}

/// item table data
Widget appitemtableDatatxt(String txt) {
  return Text(
    txt,
    textAlign: TextAlign.start,
    style: TextStyle( fontSize: 16.sp,
    // overflow: TextOverflow.ellipsis
    ),
  );
}

/// normal label
Widget appfTxt(String txt) {
  return Padding(
    padding: EdgeInsets.only(bottom: 5.h, top: 5.h),
    child: Text.rich(
      TextSpan(
        text: txt,
        style: TextStyle(color: Colors.black54, fontSize: 18.sp),
      ),
    ),
  );
}

/// normal label
Widget appDashBoardlblTxt(String txt) {
  return Padding(
    padding: EdgeInsets.only(bottom: 5.h, top: 5.h),
    child: Text.rich(
      TextSpan(
        text: txt,
        style: TextStyle(color: Colors.black, fontSize: 16.sp),
      ),
    ),
  );
}

Widget appClickableTxtWithInkwell(String txt, void Function() click) {
  return Text.rich(
    TextSpan(
      text: txt,
      children: [
        WidgetSpan(
          child: InkWell(
            onTap: click,
            child: const Text(
              ' Yes',
              style: TextStyle(color: Colors.amber, fontSize: 18),
            ),
          ),
        )
      ],
      style: const TextStyle(color: Colors.black54),
    ),
  );
}

Widget appClickbleTxt(BuildContext context, String txt, String clicktxt, void Function() click) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 5, top: 5),
    child: RichText(
        text: TextSpan(children: [
      TextSpan(
        text: '$txt  ',
        style: const TextStyle(color: Colors.black54),
      ),
      TextSpan(
        text: clicktxt,
        style: TextStyle(color: Theme.of(context).primaryColor),
        recognizer: TapGestureRecognizer()..onTap = click,
      ),
    ])),
  );
}

Widget appHomeCardTxt(String txt) {
  return Text(
    txt,
    textAlign: TextAlign.center,
  );
}

Widget appBarTxt(String txt) {
  return Text(
    txt,
  );
}

Widget drawerTitleTxt(String txt) {
  return Text(txt);
}

Widget drawerFooterTxt(String txt) {
  return Text(txt);
}

Widget contentTxt(String txt) {
  return Text(txt);
}

/// for card views
Widget cardviewTitleTxt(String txt) {
  return Text(txt);
}

Widget cardviewTxt(String txt) {
  return Text(txt);
}

Widget cardviewButtonsTxt(String txt) {
  return Text(
    txt,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(color: Colors.black),
  );
}

Widget cardviewStatusTxt(String txt, Color color) {
  return Text(txt, style: TextStyle(color: color, fontSize: 12));
}
