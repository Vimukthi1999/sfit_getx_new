import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:sfit_getx/app/modules/serviceform/views/stepone_view.dart';
import 'package:sfit_getx/res/widgets/app_button.dart';

import '../../../res/widgets/app_header.dart';
import 'serviceform_controller.dart';

class ServiceformView extends GetView<ServiceformController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // floatingActionButton: FloatingActionButton(onPressed: () {
        //   dpCompanyWidget();
        // }),
        body: Column(
          children: [
            buildPreviewHeader(context, 'Field Service Entries',controller),
            Expanded(
              child: Container(
                  child: Obx(
                () => Stepper(
                  steps: getSteps(),
                  type: StepperType.vertical,
                  currentStep: controller.currentStep.value,

                  onStepContinue: () async {
                    final isLastStep = controller.currentStep.value == getSteps().length - 1;

                    if (isLastStep) {
                    } else if (controller.currentStep.value == 2) {
                      controller.currentStep.value += 1;
                    } else if (controller.currentStep.value == 1) {
                      controller.currentStep.value += 1;
                    } else if (controller.currentStep.value == 0) {
                      controller.currentStep.value += 1;
                    } else {
                      controller.currentStep.value += 1;
                    }
                  },

                  onStepCancel: controller.currentStep.value == 0 ? null : () => controller.currentStep.value -= 1,

                  // onStepTapped: (step) {
                  //   controller.currentStep.value = step;
                  // },
                  controlsBuilder: (BuildContext context, ControlsDetails details) {
                    final isLastStep = controller.currentStep.value == getSteps().length - 1;

                    return Column(
                      children: <Widget>[
                        SizedBox(
                          height: 20.h,
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              if (controller.currentStep.value != 0)

                                /// previous button
                                SizedBox(width: 150.w, child: appButton(details.onStepCancel!, 'PREVIOUS', Theme.of(context).primaryColor)),

                              /// empty space needed
                              SizedBox(),

                              /// next button
                              SizedBox(width: 150.w, child: appButton( details.onStepContinue!, isLastStep ? 'CONFIRM' : 'NEXT', Theme.of(context).primaryColor)),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              )),
            )
          ],
        ),
      ),
    );
  }

  List<Step> getSteps() => [
        //<------------------- step 01 -------------------------
        Step(state: controller.currentStep.value > 0 ? StepState.complete : StepState.indexed, isActive: controller.currentStep.value >= 0, title: const Text('Step 1'), content: SingleChildScrollView(child: Container(
          height: Get.height,
          child: SteponeView()))),
        //<------------------- close of step 01 -------------------------

        //<------------------- step 02 -------------------------
        Step(
            state: controller.currentStep.value > 1 ? StepState.complete : StepState.indexed,
            isActive: controller.currentStep.value >= 1,
            title: const Text('Step 2'),
            content: Container(
              child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Container(
                    height: 100,
                    width: double.infinity,
                    color: Colors.red,
                  )),
            )),
        //<------------------- close of step 02 -------------------------

        //<------------------- step 03 -------------------------
        Step(
            state: controller.currentStep.value > 2 ? StepState.complete : StepState.indexed,
            isActive: controller.currentStep.value >= 2,
            title: const Text('Step 3'),
            content: Container(
              child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Container(
                    height: 100,
                    width: double.infinity,
                    color: Colors.green,
                  )),
            )),
        //<------------------- close of step 03 -------------------------

        //<------------------- step 04 -------------------------
        Step(
            isActive: controller.currentStep.value >= 3,
            title: const Text('Step 4'),
            content: Container(
              child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    color: Colors.pink,
                  )),
            )),
        //<------------------- close of step 04 -------------------------
      ];
}
