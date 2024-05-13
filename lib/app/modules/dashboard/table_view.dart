
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class DataTableView extends DataTableSource {
//   final navigatorKey = GlobalKey<NavigatorState>();
//   List data = [];
//   String? token;
//   // GetSignImg getSignImg = GetSignImg();
//   bool isOk = false;
//   // BuildContext? context;
//   DataTableView(this.data) {
//     print('in data table view clz ---> $data');
//     getToken();

//     printingtoken();
//   }

//   // DataTableView.getContext(BuildContext context) {
//   //   context = context;
//   // }

//   TableOption tableOption = TableOption();

//   // get token and fill drop down
//   getToken() async {
//     SharedPref sharedPref = SharedPref();
//     token = (await sharedPref.readToken())!;
//     print(token);

//     printingtoken();
//   }

//   @override
//   DataRow? getRow(int index) {
//     String reg = data[index]['requisition_no'].toString();
//     String contract_id = data[index]['contract_id'].toString();
//     //final imgbyte = getSignImg.getEnginner(data[index]['sign_engineer'].toString(), token!);

//     bool engIsOk = false;
//     String engSign = data[index]['sign_engineer'].toString();
//     if(engSign == '1') engIsOk = true ;

//     bool cusIsOk = false;
//     bool isIcon = true;
//     String cusSign = data[index]['sign_customer'].toString();
//     print('------------------------------------- $cusSign ----');
//     if (cusSign.isEmpty || cusSign.length>1){
//       isIcon = false;
//     }else{
//       if (cusSign == '1') cusIsOk = true;
//     }

//     print('in getrow method ---? $token');

//     // TODO: implement getRow
//     return DataRow(
//       cells: [
//         DataCell(Text(data[index]['requisition_no'].toString())),
//         DataCell(Container(width: 150,
//             child: Text(data[index]['company_name'].toString(),
//             overflow: TextOverflow.ellipsis,))),
//         DataCell(Text(data[index]['contract_id'].toString())),
//         DataCell(Text(data[index]['start_date'].toString())),
//         DataCell(Text(data[index]['requested_date'].toString())),
//         DataCell(Text(data[index]['engineer'].toString())),

//         // DataCell(Text(data[index]['sign_engineer'].toString())),
//         // DataCell(Text(data[index]['sign_customer'].toString())),

//         // loading sign images
//         // DataCell(Image.network(data[index]['sign_engineer'].toString())),
//         // DataCell(Image.network(data[index]['sign_customer'].toString())),

//         // ----------------------------------------------------------------------------- data[index]['sign_engineer'].toString().length
//         DataCell(
//           Center(
//             child: engIsOk ? FaIcon(FontAwesomeIcons.circleCheck, color: Colors.green,) : FaIcon(FontAwesomeIcons.circleQuestion)),
//         ),
//         // ----------------------------------------------------------------------------------

//         // ----------------------------------------------------------------------------- data[index]['sign_customer'].toString().length
//         DataCell(
//           Center(
//             child: isIcon ? cusIsOk ? FaIcon(FontAwesomeIcons.circleCheck, color: Colors.green,) : FaIcon(FontAwesomeIcons.circleQuestion) : Text(cusSign),
//           ),

//         ),

//         // ----------------------------------------------------------------------------------

//         DataCell(
//           Row(
//             children: [
//               // edit
//               Visibility(
//                 visible: data[index]['option']['edit'],
//                 // edit
//                 child: IconButton(
//                   icon: const FaIcon(FontAwesomeIcons.edit),
//                   onPressed: () async {
//                     print('edit on id - $index ----> reg no : $reg');

//                     String values = 'index - $index - reg - $reg';


//                     SharedPref sharedPref = SharedPref();
//                     await sharedPref.saveRequisitionNo(reg);

//                     // try to navigate pdf view screen
//                     // Now anywhere inside your code change widget like this without context:
//                     NavigationService.instance.navigateWithValues("/tab2");

//                   },
//                   iconSize: 20,
//                 ),
//               ),

//               // delete
//               Visibility(
//                 visible: data[index]['option']['delete'],
//                 child: IconButton(
//                   icon: const Icon(Icons.delete),
//                   onPressed: () async {
//                     String values = 'index - $index - reg - $reg';
//                     print('print on id - $index $reg');
//                     print('<<print on id>> - $index $reg $contract_id');

//                     SharedPref sharedPref = SharedPref();
//                     await sharedPref.saveRequisitionNo(reg);
//                     await sharedPref.saveWhichOption('delete');
//                     await sharedPref.saveContractId(contract_id);

//                     // try to navigate pdf view screen
//                     // Now anywhere inside your code change widget like this without context:
//                     NavigationService.instance.navigateWithValues("/viewfieldservice");

//                   },
//                   iconSize: 23,
//                   color: Colors.red,
//                 ),
//               ),

//               // search / view
//               Visibility(
//                 visible: data[index]['option']['view'],
//                 child: IconButton(
//                   icon: const Icon(Icons.remove_red_eye_rounded),
//                   onPressed: () async {
//                     String values = 'index - $index - reg - $reg';
//                     print('print on id - $index $reg');

//                     SharedPref sharedPref = SharedPref();
//                     await sharedPref.saveRequisitionNo(reg);
//                     await sharedPref.saveWhichOption('view');

//                     // try to navigate pdf view screen
//                     // Now anywhere inside your code change widget like this without context:
//                     NavigationService.instance.navigateWithValues("/viewfieldservice");

//                   },
//                   iconSize: 20,
//                   color: Colors.grey,
//                 ),
//               ),

//               // email
//               Visibility(
//                 visible: data[index]['option']['email'],
//                 child: IconButton(
//                   icon: const Icon(Icons.email),
//                   onPressed: () async {
//                     print('email on id - $index $reg $data');
//                     //sentEmail(index, reg);
//                     bool needtochange = await tableOption.sentEmail(index, reg);

//                     print('what to do --> $needtochange');

//                     if (needtochange) {
//                       // chage icon
//                       data[index]['option']['email'] = false;
//                       data[index]['option']['email_sent'] = true;
//                       notifyListeners();
//                     }
//                   },
//                   iconSize: 23,
//                   color: Colors.blue[700],
//                 ),
//               ),

//               // email forword
//               Visibility(
//                 visible: data[index]['option']['email_sent'],
//                 child: IconButton(
//                   icon: const FaIcon(FontAwesomeIcons.share),
//                   onPressed: () async {
//                     await tableOption.sentEmail(index, reg);
//                   },
//                   iconSize: 20,
//                   color: Colors.blue[700],
//                 ),
//               ),

//               // $
//               Visibility(
//                 visible: data[index]['option']['signature'],
//                 child: IconButton(
//                   icon: const FaIcon(FontAwesomeIcons.signature),
//                   onPressed: () async {
//                     String values = 'index - $index - reg - $reg';

//                     SharedPref sharedPref = SharedPref();
//                     await sharedPref.saveRequisitionNo(reg);

//                     if(!engIsOk) {
//                       NavigationService.instance.navigateWithValues("/bothsignatures");
//                     } else
//                     {
//                       NavigationService.instance.navigateWithValues("/signature");
//                     }

//                   },
//                   iconSize: 20,
//                   color: Colors.green,
//                 ),
//               ),

//               // print
//               Visibility(
//                 visible: data[index]['option']['print'],
//                 child: IconButton(
//                   icon: const FaIcon(FontAwesomeIcons.filePdf),
//                   onPressed: () async {
//                     String values = 'index - $index - reg - $reg';
//                     print('print on id - $index $reg');

//                     SharedPref sharedPref = SharedPref();
//                     await sharedPref.saveRequisitionNo(reg);

//                     // try to navigate pdf view screen
//                     // Now anywhere inside your code change widget like this without context:
//                     NavigationService.instance.navigateWithValues("/viewpdf");
//                   },
//                   iconSize: 20,
//                   color: Colors.blue[900],
//                 ),
//               ),

//               // testing
//               // delete
//               // Visibility(
//               //   visible: true,
//               //   child: IconButton(
//               //     icon: const Icon(Icons.circle),
//               //     onPressed: () async {
//               //       print('delete on id - $index $reg');
//               //
//               //       // try to delete row
//               //       // chage icon
//               //       print(data[index]);
//               //       data.removeAt(index);
//               //
//               //       notifyListeners();
//               //     },
//               //     iconSize: 20,
//               //     color: Colors.yellow[900],
//               //   ),
//               // ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   @override
//   // TODO: implement isRowCountApproximate
//   bool get isRowCountApproximate => false;

//   @override
//   // TODO: implement rowCount
//   int get rowCount => data.length;

//   @override
//   // TODO: implement selectedRowCount
//   int get selectedRowCount => 0;

//   void showMyDialog() {
//     showDialog(
//       context: navigatorKey.currentContext!,
//       builder: (context) => const Center(
//         child: Material(
//           color: Colors.amber,
//           child: Text('Hello'),
//         ),
//       ),
//     );
//   }

//   String sendEmail() {
//     return 'email';
//   }

//   void printingtoken() {
//     print('in printing token method ----> $token');
//   }

// // // table option
// // Future<void> sentEmail(int rowindex, String reg) async {
// //   final res = await http.get(
// //       Uri.parse("${Config.BACKEND_URL}/send-email-api/SVC2200006_U2200046"),
// //       headers: {
// //         'Authorization': 'Bearer $token',
// //       });

// //   if (res.statusCode == 200) {
// //     Map decodedMap = jsonDecode(res.body);
// //     bool isSuccess = decodedMap['success'];
// //     String msg = decodedMap['messages'];

// //     if (isSuccess) {
// //       String msgs = decodedMap['messages']['send_email'];
// //       Fluttertoast.showToast(
// //         msg: msgs,
// //         toastLength: Toast.LENGTH_LONG,
// //         gravity: ToastGravity.BOTTOM,
// //       );

// //       // chagning row icons
// //       print(data[0]['option']);
// //       print(data[0]['option']['view']); // 1st --: true
// //       data[0]['option']['view'] = false;
// //       print(data[0]['option']);
// //       print(data[0]['option']['view']);
// //       data[0]['option']['signature'] = true;
// //       /
// //     } else {
// //       String msgs = decodedMap['messages']['send_email'];
// //       Fluttertoast.showToast(
// //         msg: msgs,
// //         toastLength: Toast.LENGTH_LONG,
// //         gravity: ToastGravity.BOTTOM,
// //       );
// //     }
// //   } else {
// //     print('Request failed with status: ${res..statusCode}');

// //     Fluttertoast.showToast(
// //       msg: 'Request failed with status: ${res.statusCode}',
// //       toastLength: Toast.LENGTH_LONG,
// //       gravity: ToastGravity.BOTTOM,
// //     );
// //   }
// // }
// }


// // print(data[index]['option']);
// //                       print(data[index]['option']['email']); // 1st --: true
// //                       data[index]['option']['email'] = false;
// //                       print(data[index]['option']);
// //                       print(data[index]['option']['email']);
// //                       data[index]['option']['email_sent'] = true;
// //                       print(data);
