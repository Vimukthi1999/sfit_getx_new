// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Pagination Table Example',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   final List<Map<String, dynamic>> data = List.generate(
//     101, // Total number of rows
//     (index) => {
//       'id': index + 1,
//       'name': 'Item ${index + 1}',
//       'description': 'Description ${index + 1}',
//     },
//   );

//   int currentPage = 1;
//   int itemsPerPage = 10;
//   String filterText = '';

//   List<Map<String, dynamic>> get filteredData {
//     return data.where((item) => item['name'].toLowerCase().contains(filterText.toLowerCase())).toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final paginatedData = filteredData.skip((currentPage - 1) * itemsPerPage).take(itemsPerPage).toList();

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Pagination Table Example'),
//       ),
//       body: Column(
//         children: [
//           TextField(
//             onChanged: (value) {
//               setState(() {
//                 filterText = value;
//                 currentPage = 1; // Reset to the first page when filtering
//               });
//             },
//             decoration: InputDecoration(
//               labelText: 'Filter by Name',
//               prefixIcon: Icon(Icons.search),
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: paginatedData.length,
//               itemBuilder: (context, index) {
//                 final item = paginatedData[index];
//                 // return ListTile(
//                 //   title: Text(item['name']),
//                 //   subtitle: Row(
//                 //     children: [
//                 //       Text(item['description']),
//                 //       Text(item['description']),
//                 //       Text(item['description']),
//                 //       Text(item['description']),
//                 //       Text(item['description']),
//                 //       IconButton(
//                 //         icon: Icon(Icons.edit),
//                 //         onPressed: () {
                          // _editItem(item);
//                 //         },
//                 //       ),
//                 //       IconButton(
//                 //         icon: Icon(Icons.delete),
//                 //         onPressed: () {
//                 //           _deleteItem(item);
//                 //         },
//                 //       ),
//                 //     ],
//                 //   ),
//                 //   // trailing: Row(
//                 //   //   mainAxisSize: MainAxisSize.min,
//                 //   //   children: [
//                 //   //     IconButton(
//                 //   //       icon: Icon(Icons.edit),
//                 //   //       onPressed: () {
//                 //   //         _editItem(item);
//                 //   //       },
//                 //   //     ),
//                 //   //     IconButton(
//                 //   //       icon: Icon(Icons.delete),
//                 //   //       onPressed: () {
//                 //   //         _deleteItem(item);
//                 //   //       },
//                 //   //     ),
//                 //   //   ],
//                 //   // ),
//                 // );

//                 return SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: Row(
//                     children: [
//                       SizedBox(width: 16.0), // Add spacing if needed
//                       Text(item['name']),
//                       SizedBox(width: 16.0), // Add spacing if needed
//                       Text(item['description']),
//                       SizedBox(width: 16.0),
//                       SizedBox(width: 16.0), // Add spacing if needed
//                       Text(item['name']),
//                       SizedBox(width: 16.0), // Add spacing if needed
//                       Text(item['description']),
//                       SizedBox(width: 16.0), // Add spacing if needed
//                       IconButton(
//                         icon: Icon(Icons.edit),
//                         onPressed: () {
//                           _editItem(item);
//                         },
//                       ),
//                       IconButton(
//                         icon: Icon(Icons.delete),
//                         onPressed: () {
//                           _deleteItem(item);
//                         },
//                       ),
//                       SizedBox(width: 16.0), // Add spacing if needed
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               ElevatedButton(
//                 onPressed: currentPage > 1
//                     ? () {
//                         setState(() {
//                           currentPage--;
//                         });
//                       }
//                     : null,
//                 child: Text('Previous Page'),
//               ),
//               SizedBox(width: 16.0),
//               Text('Page $currentPage'),
//               SizedBox(width: 16.0),
//               ElevatedButton(
//                 onPressed: currentPage < (filteredData.length / itemsPerPage).ceil()
//                     ? () {
//                         setState(() {
//                           currentPage++;
//                         });
//                       }
//                     : null,
//                 child: Text('Next Page'),
//               ),
//             ],
//           ),
        
        
//         ],
//       ),
//     );
//   }

//   void _editItem(Map<String, dynamic> item) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         String newName = item['name'];
//         String newDescription = item['description'];

//         return AlertDialog(
//           title: Text('Edit Item'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextField(
//                 decoration: InputDecoration(labelText: 'Name'),
//                 onChanged: (value) {
//                   newName = value;
//                 },
//                 controller: TextEditingController(text: item['name']),
//               ),
//               TextField(
//                 decoration: InputDecoration(labelText: 'Description'),
//                 onChanged: (value) {
//                   newDescription = value;
//                 },
//                 controller: TextEditingController(text: item['description']),
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () {
//                 // Update the item in your data source
//                 setState(() {
//                   item['name'] = newName;
//                   item['description'] = newDescription;
//                 });
//                 Navigator.of(context).pop();
//               },
//               child: Text('Save'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _deleteItem(Map<String, dynamic> item) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Delete Item'),
//           content: Text('Are you sure you want to delete ${item['name']}?'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () {
//                 // Remove the item from your data source
//                 setState(() {
//                   data.remove(item);
//                 });
//                 Navigator.of(context).pop();
//               },
//               child: Text('Delete'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }




// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       title: 'Pagination Table Example',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(),
//     );
//   }
// }

// class ItemController extends GetxController {
//   final RxList<Map<String, dynamic>> data = List.generate(
//     101, // Total number of rows
//     (index) => {
//       'id': index + 1,
//       'name': 'Item ${index + 1}',
//       'description': 'Description ${index + 1}',
//     },
//   ).obs;

//   final RxInt currentPage = 1.obs;
//   final RxInt itemsPerPage = 10.obs;
//   final RxString filterText = ''.obs;

//   List<Map<String, dynamic>> get filteredData {
//     return data
//         .where(
//           (item) => item['name'].toLowerCase().contains(filterText.value.toLowerCase()),
//         )
//         .toList();
//   }

//   void editItem(Map<String, dynamic> item) {
//     String newName = item['name'];
//     String newDescription = item['description'];

//     Get.defaultDialog(
//       title: 'Edit Item',
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           TextField(
//             decoration: InputDecoration(labelText: 'Name'),
//             onChanged: (value) {
//               newName = value;
//             },
//             controller: TextEditingController(text: item['name']),
//           ),
//           TextField(
//             decoration: InputDecoration(labelText: 'Description'),
//             onChanged: (value) {
//               newDescription = value;
//             },
//             controller: TextEditingController(text: item['description']),
//           ),
//         ],
//       ),
//       confirm: ElevatedButton(
//         onPressed: () {
//           // Update the item in your data source
//           item['name'] = newName;
//           item['description'] = newDescription;
//           Get.back();
//         },
//         child: Text('Save'),
//       ),
//       cancel: TextButton(
//         onPressed: () {
//           Get.back();
//         },
//         child: Text('Cancel'),
//       ),
//     );
//   }

//   void deleteItem(Map<String, dynamic> item) {
//     Get.defaultDialog(
//       title: 'Delete Item',
//       content: Text('Are you sure you want to delete ${item['name']}?'),
//       confirm: ElevatedButton(
//         onPressed: () {
//           // Remove the item from your data source
//           data.remove(item);
//           Get.back();
//         },
//         child: Text('Delete'),
//       ),
//       cancel: TextButton(
//         onPressed: () {
//           Get.back();
//         },
//         child: Text('Cancel'),
//       ),
//     );
//   }
// }

// class MyHomePage extends StatelessWidget {
//   final ItemController controller = Get.put(ItemController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Pagination Table Example'),
//       ),
//       body: Column(
//         children: [
          
          
//           TextField(
//             onChanged: (value) {
//               controller.filterText.value = value;
//               controller.currentPage.value = 1; // Reset to the first page when filtering
//             },
//             decoration: InputDecoration(
//               labelText: 'Filter by Name',
//               prefixIcon: Icon(Icons.search),
//             ),
//           ),
//           Expanded(
//             child: Obx(
//               () {
//                 final paginatedData = controller
//                     .filteredData
//                     .skip((controller.currentPage.value - 1) * controller.itemsPerPage.value)
//                     .take(controller.itemsPerPage.value)
//                     .toList();

//                 return ListView.builder(
//                   itemCount: paginatedData.length,
//                   itemBuilder: (context, index) {
//                     final item = paginatedData[index];
//                     return SingleChildScrollView(
//                       scrollDirection: Axis.horizontal,
//                       child: Row(
//                         children: [
//                           SizedBox(width: 16.0), // Add spacing if needed
//                           Text(item['name']),
//                           SizedBox(width: 16.0), // Add spacing if needed
//                           Text(item['description']),
//                           SizedBox(width: 16.0), // Add spacing if needed
//                           IconButton(
//                             icon: Icon(Icons.edit),
//                             onPressed: () {
//                               controller.editItem(item);
//                             },
//                           ),
//                           IconButton(
//                             icon: Icon(Icons.delete),
//                             onPressed: () {
//                               controller.deleteItem(item);
//                             },
//                           ),
//                           SizedBox(width: 16.0), // Add spacing if needed
//                         ],
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               ElevatedButton(
//                 onPressed: controller.currentPage.value > 1
//                     ? () {
//                         controller.currentPage.value--;
//                       }
//                     : null,
//                 child: Text('Previous Page'),
//               ),
//               SizedBox(width: 16.0),
//               Text('Page ${controller.currentPage.value}'),
//               SizedBox(width: 16.0),
//               ElevatedButton(
//                 onPressed: controller.currentPage.value < (controller.filteredData.length /
//                         controller.itemsPerPage.value)
//                     .ceil()
//                     ? () {
//                         controller.currentPage.value++;
//                       }
//                     : null,
//                 child: Text('Next Page'),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

