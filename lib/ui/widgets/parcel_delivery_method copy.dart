// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class ParcelDeliveryMethod extends StatelessWidget {
//   final String deliveryMethod, duration, image;
//   final TextEditingController nameController,
//       emailController,
//       phoneNumberController,
//       addressController,
//       timeController,
//       dateController;
//   final bool initiallyExpanded;
//   final Function(bool) onExpansionChanged;

//   ParcelDeliveryMethod(
//       {Key? key,
//       required this.image,
//       required this.duration,
//       required this.deliveryMethod,
//       required this.initiallyExpanded,
//       required this.onExpansionChanged,
//       required this.nameController,
//       required this.emailController,
//       required this.phoneNumberController,
//       required this.addressController,
//       required this.timeController,
//       required this.dateController})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       clipBehavior: Clip.antiAlias,
//       margin: const EdgeInsets.only(
//         bottom: 16,
//       ),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(4),
//         color: Theme.of(context).colorScheme.background,
//         boxShadow: [
//           BoxShadow(
//             color: Theme.of(context).shadowColor,
//             spreadRadius: 0,
//             blurRadius: 10,
//             offset: const Offset(0, 0),
//           )
//         ],
//       ),
//       child: ExpansionTile(
//         initiallyExpanded: initiallyExpanded,
//         onExpansionChanged: onExpansionChanged,
//         tilePadding: EdgeInsets.zero,
//         trailing: const SizedBox.shrink(),
//         title: Hero(
//           tag: image,
//           transitionOnUserGestures: true,
//           child: Container(
//             height: 102,
//             color: Theme.of(context).colorScheme.background,
//             padding: const EdgeInsets.all(16),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Container(
//                   height: 70,
//                   width: 70,
//                   decoration: BoxDecoration(
//                     image: DecorationImage(
//                       image: AssetImage(image),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 24),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       deliveryMethod,
//                       style: Theme.of(context).textTheme.headlineMedium,
//                     ),
//                     Text(
//                       duration,
//                       style: Theme.of(context).textTheme.headlineSmall,
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ),
//         expandedCrossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             height: 1,
//             color: Colors.grey.shade300,
//           ),
//           _buildExpansionChildren(context),
//         ],
//       ),
//     );
//   }

//   Widget _buildExpansionChildren(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16).copyWith(
//         top: 0,
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const SizedBox(height: 16),
//           Text(
//             'Recipient Info',
//             style: Theme.of(context).textTheme.headlineSmall,
//           ),
//           const SizedBox(height: 16),
//           Row(
//             children: [
//               const SizedBox(width: 10),
//               Text(
//                 'Name',
//                 style: Theme.of(context).textTheme.titleLarge,
//               ),
//             ],
//           ),
//           TextField(
//             onChanged: (value) {
//               nameController.text = value;
//             },
//             style: TextStyle(color: Colors.black),
//           ),
//           const SizedBox(height: 16),
//           Row(
//             children: [
//               const SizedBox(width: 10),
//               Text(
//                 'Email',
//                 style: Theme.of(context).textTheme.titleLarge,
//               ),
//             ],
//           ),
//           TextField(
//             onChanged: (value) {
//               emailController.text = value;
//             },
//             style: TextStyle(color: Colors.black),
//           ),
//           const SizedBox(height: 16),
//           Row(
//             children: [
//               const SizedBox(width: 10),
//               Text(
//                 'Phone number',
//                 style: Theme.of(context).textTheme.titleLarge,
//               ),
//             ],
//           ),
//           TextField(
//             onChanged: (value) {
//               phoneNumberController.text = value;
//             },
//             style: TextStyle(color: Colors.black),
//           ),
//           const SizedBox(height: 16),
//           // Row(
//           //   children: [
//           //     const SizedBox(width: 10),
//           //     Text(
//           //       'Date',
//           //       style: Theme.of(context).textTheme.titleLarge,
//           //     ),
//           //   ],
//           // ),
//           // GestureDetector(
//           //   onTap: () async {
//           //     DateTime? selectedDate = await showDatePicker(
//           //       context: context,
//           //       initialDate: DateTime.now(),
//           //       firstDate: DateTime.now(),
//           //       lastDate: DateTime.now().add(Duration(days: 365)),
//           //     );

//           //     if (selectedDate != null) {
//           //       dateController.text =
//           //           selectedDate.toString(); // You can format this as needed
//           //     }
//           //   },
//           //   child: AbsorbPointer(
//           //     child: TextFormField(
//           //       controller: dateController,
//           //       style: TextStyle(color: Colors.black),
//           //       decoration: InputDecoration(
//           //         suffixIcon: Icon(Icons.calendar_today),
//           //       ),
//           //     ),
//           //   ),
//           // ),
//           Row(
//             children: [
//               const SizedBox(width: 10),
//               Text(
//                 'Date',
//                 style: Theme.of(context).textTheme.titleLarge,
//               ),
//             ],
//           ),
//           GestureDetector(
//             onTap: () async {
//               DateTime? selectedDate = await showDatePicker(
//                 context: context,
//                 initialDate: DateTime.now(),
//                 firstDate: DateTime.now(),
//                 lastDate: DateTime.now().add(Duration(days: 365)),
//                 builder: (BuildContext context, Widget? child) {
//                   return Theme(
//                     data: ThemeData.light().copyWith(
//                       primaryColor: Colors.yellow, // Change the color to yellow
//                       hintColor: Colors.black, // Change the color to black
//                       colorScheme: ColorScheme.light(primary: Colors.black),
//                       buttonTheme: ButtonThemeData(
//                         textTheme: ButtonTextTheme.primary,
//                         colorScheme: ColorScheme.light(
//                             primary: Color.fromARGB(255, 1, 0,
//                                 0)), // Change the button text color to black
//                       ),
//                       // Add any other styling properties you need
//                     ),
//                     child: child!,
//                   );
//                 },
//               );

//               if (selectedDate != null) {
//                 dateController.text = DateFormat('yyyy-MM-dd')
//                     .format(selectedDate); // Format the date as needed
//               }
//             },
//             child: AbsorbPointer(
//               child: TextFormField(
//                 controller: dateController,
//                 style: TextStyle(color: Colors.black),
//                 decoration: InputDecoration(
//                   suffixIcon: Icon(Icons.calendar_today),
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(height: 16),
//           Row(
//             children: [
//               const SizedBox(width: 10),
//               Text(
//                 'Time',
//                 style: Theme.of(context).textTheme.headline6?.copyWith(
//                       color: Colors.black, // Set text color to yellow
//                     ),
//               ),
//             ],
//           ),
//           GestureDetector(
//             onTap: () async {
//               TimeOfDay? selectedTime = await showTimePicker(
//                 context: context,
//                 initialTime: TimeOfDay.now(),
//                 builder: (BuildContext context, Widget? child) {
//                   return Theme(
//                     data: ThemeData.light().copyWith(
//                       primaryColor: Colors.black, // Change the color to yellow
//                       hintColor:
//                           Colors.black, // Change the accent color to black
//                       colorScheme: ColorScheme.light(primary: Colors.black),
//                       buttonTheme: ButtonThemeData(
//                         textTheme: ButtonTextTheme.primary,
//                         colorScheme: ColorScheme.light(
//                           primary:
//                               Colors.black, // Change the button color to black
//                           onPrimary: Colors
//                               .white, // Change the button text color to white
//                         ),
//                       ),
//                     ),
//                     child: child!,
//                   );
//                 },
//               );

//               if (selectedTime != null) {
//                 timeController.text = selectedTime.format(context);
//               }
//             },
//             child: AbsorbPointer(
//               child: TextFormField(
//                 controller: timeController,
//                 style: TextStyle(color: Colors.black),
//                 decoration: InputDecoration(
//                   suffixIcon: Icon(
//                     Icons.access_time,
//                     color: Colors.black, // Set icon color to yellow
//                   ),
//                 ),
//               ),
//             ),
//           ),

//           // Row(
//           //   children: [
//           //     const SizedBox(width: 10),
//           //     Text(
//           //       'Time',
//           //       style: Theme.of(context).textTheme.titleLarge,
//           //     ),
//           //   ],
//           // ),
//           // GestureDetector(
//           //   onTap: () async {
//           //     TimeOfDay? selectedTime = await showTimePicker(
//           //       context: context,
//           //       initialTime: TimeOfDay.now(),
//           //     );

//           //     if (selectedTime != null) {
//           //       timeController.text = selectedTime
//           //           .format(context); // You can format this as needed
//           //     }
//           //   },
//           //   child: AbsorbPointer(
//           //     child: TextFormField(
//           //       controller: timeController,
//           //       style: TextStyle(color: Colors.black),
//           //       decoration: InputDecoration(
//           //         suffixIcon: Icon(Icons.access_time),
//           //       ),
//           //     ),
//           //   ),
//           // ),
//           Row(
//             children: [
//               const SizedBox(width: 10),
//               Text(
//                 'Address',
//                 style: Theme.of(context).textTheme.titleLarge,
//               ),
//             ],
//           ),
//           TextField(
//             onChanged: (value) {
//               addressController.text = value;
//             },
//             style: TextStyle(color: Colors.black),
//           ),
//         ],
//       ),
//     );
//   }
// }
