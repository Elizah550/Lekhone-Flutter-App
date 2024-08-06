// import 'package:Lekhone/screens/Login/Login.dart';
// import 'package:Lekhone/screens/global.dart';
// import 'package:Lekhone/screens/settings/edit_screen.dart';
// import 'package:Lekhone/screens/settings/widgets/forward_button.dart';
// import 'package:Lekhone/screens/settings/widgets/setting_item.dart';
// import 'package:Lekhone/screens/settings/widgets/setting_switch.dart';
// import 'package:Lekhone/ui/views/parcel_center/parcel_center_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:ionicons/ionicons.dart';

// class AccountScreen extends StatefulWidget {
//   const AccountScreen({Key? key});

//   @override
//   State<AccountScreen> createState() => _AccountScreenState();
// }

// class _AccountScreenState extends State<AccountScreen> {
//   bool isDarkMode = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => ParcelCenterScreen(),
//               ),
//             );
//             // Navigator.pop(context);
//           },
//         ),
//         title: Text(
//           'Profile screen',
//           style: Theme.of(context).textTheme.displayLarge,
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(30),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 40),
//               const Text(
//                 "Account",
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               const SizedBox(height: 20),
//               SizedBox(
//                 width: double.infinity,
//                 child: Row(
//                   children: [
//                     Image.asset("assets/images/car.png", width: 70, height: 70),
//                     const SizedBox(width: 20),
//                     Expanded(
//                       child: FutureBuilder<Map<String, dynamic>?>(
//                         future: Fetchuser(phoneNumberController.text),
//                         builder: (context, snapshot) {
//                           if (snapshot.connectionState ==
//                               ConnectionState.waiting) {
//                             return CircularProgressIndicator();
//                           } else if (snapshot.hasError ||
//                               snapshot.data == null) {
//                             return Text("Error loading user details");
//                           } else {
//                             if (mounted) {
//                               final user = snapshot.data!;
//                               final userName = user['Name'] != null &&
//                                       user['Name']['S'] != null
//                                   ? user['Name']['S']
//                                   : 'No Name';
//                               final userPhone = user['Phone'] != null
//                                   ? user['Phone'].toString()
//                                   : 'No Phone';
//                               final userZipcode = user['Zipcode'] != null
//                                   ? user['Zipcode'].toString()
//                                   : 'No Zipcode';

//                               return Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     userName,
//                                     style: TextStyle(
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.w500,
//                                     ),
//                                   ),
//                                   Text(
//                                     'Phone: $userPhone',
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                     ),
//                                   ),
//                                   Text(
//                                     'Zipcode: $userZipcode',
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                     ),
//                                   ),
//                                   // Add other user details here if needed
//                                   SizedBox(height: 10),
//                                 ],
//                               );
//                             } else {
//                               return SizedBox.shrink();
//                             }
//                           }
//                         },
//                       ),
//                     ),
//                     const Spacer(),
//                     ForwardButton(
//                       onTap: () {
//                         if (mounted) {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => const EditAccountScreen(),
//                             ),
//                           );
//                         }
//                       },
//                     )
//                   ],
//                 ),
//               ),

//               // SizedBox(
//               //   width: double.infinity,
//               //   child: Row(
//               //     children: [
//               //       Image.asset("assets/images/car.png", width: 70, height: 70),
//               //       const SizedBox(width: 20),
//               //       const Column(
//               //         crossAxisAlignment: CrossAxisAlignment.start,
//               //         children: [
//               //           Text(
//               //             "Pavan kumar",
//               //             style: TextStyle(
//               //               fontSize: 18,
//               //               fontWeight: FontWeight.w500,
//               //             ),
//               //           ),
//               //           SizedBox(height: 10),
//               //         ],
//               //       ),
//               //       const Spacer(),
//               //       ForwardButton(
//               //         onTap: () {
//               //           Navigator.push(
//               //             context,
//               //             MaterialPageRoute(
//               //               builder: (context) => const EditAccountScreen(),
//               //             ),
//               //           );
//               //         },
//               //       )
//               //     ],
//               //   ),
//               // ),
//               const SizedBox(height: 40),
//               const Text(
//                 "Settings",
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               const SizedBox(height: 20),
//               SettingItem(
//                 title: "Payments",
//                 icon: Ionicons.earth,
//                 bgColor: Colors.orange.shade100,
//                 iconColor: Colors.orange,
//                 onTap: () {},
//               ),
//               const SizedBox(height: 20),
//               SettingItem(
//                 title: "Language",
//                 icon: Ionicons.earth,
//                 bgColor: Colors.orange.shade100,
//                 iconColor: Colors.orange,
//                 value: "English",
//                 onTap: () {},
//               ),
//               const SizedBox(height: 20),
//               SettingItem(
//                 title: "Notifications",
//                 icon: Ionicons.notifications,
//                 bgColor: Colors.blue.shade100,
//                 iconColor: Colors.blue,
//                 onTap: () {},
//               ),
//               // const SizedBox(height: 20),
//               // SettingSwitch(
//               //   title: "Dark Mode",
//               //   icon: Ionicons.earth,
//               //   bgColor: Colors.purple.shade100,
//               //   iconColor: Colors.purple,
//               //   value: isDarkMode,
//               //   onTap: (value) {
//               //     setState(() {
//               //       isDarkMode = value;
//               //     });
//               //   },
//               // ),
//               const SizedBox(height: 20),
//               SettingItem(
//                 title: "Help",
//                 icon: Ionicons.nuclear,
//                 bgColor: Colors.red.shade100,
//                 iconColor: Colors.red,
//                 onTap: () {},
//               ),
//               const SizedBox(height: 20),
//               SettingItem(
//                 title: "Log out",
//                 icon: Ionicons.log_out,
//                 bgColor: Colors.red.shade100,
//                 iconColor: Colors.red,
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => LoginScreen(),
//                     ),
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
