import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sfit_getx/app/modules/serviceform/views/preview_view.dart';
import 'package:sfit_getx/app/modules/serviceform/views/stepone_view.dart';
import '../../../res/widgets/app_header.dart';
import 'serviceform_controller.dart';
import 'views/stepfour_view.dart';
import 'views/stepthree_view.dart';
import 'views/steptwo_view.dart';

class ServiceformView extends GetView<ServiceformController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: controller.scaffoldKey,
        floatingActionButton: FloatingActionButton(onPressed: () {}),
        drawer: Container(
          color: Colors.grey[350],
          width: Get.width * 0.5,
          height: Get.height,
          child: PreviewView(),
        ),
        body: Column(
          children: [
            buildPreviewHeader(
                context, 'Field Service Entries', controller.openDrower),
            Expanded(
              child: ListView(
                physics: BouncingScrollPhysics(),
                controller: controller.sfviewMainlist,
                children: [
                  SteponeView(),
                  SteptwoView(),
                  StepthreeView(),
                  StepfourView(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // // company dp
  // Future<void> dpCompanyWidget() async {
  //   int listlength = controller.fcompanylist.length;

  //   if (listlength > 0) {
  //     Get.bottomSheet(
  //         Obx(
  //           () => Column(
  //             children: [
  //               TextField(
  //                 // controller: _controller,
  //                 decoration: appdpfiledDecoration(),
  //                 onChanged: (val) {
  //                   print(val);
  //                   controller.filterCompany(val.toString());
  //                 },
  //               ),
  //               SizedBox(height: 5),
  //               Expanded(
  //                 child: ListView.builder(
  //                   shrinkWrap: true,
  //                   physics: const BouncingScrollPhysics(),
  //                   itemCount: controller.fcompanylist.length,
  //                   itemBuilder: (BuildContext context, int index) {
  //                     return ListTile(
  //                       onTap: () {
  //                         controller.selectedcompany.value = controller.fcompanylist[index].dropValue;

  //                         controller.idofselectedcompany.value = controller.fcompanylist[index].dropId.toString();

  //                         log(controller.fcompanylist[index].dropValue);
  //                         Get.back();

  //                         controller.fetchSite(controller.idofselectedcompany.value.toString());
  //                       },
  //                       leading: const Icon(Icons.add),
  //                       title: Text(controller.fcompanylist[index].dropValue),
  //                     );
  //                   },
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35), side: BorderSide(width: 5, color: Colors.black)),
  //         backgroundColor: Colors.amber,
  //         isDismissible: false);
  //   } else {
  //     log('me time ake error akk nisa dp load wenne  na');
  //   }
  // }

  // // site dp
  // Future<void> dpSiteWidget() async {
  //   int listlength = controller.fsitelist.length;

  //   if (listlength > 0) {
  //     Get.bottomSheet(
  //         Obx(
  //           () => Column(
  //             children: [
  //               TextField(
  //                 // controller: _controller,
  //                 decoration: appdpfiledDecoration(),
  //                 onChanged: (val) {
  //                   print(val);
  //                   // controller.fetchSite(val.toString());
  //                 },
  //               ),
  //               SizedBox(height: 5),
  //               Expanded(
  //                 child: ListView.builder(
  //                   shrinkWrap: true,
  //                   physics: const BouncingScrollPhysics(),
  //                   itemCount: controller.fsitelist.length,
  //                   itemBuilder: (BuildContext context, int index) {
  //                     return ListTile(
  //                       onTap: () {
  //                         controller.selectedsite.value = controller.fsitelist[index].dropValue;

  //                         controller.idofselectedsite.value = controller.fsitelist[index].dropId.toString();

  //                         log(controller.fsitelist[index].dropId);
  //                         Get.back();

  //                         controller.fetchContarct(controller.idofselectedsite.toString());
  //                       },
  //                       leading: const Icon(Icons.add),
  //                       title: Text(controller.fsitelist[index].dropValue),
  //                     );
  //                   },
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35), side: BorderSide(width: 5, color: Colors.black)),
  //         backgroundColor: Colors.amber,
  //         isDismissible: false);
  //   } else {
  //     log('me time ake error akk nisa dp load wenne  na');
  //   }
  // }

  // // contract dp
  // Future<void> dpContractWidget() async {
  //   int listlength = controller.fcontarctlist.length;

  //   if (listlength > 0) {
  //     Get.bottomSheet(
  //         Obx(
  //           () => Column(
  //             children: [
  //               TextField(
  //                 // controller: _controller,
  //                 decoration: appdpfiledDecoration(),
  //                 onChanged: (val) {
  //                   print(val);
  //                   // controller.filterContract(val.toString());
  //                 },
  //               ),
  //               SizedBox(height: 5),
  //               Expanded(
  //                 child: ListView.builder(
  //                   shrinkWrap: true,
  //                   physics: const BouncingScrollPhysics(),
  //                   itemCount: controller.fcontarctlist.length,
  //                   itemBuilder: (BuildContext context, int index) {
  //                     return ListTile(
  //                       onTap: () {
  //                         controller.selectedcontract.value = controller.fcontarctlist[index].dropValue;

  //                         controller.idofselectedcontarct.value = controller.fcontarctlist[index].dropId.toString();

  //                         log(controller.fcontarctlist[index].dropId);
  //                         Get.back();
  //                       },
  //                       leading: const Icon(Icons.add),
  //                       title: Text(controller.fcontarctlist[index].dropValue),
  //                     );
  //                   },
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35), side: BorderSide(width: 5, color: Colors.black)),
  //         backgroundColor: Colors.amber,
  //         isDismissible: false);
  //   } else {
  //     log('me time ake error akk nisa dp load wenne  na');
  //   }
  // }
}
