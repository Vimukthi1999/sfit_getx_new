// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../controllers/pdf_controller.dart';

class PdfView extends GetView<PdfController> {
  var argumentData = Get.arguments;
  @override
  Widget build(BuildContext context) {
    controller.fetchPdf(argumentData);
    return Scaffold(
        appBar: AppBar(
            // title: Text('PdfView'),
            // centerTitle: true,
            ),
        body: Obx(
          () => Container(
            height: Get.height,
            width: Get.width,
            child: controller.pdfbytes.value.isEmpty ? Center(child: CircularProgressIndicator()) : SfPdfViewer.memory(controller.pdfbytes.value),
          ),
        ));
  }
}
