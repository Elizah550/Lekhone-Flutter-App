// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class AppointmentsScreen extends StatefulWidget {
//   const AppointmentsScreen({Key? key}) : super(key: key);

//   @override
//   _AppointmentsScreenState createState() => _AppointmentsScreenState();
// }

// class _AppointmentsScreenState extends State<AppointmentsScreen> {
//   final _dateController = TextEditingController();
//   final _timeController = TextEditingController();
//   final _phoneNumberController = TextEditingController();
//   final _customerNameController = TextEditingController();
//   final _recipientEmailController = TextEditingController();
//   String _selectedCountryCode = '+91'; // Default country code

//   final List<String> countryCodes = [
//     '+91',
//     '+1',
//     '+44',
//     '+61',
//     // Add more country codes as needed
//   ];

//   Future<void> _selectDate() async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime.now(),
//       lastDate: DateTime(2101),
//     );
//     if (picked != null && picked != DateTime.now())
//       _dateController.text = picked.toLocal().toString().split(' ')[0];
//   }

//   Future<void> _selectTime() async {
//     final TimeOfDay? picked = await showTimePicker(
//       context: context,
//       initialTime: TimeOfDay.now(),
//     );
//     if (picked != null) _timeController.text = picked.format(context);
//   }

//   Future<void> _bookAppointment() async {
//     final appointmentDate = _dateController.text;
//     final appointmentTime = _timeController.text;
//     final countryCode = _selectedCountryCode;
//     final phoneNumber = _phoneNumberController.text;
//     final customerName = _customerNameController.text;
//     final recipientEmail = _recipientEmailController.text;

//     if (appointmentDate.isEmpty || appointmentTime.isEmpty) {
//       _showErrorSnackbar('Please select a date and time.');
//       return;
//     }

//     const apiUrl =
//         'https://0nx0vkdin9.execute-api.ap-south-1.amazonaws.com/Appointments_Api';

//     final Map<String, String> requestBody = {
//       'appointment_date': appointmentDate,
//       'appointment_time': appointmentTime,
//       'countrycode': countryCode,
//       'phone_number': phoneNumber,
//       'customer_name': customerName,
//       'recipient_email': recipientEmail,
//     };

//     final headers = <String, String>{
//       'Content-Type': 'application/json',
//     };

//     try {
//       final response = await http.post(
//         Uri.parse(apiUrl),
//         headers: headers,
//         body: jsonEncode(requestBody),
//       );

//       if (response.statusCode == 200) {
//         _showSuccessSnackbar('Appointment Booked');
//       } else {
//         _showErrorSnackbar('An error occurred while booking the appointment.');
//       }
//     } catch (e) {
//       _showErrorSnackbar(
//           'An error occurred. Please check your internet connection.');
//     }
//   }

//   void _showSuccessSnackbar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//       content: Text(message),
//       action: SnackBarAction(
//         label: 'OK',
//         onPressed: () {
//           ScaffoldMessenger.of(context).hideCurrentSnackBar();
//           Navigator.of(context).pop(); // Close the appointments screen
//         },
//       ),
//     ));
//   }

//   void _showErrorSnackbar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//       content: Text(message),
//       action: SnackBarAction(
//         label: 'OK',
//         onPressed: () {
//           ScaffoldMessenger.of(context).hideCurrentSnackBar();
//         },
//       ),
//     ));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Appointments'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _dateController,
//               decoration: InputDecoration(labelText: 'Appointment Date'),
//               onTap: () {
//                 _selectDate();
//               },
//             ),
//             TextField(
//               controller: _timeController,
//               decoration: InputDecoration(labelText: 'Appointment Time'),
//               onTap: () {
//                 _selectTime();
//               },
//             ),
//             DropdownButtonFormField(
//               decoration: InputDecoration(labelText: 'Country Code'),
//               value: _selectedCountryCode,
//               items: countryCodes.map((code) {
//                 return DropdownMenuItem(
//                   value: code,
//                   child: Text(code),
//                 );
//               }).toList(),
//               onChanged: (value) {
//                 setState(() {
//                   _selectedCountryCode = value.toString();
//                 });
//               },
//             ),
//             TextField(
//               controller: _phoneNumberController,
//               decoration: InputDecoration(labelText: 'Phone Number'),
//             ),
//             TextField(
//               controller: _customerNameController,
//               decoration: InputDecoration(labelText: 'Customer Name'),
//             ),
//             TextField(
//               controller: _recipientEmailController,
//               decoration: InputDecoration(labelText: 'Recipient Email'),
//             ),
//             ElevatedButton(
//               onPressed: _bookAppointment,
//               child: Text('Book Appointment'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

//https://0nx0vkdin9.execute-api.ap-south-1.amazonaws.com/Appointments_Api