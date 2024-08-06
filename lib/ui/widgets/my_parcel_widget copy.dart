// import 'dart:convert';
// import 'package:Warehouse/utils/image_utils.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter_svg/svg.dart';

// int tripIdLength = 0;

// class MyParcelWidget extends StatefulWidget {
//   const MyParcelWidget({Key? key, required int index}) : super(key: key);

//   @override
//   _MyParcelWidgetState createState() => _MyParcelWidgetState();
// }

// class _MyParcelWidgetState extends State<MyParcelWidget> {
//   late List<Map<String, String>> parcelDetailsList;

//   @override
//   void initState() {
//     super.initState();
//     parcelDetailsList = []; // Initialize as an empty list
//     fetchData();
//   }

//   @override
//   void dispose() {
//     // Dispose of resources, cancel timers, etc.
//     super.dispose();
//   }

//   Future<void> fetchData() async {
//     final url =
//         'https://qx5v7wh8me.execute-api.ap-south-1.amazonaws.com/Trip_details';

//     try {
//       final response = await http.post(
//         Uri.parse(url),
//         headers: {
//           'Content-Type': 'application/json',
//         },
//       );
//       print("Here is the details");
//       print(
//           'Trip_id length: ${List<String>.from(json.decode(response.body).map((item) => item['Trip_id'].toString())).length}');
//       // final List<dynamic> data = json.decode(response.body);

//       if (response.statusCode == 200) {
//         final List<dynamic> data = json.decode(response.body);
//         List<String> tripIds =
//             data.map((item) => item['Trip_id'].toString()).toList();

//         tripIdLength = tripIds.length;
//         print(tripIdLength);
//         // Assuming the API response contains a list of parcels
//         if (mounted) {
//           setState(() {
//             parcelDetailsList = List<Map<String, String>>.from(data.map((item) {
//               // Convert each item to a Map<String, String>
//               Map<String, String> convertedItem = {};
//               item.forEach((key, value) {
//                 // Convert values to strings, or handle differently if needed
//                 convertedItem[key] = value.toString();
//               });
//               return convertedItem;
//             }));
//           });
//         }
//       } else {
//         print('Failed to load parcel details: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error fetching data: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         for (var parcelDetails in parcelDetailsList)
//           _buildParcelCard(context, parcelDetails),
//       ],
//     );
//   }

//   Widget _buildParcelCard(
//       BuildContext context, Map<String, String> parcelDetails) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(
//         horizontal: 24,
//         vertical: 16,
//       ),
//       child: Container(
//         clipBehavior: Clip.antiAlias,
//         height: 174,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(4),
//           color: Theme.of(context).colorScheme.background,
//           boxShadow: [
//             BoxShadow(
//               color: Theme.of(context).shadowColor,
//               blurRadius: 10,
//               spreadRadius: 0,
//               offset: const Offset(0, 0),
//             )
//           ],
//         ),
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   parcelDetails['Trip_id'] ?? 'Loading...',
//                   style: Theme.of(context).textTheme.headlineSmall,
//                 ),
//                 Container(
//                   height: 31,
//                   width: 78,
//                   decoration: const BoxDecoration(
//                     image: DecorationImage(
//                       image: NetworkImage(
//                           ImageUtils.icAmazon), // Update with your image URL
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'In transit',
//                   style: Theme.of(context).textTheme.displaySmall,
//                 ),
//                 const SizedBox(height: 3),
//                 Text(
//                   'Last update: 3 hours ago',
//                   style: Theme.of(context).textTheme.titleLarge,
//                 ),
//                 const SizedBox(height: 12),
//                 Container(
//                   height: 5,
//                   clipBehavior: Clip.antiAlias,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(2.5),
//                   ),
//                   child: LinearProgressIndicator(
//                     value: 0.7,
//                     color: Theme.of(context).appBarTheme.backgroundColor,
//                     backgroundColor: const Color(0xFFF8F8F8),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(
//               width: 60,
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         'Details',
//                         style: Theme.of(context).textTheme.headlineMedium,
//                       ),
//                       SvgPicture.asset(ImageUtils
//                           .icDetailsSVG), // Update with your SVG asset path
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



// // ====>>>>
// // import 'package:flutter/material.dart';
// // import 'package:Warehouse/utils/utils.dart';
// // import 'package:flutter_svg/svg.dart';

// // class MyParcelWidget extends StatelessWidget {
// //   const MyParcelWidget({Key? key, required int index}) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     return Padding(
// //       padding: const EdgeInsets.symmetric(
// //         horizontal: 24,
// //         vertical: 16,
// //       ),
// //       child: Container(
// //         clipBehavior: Clip.antiAlias,
// //         height: 174,
// //         decoration: BoxDecoration(
// //           borderRadius: BorderRadius.circular(4),
// //           color: Theme.of(context).colorScheme.background,
// //           boxShadow: [
// //             BoxShadow(
// //               color: Theme.of(context).shadowColor,
// //               blurRadius: 10,
// //               spreadRadius: 0,
// //               offset: const Offset(0, 0),
// //             )
// //           ],
// //         ),
// //         padding: const EdgeInsets.all(16),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //           children: [
// //             Row(
// //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //               children: [
// //                 Text(
// //                   '00359007738060313786',
// //                   style: Theme.of(context).textTheme.headlineSmall,
// //                 ),
// //                 Container(
// //                   height: 31,
// //                   width: 78,
// //                   decoration: const BoxDecoration(
// //                     image: DecorationImage(
// //                       image: NetworkImage(ImageUtils.icAmazon),
// //                     ),
// //                   ),
// //                 )
// //               ],
// //             ),
// //             Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Text(
// //                   'In transit',
// //                   style: Theme.of(context).textTheme.displaySmall,
// //                 ),
// //                 const SizedBox(height: 3),
// //                 Text(
// //                   'Last update: 3 hours ago',
// //                   style: Theme.of(context).textTheme.titleLarge,
// //                 ),
// //                 const SizedBox(height: 12),
// //                 Container(
// //                   height: 5,
// //                   clipBehavior: Clip.antiAlias,
// //                   decoration: BoxDecoration(
// //                     borderRadius: BorderRadius.circular(2.5),
// //                   ),
// //                   child: LinearProgressIndicator(
// //                     value: 0.7,
// //                     color: Theme.of(context).appBarTheme.backgroundColor,
// //                     backgroundColor: const Color(0xFFF8F8F8),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //             SizedBox(
// //               width: 60,
// //               child: Column(
// //                 children: [
// //                   Row(
// //                     mainAxisAlignment: MainAxisAlignment.center,
// //                     children: [
// //                       Text(
// //                         'Details',
// //                         style: Theme.of(context).textTheme.headlineMedium,
// //                       ),
// //                       SvgPicture.asset(ImageUtils.icDetailsSVG),
// //                     ],
// //                   ),
// //                   // Container(
// //                   //   height: 1,
// //                   //   color: Colors.black,
// //                   // )
// //                 ],
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
