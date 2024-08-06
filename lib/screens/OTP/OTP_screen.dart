// import 'package:Warehouse/screens/Login.dart';
// import 'package:flutter/material.dart';
// import 'package:Warehouse/screens/home_screen.dart';

// class OTPScreen extends StatefulWidget {
//   static String routeName = 'OTPScreen';

//   final String otp; // Received OTP from the login screen.

//   const OTPScreen({Key? key, required this.otp}) : super(key: key);

//   @override
//   _OTPScreenState createState() => _OTPScreenState();
// }

// class _OTPScreenState extends State<OTPScreen> {
//   List<TextEditingController> controllers =
//       List.generate(4, (index) => TextEditingController());
//   List<FocusNode> focusNodes = List.generate(4, (index) => FocusNode());

//   @override
//   void dispose() {
//     for (var controller in controllers) {
//       controller.dispose();
//     }
//     for (var focusNode in focusNodes) {
//       focusNode.dispose();
//     }
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Enter OTP'),
//       ),
//       body: Center(
//         child: Container(
//           height: 300,
//           width: 300,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(10),
//             boxShadow: const [
//               BoxShadow(
//                 color: Colors.grey,
//                 blurRadius: 10,
//                 offset: Offset(0, 10),
//               ),
//             ],
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Text(
//                 'Enter OTP',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: List.generate(4, (index) {
//                   return SizedBox(
//                     width: 50, // Adjust as needed
//                     child: TextFormField(
//                       controller: controllers[index],
//                       focusNode: focusNodes[index],
//                       keyboardType: TextInputType.number,
//                       decoration: const InputDecoration(
//                         border: OutlineInputBorder(),
//                       ),
//                       onChanged: (value) {
//                         if (value.isNotEmpty) {
//                           if (index < 3) {
//                             focusNodes[index + 1].requestFocus();
//                           } else {
//                             // All digits entered, verify OTP
//                             final enteredOTP = controllers
//                                 .map((controller) => controller.text)
//                                 .join();
//                             print("Entered OTP: $enteredOTP");
//                             print("Received OTP: ${widget.otp}");

//                             if (enteredOTP == widget.otp) {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(
//                                   content: Text('Login successful'),
//                                   duration: Duration(seconds: 3),
//                                 ),
//                               );
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => const HomeScreen(),
//                                 ),
//                               );
//                             } else {
//                               showDialog(
//                                 context: context,
//                                 builder: (context) {
//                                   return AlertDialog(
//                                     title: const Text("Verification Code"),
//                                     content: const Text(
//                                         "Invalid OTP. Please try again."),
//                                     actions: <Widget>[
//                                       ElevatedButton(
//                                         onPressed: () {
//                                           Navigator.push(
//                                             context,
//                                             MaterialPageRoute(
//                                               builder: (context) =>
//                                                   LoginScreen(),
//                                             ),
//                                           );
//                                         },
//                                         child: const Text('OK'),
//                                       ),
//                                     ],
//                                   );
//                                 },
//                               );
//                             }
//                           }
//                         }
//                       },
//                     ),
//                   );
//                 }),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
