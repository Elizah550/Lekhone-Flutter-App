// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_maps_webservice/places.dart';

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
//       required this.dateController,
//       required String? Function(String? value) validateName,
//       required String? Function(String? value) validateEmail,
//       required String? Function(String? value) validatePhoneNumber})
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
//           TextFormField(
//             controller: nameController,
//             style: TextStyle(color: Colors.black),
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Name is required';
//               }
//               return null;
//             },
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
//           TextFormField(
//             controller: emailController,
//             style: TextStyle(color: Colors.black),
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Email is required';
//               }
//               // Add additional email validation if needed
//               return null;
//             },
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
//           TextFormField(
//             controller: phoneNumberController,
//             style: TextStyle(color: Colors.black),
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Phone number is required';
//               }
//               // Add additional phone number validation if needed
//               return null;
//             },
//           ),
//           const SizedBox(height: 16),
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
//                           primary: Color.fromARGB(255, 1, 0,
//                               0), // Change the button text color to black
//                         ),
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
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Date is required';
//                   }
//                   // Add additional date validation if needed
//                   return null;
//                 },
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
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Time is required';
//                   }
//                   // Add additional time validation if needed
//                   return null;
//                 },
//               ),
//             ),
//           ),
//           Row(
//             children: [
//               const SizedBox(width: 10),
//               Text(
//                 'Address',
//                 style: Theme.of(context).textTheme.titleLarge,
//               ),
//               // Add GestureDetector for opening the bottom sheet
//               GestureDetector(
//                 onTap: () {
//                   _openAddressBottomSheet(
//                       context); // Pass the context parameter
//                 },
//                 child: Icon(Icons.edit),
//               ),
//             ],
//           ),
//           TextFormField(
//             controller: addressController,
//             style: TextStyle(color: Colors.black),
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Address is required';
//               }
//               // Add additional address validation if needed
//               return null;
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   void _openAddressBottomSheet(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       builder: (BuildContext context) {
//         return AddressBottomSheet(
//           addressController: addressController,
//         );
//       },
//     );
//   }
// }

// class AddressBottomSheet extends StatefulWidget {
//   final TextEditingController addressController;

//   const AddressBottomSheet({Key? key, required this.addressController})
//       : super(key: key);

//   @override
//   _AddressBottomSheetState createState() => _AddressBottomSheetState();
// }

// class _AddressBottomSheetState extends State<AddressBottomSheet> {
//   final places =
//       GoogleMapsPlaces(apiKey: "AIzaSyDA_n_cgyJIQ-oZKgtWeoh2sTqqfLC3pgg");
//   late TextEditingController searchController;

//   @override
//   void initState() {
//     super.initState();
//     searchController = TextEditingController();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(
//         bottom: MediaQuery.of(context).viewInsets.bottom,
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           ListTile(
//             title: Text('Home Address'),
//             onTap: () {
//               // Handle selection of home address
//               Navigator.pop(context, 'Home Address');
//             },
//           ),
//           ListTile(
//             title: Text('Work Address'),
//             onTap: () {
//               // Handle selection of work address
//               Navigator.pop(context, 'Work Address');
//             },
//           ),
//           ListTile(
//             title: Text('Add New Address'),
//             onTap: () {
//               // Handle adding a new address
//               Navigator.pop(
//                   context, null); // You can return null or an empty string
//             },
//           ),
//           // Add a text field for searching and completing the address
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: TextFormField(
//               controller: searchController,
//               decoration: InputDecoration(
//                 labelText: 'Search Address',
//                 border: OutlineInputBorder(),
//               ),
//               onChanged: (value) async {
//                 // Implement your logic here
//                 // You can use the 'value' to search for addresses and show suggestions
//               },
//             ),
//           ),
//           // Add a map to display the selected or searched address
//           Container(
//             height: 200,
//             child: GoogleMap(
//               initialCameraPosition: CameraPosition(
//                 target: LatLng(17.4392, 78.3754), // Default to San Francisco
//                 zoom: 12.0,
//               ),
//               markers: _buildMarkers(),
//               onMapCreated: (GoogleMapController controller) {},
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Set<Marker> _buildMarkers() {
//     // Implement your logic to create markers based on selected or searched address
//     return {};
//   }

//   @override
//   void dispose() {
//     places.dispose();
//     searchController.dispose();
//     super.dispose();
//   }
// }
