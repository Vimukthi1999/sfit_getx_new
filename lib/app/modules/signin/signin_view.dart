import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:sfit_getx/res/app_url.dart';
import '../../../res/theme/app_colors.dart';
import '../../../res/widgets/app_button.dart';
import '../../../res/widgets/app_custom_text_styles.dart';
import '../../../res/widgets/app_txtfiled_decoration.dart';
import 'signin_controller.dart';

class SigninView extends GetView<SigninController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          // floatingActionButton: FloatingActionButton(onPressed: () {
          //   showAppDialog('cus title', 'cus dis');
          // }),
          body: Row(
        children: [
          Container(
            color: AppColor.mainBlueColor,
            // height: double.infinity,
            width: 364.w,
            child: Padding(
              padding: EdgeInsets.all(8.w),
              child: Center(
                child: Image.network(AppUrl.LOGO_URL),
                // child: Container(
                //   width: 100,
                //   height: 100,
                //   color: Colors.amber,
                // ),
              ),
            ),
          ),
          Container(
            // color: Colors.white,
            // height: double.infinity,
            width: 444.w,
            child: Padding(
              padding: EdgeInsets.all(20.w),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'System Force I.T',
                      style: TextStyle(
                          fontSize: 38.sp, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      'Welcome back !',
                      style: TextStyle(
                        fontSize: 25.sp,
                        fontWeight: FontWeight.normal,
                        color: AppColor.textColor,
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Text(
                      'Please sign in to continue',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),

                    /// user name text field
                    appfTxt('Username'),
                    SizedBox(
                      height: 50.h,
                      child: TextFormField(
                        controller: controller.controllerUser,
                        style: TextStyle(fontSize: 18.sp, color: Colors.black),
                        decoration:
                            appTxtfiledDecoration('Enter your username'),
                        textInputAction: TextInputAction.next,
                      ),
                    ),

                    /// password text field
                    appfTxt('Password'),
                    Obx(
                      () => SizedBox(
                        height: 50.h,
                        child: TextFormField(
                          controller: controller.controllerPw,
                          obscureText: controller.passwordVisible.value,
                          style:
                              TextStyle(fontSize: 18.sp, color: Colors.black),
                          scrollPadding: EdgeInsets.only(bottom: 40),
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            focusedBorder: const OutlineInputBorder(),
                            hintText: 'Enter your password',
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 18.sp),
                            suffixIcon: IconButton(
                              icon: Icon(
                                // Based on passwordVisible state choose the icon

                                controller.passwordVisible.value
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Theme.of(context).primaryColorDark,
                                size: 30.w,
                              ),
                              onPressed: () {
                                controller.passwordVisible.value =
                                    !controller.passwordVisible.value;
                              },
                              padding: EdgeInsets.only(right: 18.w),
                            ),
                          ),
                          textInputAction: TextInputAction.done,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),

                    // sign in button
                    Obx(() => appLoadingButton(
                        Theme.of(context).primaryColor,
                        controller.signIn,
                        'Sign In',
                        controller.loading.value)),
                  ],
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
