import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void showAppDialog(String title, String description) {
  Get.defaultDialog(
    title: 'Not Success',
    middleText: description,
    barrierDismissible: false,
    cancel: InkWell(
      child: Container(
        width: 100.w,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(child: Text('OK')),
        ),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(5.r),
        ),
      ),
      onTap: () {
        Get.back();
      },
    ),
  );
}

void showRequestAppDialog(BuildContext context, {required IconData icon, required String description, required void Function() yes, required void Function() no}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                decoration: BoxDecoration(color: Colors.amberAccent[100], borderRadius: const BorderRadius.all(Radius.circular(5))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(icon),
                )),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 0.0),
                child: Text(description),
              ),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: yes,
            child: Text("yes"),
          ),
          ElevatedButton(
            onPressed: no,
            child: Text("no"),
          ),
        ],
      );
    },
  );
}
