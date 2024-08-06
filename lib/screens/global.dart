import 'dart:async';
import 'dart:convert';
import 'package:Lekhone/screens/Login/Login.dart';
import 'package:Lekhone/screens/OTP/otp%20copy.dart';
import 'package:Lekhone/screens/OTP/otp.dart';
import 'package:Lekhone/screens/order_details_in_transit_screen/models/recently_shipped_data_model.dart';
import 'package:Lekhone/screens/order_details_in_transit_screen/order_details_in_transit_screen.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

Future<void> sendOTP(
    BuildContext context, String phoneNumber, String countryCode) async {
  final apiUrl = 'https://ba4l8zwsyf.execute-api.ap-south-1.amazonaws.com/DEV';

  final response = await http.post(
    Uri.parse(apiUrl),
    body: jsonEncode({
      'phone_number': phoneNumber,
      'countrycode': countryCode,
    }),
    headers: {
      'Content-Type': 'application/json',
    },
  );

  print('Send OTP Response: ${response.statusCode} - ${response.body}');

  if (response.statusCode == 200) {
    final responseJson = jsonDecode(response.body);
    print('OTP Response: $responseJson');

    // Assuming this checkUserExistence function is available
    if (await checkUserExistence(phoneNumber)) {
      // Fetchuser(phoneNumberController.text);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Otp(otp: responseJson['body'].toString()),
        ),
      );
    } else {
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Color.fromARGB(0, 236, 232, 232),
        content: AwesomeSnackbarContent(
          title: 'Oh know !',
          message: 'User with that phone number donot exist',
          contentType: ContentType.failure,
        ),
      );

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);

      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text('User credentials do not exist'),
      //     duration: Duration(seconds: 5),
      //   ),
      // );
    }
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Failed to send OTP. Please try again.'),
        duration: Duration(seconds: 5),
      ),
    );
  }
}

Future<void> RidersendOTP(
    BuildContext context, String riderphoneNumber, String countryCode) async {
  final apiUrl = 'https://ba4l8zwsyf.execute-api.ap-south-1.amazonaws.com/DEV';

  final response = await http.post(
    Uri.parse(apiUrl),
    body: jsonEncode({
      'phone_number': riderphoneNumber,
      'countrycode': countryCode,
    }),
    headers: {
      'Content-Type': 'application/json',
    },
  );

  print('Send OTP Response: ${response.statusCode} - ${response.body}');

  if (response.statusCode == 200) {
    final responseJson = jsonDecode(response.body);
    print('OTP Response: $responseJson');

    // Assuming this checkUserExistence function is available
    if (await RidercheckUserExistence(riderphoneNumber)) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RiderOtp(otp: responseJson['body'].toString()),
        ),
      );
    }
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Failed to send OTP. Please try again.'),
        duration: Duration(seconds: 5),
      ),
    );
  }
}

//For login
Future<bool> checkUserExistence(String phoneNumber) async {
  final apiUrl =
      'https://3efa8808kk.execute-api.ap-south-1.amazonaws.com/DEV/consumer';

  final response = await http.post(
    Uri.parse(apiUrl),
    body: jsonEncode({'Consumer_id': phoneNumber}),
    headers: {
      'Content-Type': 'application/json',
    },
  );

  print(
      'Check User Existence Response: ${response.statusCode} - ${response.body}');

  // if (response.statusCode == 200) {
  //   final responseJson = jsonDecode(response.body);
  //   print('User Existence Response: $responseJson');
  //   return responseJson != null && responseJson['Consumer_id'] != null;
  // }
  // Data format for testing---
  // [{"Phone": "9133599721", "Consumer_id": "9133599721",
  // "Address": "Park", "Zipcode": "530051", "SecondaryPhone": "7036397577",
  // "Email": "pavankumar@rhenix.org", "Name": "Pavan Kumar"}]
  // flutter: User Existence Response: [{Phone: 9133599721,
  //Consumer_id: 9133599721, Address: Park, Zipcode: 530051,
  //SecondaryPhone: 7036397577, Email: pavankumar@rhenix.org,
  // Name: Pavan Kumar}]

  if (response.statusCode == 200) {
    final List<dynamic> responseJson = jsonDecode(response.body);
    print('User Existence Response: $responseJson');

    if (responseJson.isNotEmpty) {
      print("Entered here check please");
      // Check if the list contains any elements
      final Map<String, dynamic> user = responseJson.first;
      // Access the first user in the list, assuming it's a Map
      if (user.containsKey('Consumer_id')) {
        // Check if 'Consumer_id' key exists in the user data
        return true;
      }
    } else {
      print("No-data");
    }
  }

  return false;
}

//error messages-----
//
Future<bool> RidercheckUserExistence(String RiderphoneNumber) async {
  print("Entered--here--for--rider");
  final apiUrl =
      'https://4q97i45wf0.execute-api.ap-south-1.amazonaws.com/EmployerFetch';

  final response = await http.post(
    Uri.parse(apiUrl),
    body: jsonEncode({'Employee_id': RiderphoneNumber}),
    headers: {
      'Content-Type': 'application/json',
    },
  );
  print("Here the employer--data");
  print(
      'Check User Existence Response: ${response.statusCode} - ${response.body}');

  if (response.statusCode == 200) {
    final List<dynamic> responseJson = jsonDecode(response.body);
    print('User Existence Response: $responseJson');

    if (responseJson.isNotEmpty) {
      print("Entered here check please");
      // Check if the list contains any elements
      final Map<String, dynamic> Rideruser = responseJson.first;
      // Access the first user in the list, assuming it's a Map
      if (Rideruser.containsKey('Employee_id')) {
        // Check if 'Consumer_id' key exists in the user data
        return true;
      }
    } else {
      print("No-data");
    }
  }

  return false;
}

//Mapfetch
// Future<void> Mapfetch({required String Map_id}) async {
//   final String apiUrl =
//       'https://9cd3fzfwae.execute-api.ap-south-1.amazonaws.com/Maps_fetch';

//   try {
//     // Prepare the request headers
//     Map<String, String> headers = {'Content-Type': 'application/json'};

//     // Prepare the request body with the Map_id
//     Map<String, dynamic> requestBody = {'Map_id': Map_id};

//     // Make a POST request to the API with the request body
//     final http.Response response = await http.post(
//       Uri.parse(apiUrl),
//       headers: headers,
//       body: jsonEncode(requestBody),
//     );

//     // Check if the request was successful (status code 200)
//     if (response.statusCode == 200) {
//       // Parse the response JSON if needed
//       final Map<String, dynamic> data = json.decode(response.body);
//       print("Here---map---details--fetch----pp");
//       print(data);

//       // Process the data as needed
//       print('Received data: $data');
//     } else {
//       // Handle error if the request was not successful
//       print('Failed to fetch data: ${response.statusCode}');
//     }
//   } catch (error) {
//     // Handle any exceptions that occurred during the HTTP request
//     print('Error fetching data: $error');
//   }
// }
////////////////////////////////////////////////////////////////////////
Future<Map<String, dynamic>> Mapfetch({required String Map_id}) async {
  final String apiUrl =
      'https://9cd3fzfwae.execute-api.ap-south-1.amazonaws.com/Maps_fetch';

  try {
    // Prepare the request headers
    Map<String, String> headers = {'Content-Type': 'application/json'};

    // Prepare the request body with the Map_id
    Map<String, dynamic> requestBody = {'Map_id': Map_id};

    // Make a POST request to the API with the request body
    final http.Response response = await http.post(
      Uri.parse(apiUrl),
      headers: headers,
      body: jsonEncode(requestBody),
    );

    // Check if the request was successful (status code 200)
    if (response.statusCode == 200) {
      // Parse the response JSON if needed
      final Map<String, dynamic> data = json.decode(response.body);
      // print("Here---map---details--fetch----pp");
      // print(data);

      // Process the data as needed
      // print('Received data: $data');

      return data; // Return the fetched data
    } else {
      // Handle error if the request was not successful
      print('Failed to fetch data: ${response.statusCode}');
      throw Exception('Failed to fetch data');
    }
  } catch (error) {
    // Handle any exceptions that occurred during the HTTP request
    print('Error fetching data: $error');
    throw Exception('Error fetching data');
  }
}
///////////////////////////////////////////////////////////////////////////////

void _showSuccessSnackbar(BuildContext context, String message) {
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

void _showErrorSnackbar(BuildContext context, String message) {
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

//For account screen
// Future<Map<String, dynamic>?> Fetchuser(String phoneNumber) async {
//   final apiUrl =
//       'https://3efa8808kk.execute-api.ap-south-1.amazonaws.com/DEV/consumer';

//   final response = await http.post(
//     Uri.parse(apiUrl),
//     body: jsonEncode({'Consumer_id': phoneNumber}),
//     headers: {
//       'Content-Type': 'application/json',
//     },
//   );

//   print(
//       'Check User Existence Response: ${response.statusCode} - ${response.body}');

//   if (response.statusCode == 200) {
//     final List<dynamic> responseJson = jsonDecode(response.body);
//     print('User Existence Response: $responseJson');

//     if (responseJson.isNotEmpty) {
//       // Check if the list contains any elements
//       final Map<String, dynamic> user = responseJson.first;
//       // Access the first user in the list, assuming it's a Map
//       if (user.containsKey('Consumer_id')) {
//         // Check if 'Consumer_id' key exists in the user data
//         return user;
//       }
//     }
//   }
//   return null;
// }

bool isPhoneNumberValid(String phoneNumber) {
  return phoneNumber.length == 10;
}

Future<void> bookAppointment(
  BuildContext context,
  String appointmentDate,
  String appointmentTime,
  String countryCode,
  String phoneNumber,
  String customerName,
  String recipientEmail,
  String deliveryMethod,
  String size,
) async {
  if (appointmentDate.isEmpty || appointmentTime.isEmpty) {
    _showErrorSnackbar(context, 'Please select a date and time.');
    return;
  }

  if (!isPhoneNumberValid(phoneNumber)) {
    _showErrorSnackbar(context, 'Phone number must be 10 digits long.');
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
    "delivery_method": deliveryMethod,
    "parcel_size": size,
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

    print('Status Code: ${response.statusCode}');

    if (response.statusCode == 200) {
      // _showSuccessSnackbar(context, responseJson['body']);
    } else if (response.statusCode == 203 || response.statusCode == 202) {
      _showErrorSnackbar(context, responseJson['body']);
    } else {
      _showErrorSnackbar(
          context, 'An error occurred while booking the appointment.');
    }
  } catch (e) {
    _showErrorSnackbar(
        context, 'An error occurred. Please check your internet connection.');
  }
}

Future<void> Tripdetails(
  BuildContext context,
  String appointmentDate,
  String appointmentTime,
  String countryCode,
  String phoneNumber,
  String customerName,
  String recipientEmail,
  String Address,
  // String text,
) async {
  if (appointmentDate.isEmpty || appointmentTime.isEmpty) {
    _showErrorSnackbar(context, 'Please select a date and time.');
    return;
  }

  if (!isPhoneNumberValid(phoneNumber)) {
    _showErrorSnackbar(context, 'Phone number must be 10 digits long.');
    return;
  }

  const apiUrl =
      'https://fb9bvierjh.execute-api.ap-south-1.amazonaws.com/PUTTRIP/WH_PUT_Trip';

  final inputtedData = {
    "appointment_date": appointmentDate,
    "appointment_time": appointmentTime,
    "countrycode": countryCode,
    "phone_number": phoneNumber,
    "customer_name": customerName,
    "recipient_email": recipientEmail,
    "Address": Address
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

    print('Status Code: ${response.statusCode}');

    if (response.statusCode == 200) {
      print("Entered-----showed---Trip-id");
      // _showSuccessSnackbar(context, responseJson['body']);
      print("-----------------------------------------------------------");
      // var responseBody = json.decode(responseJson['body']);
      // final FinalID = responseBody['Trip_id'];
      print(responseJson['Trip_id']);
      final FinalID = responseJson['Trip_id'];
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OrderDetailsInTransitScreen(
            orderData: RecentlyShipped(customerName, FinalID, appointmentDate,
                appointmentTime, Address, 'In Transit'),
          ),
        ),
      );
    } else if (response.statusCode == 203 || response.statusCode == 202) {
      _showErrorSnackbar(context, responseJson['body']);
    } else {
      _showErrorSnackbar(
          context, 'An error occurred while booking the appointment.');
    }
  } catch (e) {
    _showErrorSnackbar(
        context, 'An error occurred. Please check your internet connection.');
  }
}

Future<void> fetchDetails(String phoneNumber, String date, String time) async {
  final apiUrl =
      'https://kdfalbrqb0.execute-api.ap-south-1.amazonaws.com/Fetch_Appointments';

  // final response = await http.get(
  //   Uri.parse('$apiUrl?name=$name&phoneNumber=$phoneNumber'),
  //   headers: {'Content-Type': 'application/json'},
  // );
  final response = await http.post(
    Uri.parse(apiUrl),
    body: jsonEncode({
      'phone_number': phoneNumber,
      'appointment_date': date,
      'appointment_time': time
    }),
    headers: {
      'Content-Type': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);
    for (var item in data) {
      print(
          'Name: ${item['customer_name']}, Email: ${item['recipient_email']}, Trip_id: ${item['Trip_id']}');
    }
  } else {
    print('Failed to load details: ${response.statusCode}');
  }
}
