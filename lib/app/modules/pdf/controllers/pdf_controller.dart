import 'dart:developer';
import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:sfit_getx/app/data/network/dio_client.dart';
import 'package:sfit_getx/res/app_url.dart';

class PdfController extends GetxController {
  DioClient dioClient = DioClient();

  var pdfbytes = Uint8List.fromList([]).obs;
  List<int> pdfD = [0].obs;

  // Convert Uint8List to Obx type
  var obso;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  fetchPdf(String reqNo) {
    log(reqNo);
    dioClient.getforPDF(AppUrl.fetchpdf + reqNo).then((respdf) {
      try {
        
        pdfbytes.value = respdf;
        print(pdfbytes.value.toString());
      } catch (e) {
        log(e.toString());
      }
    }).onError((error, stackTrace) {
      log(error.toString());
    });
    return null;
  }
}
