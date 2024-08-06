import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

final _dateController = TextEditingController();
final _timeController = TextEditingController();
final _phoneNumberController = TextEditingController();
final _customerNameController = TextEditingController();
final _recipientEmailController = TextEditingController();
String _selectedCountryCode = '+91';

final List<String> countryCodes = [
  '+91',
  '+1',
  '+44',
  '+61',
];

class AppointmentsScreen extends StatefulWidget {
  static String routeName = 'AppointmentsScreen';
  const AppointmentsScreen({Key? key}) : super(key: key);

  @override
  _AppointmentsScreenState createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  // final _dateController = TextEditingController();
  // final _timeController = TextEditingController();
  // final _phoneNumberController = TextEditingController();
  // final _customerNameController = TextEditingController();
  // final _recipientEmailController = TextEditingController();
  // String _selectedCountryCode = '+91';

  // final List<String> countryCodes = [
  //   '+91',
  //   '+1',
  //   '+44',
  //   '+61',
  // ];

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != DateTime.now())
      _dateController.text = DateFormat('dd-MM-yyyy').format(picked);
  }

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null)
      _timeController.text = DateFormat('hh:mm a')
          .format(DateTime(0, 1, 1, picked.hour, picked.minute));
  }

  bool isPhoneNumberValid(String phoneNumber) {
    return phoneNumber.length == 10;
  }

  Future<void> _bookAppointment() async {
    final appointmentDate = _dateController.text;
    final appointmentTime = _timeController.text;
    final countryCode = _selectedCountryCode;
    final phoneNumber = _phoneNumberController.text;
    final customerName = _customerNameController.text;
    final recipientEmail = _recipientEmailController.text;

    if (appointmentDate.isEmpty || appointmentTime.isEmpty) {
      _showErrorSnackbar('Please select a date and time.');
      return;
    }

    if (!isPhoneNumberValid(phoneNumber)) {
      _showErrorSnackbar('Phone number must be 10 digits long.');
      return;
    }

    const apiUrl =
        'https://0nx0vkdin9.execute-api.ap-south-1.amazonaws.com/Appointments_Api';

    final inputtedData = {
      "appointment_date": appointmentDate,
      "appointment_time": appointmentTime,
      "countrycode": countryCode,
      "phone_number": phoneNumber,
      "customer_name": customerName,
      "recipient_email": recipientEmail,
    };

    final headers = <String, String>{
      'Content-Type': 'application/json',
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: jsonEncode(inputtedData),
      );

      final responseJson = json.decode(response.body);

      print('Status Code: ${response.statusCode}'); // Print the status code

      if (response.statusCode == 200) {
        _showSuccessSnackbar(responseJson['body']);
      } else if (response.statusCode == 203) {
        _showErrorSnackbar(responseJson['body']);
      } else if (response.statusCode == 202) {
        _showErrorSnackbar(responseJson['body']);
      } else {
        _showErrorSnackbar('An error occurred while booking the appointment.');
      }
    } catch (e) {
      _showErrorSnackbar(
          'An error occurred. Please check your internet connection.');
    }
  }

  void _showSuccessSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      action: SnackBarAction(
        label: 'OK',
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          Navigator.of(context).pop();
        },
      ),
    ));
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      action: SnackBarAction(
        label: 'OK',
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointments'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _dateController,
              decoration: InputDecoration(labelText: 'Appointment Date'),
              onTap: () {
                _selectDate();
              },
            ),
            TextField(
              controller: _timeController,
              decoration: InputDecoration(labelText: 'Appointment Time'),
              onTap: () {
                _selectTime();
              },
            ),
            DropdownButtonFormField(
              decoration: InputDecoration(labelText: 'Country Code'),
              value: _selectedCountryCode,
              items: countryCodes.map((code) {
                return DropdownMenuItem(
                  value: code,
                  child: Text(code),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCountryCode = value.toString();
                });
              },
            ),
            TextField(
              controller: _phoneNumberController,
              decoration: InputDecoration(labelText: 'Phone Number'),
              keyboardType: TextInputType.phone,
            ),
            TextField(
              controller: _customerNameController,
              decoration: InputDecoration(labelText: 'Customer Name'),
              keyboardType: TextInputType.text,
            ),
            TextField(
              controller: _recipientEmailController,
              decoration: InputDecoration(labelText: 'Recipient Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            ElevatedButton(
              onPressed: _bookAppointment,
              child: Text('Book Appointment'),
            ),
          ],
        ),
      ),
    );
  }
}
