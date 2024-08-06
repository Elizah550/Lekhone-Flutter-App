// // parcel_screen.dart

// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:Warehouse/utils/image_utils.dart';
// import 'package:Warehouse/ui/widgets/widgets.dart';

// class MyParcelScreen extends StatefulWidget {
//   const MyParcelScreen({Key? key}) : super(key: key);

//   @override
//   _MyParcelScreenState createState() => _MyParcelScreenState();
// }

// class _MyParcelScreenState extends State<MyParcelScreen> {
//   int tripIdLength = 0;
//   List<Map<String, String>> parcelDetailsList = [];
//   String userInput = "";

//   @override
//   void initState() {
//     super.initState();
//     fetchData1();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return CustomScrollView(
//       slivers: [
//         SliverAppBar(
//             // ... Existing code ...
//             ),
//         // ... Existing code ...

//         SizedBox(
//           height: 48,
//           width: double.infinity,
//           child: TextButton(
//             style: Theme.of(context).textButtonTheme.style,
//             onPressed: () {
//               trackParcel();
//             },
//             child: Text(
//               'Track Parcel',
//               style: Theme.of(context).textTheme.bodyLarge,
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Future<void> fetchData1() async {
//     final url =
//         'https://qx5v7wh8me.execute-api.ap-south-1.amazonaws.com/Trip_details';

//     try {
//       final response = await http.post(
//         Uri.parse(url),
//         headers: {
//           'Content-Type': 'application/json',
//         },
//       );

//       if (response.statusCode == 200) {
//         final List<dynamic> data = json.decode(response.body);
//         List<String> tripIds =
//             data.map((item) => item['Trip_id'].toString()).toList();

//         setState(() {
//           tripIdLength = tripIds.length;
//           parcelDetailsList = List<Map<String, String>>.from(data.map((item) {
//             Map<String, String> convertedItem = {};
//             item.forEach((key, value) {
//               convertedItem[key] = value.toString();
//             });
//             return convertedItem;
//           }));
//         });
//         print("Here-is-the-parcel-length-----------");
//         print(tripIdLength);
//       } else {
//         print('Failed to load parcel details: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error fetching data: $e');
//     }
//   }

//   Future<void> trackParcel() async {
//     List<Map<String, String>> filteredList = parcelDetailsList
//         .where((parcel) =>
//             parcel['Trip_id']!.toLowerCase().contains(userInput.toLowerCase()))
//         .toList();

//     filteredList.sort(
//       (a, b) =>
//           a['Trip_id']!.toLowerCase().compareTo(b['Trip_id']!.toLowerCase()),
//     );

//     setState(() {
//       tripIdLength = filteredList.length;
//       parcelDetailsList = List<Map<String, String>>.from(filteredList);
//     });
//   }
// }
