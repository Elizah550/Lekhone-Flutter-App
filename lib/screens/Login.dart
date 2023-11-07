import 'package:Warehouse/screens/OTP_screen.dart';
import 'package:Warehouse/screens/constants.dart';
import 'package:Warehouse/screens/custom_buttons.dart';
import 'package:Warehouse/screens/home_screen.dart';
import 'package:Warehouse/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatefulWidget {
  static String routeName = 'LoginScreen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController phoneNumberController;
  String errorMessage = '';
  String otp = '';

  @override
  void initState() {
    super.initState();
    phoneNumberController = TextEditingController();
  }

  @override
  void dispose() {
    phoneNumberController.dispose();
    super.dispose();
  }

  Future<void> sendOTP(String phoneNumber, String countryCode) async {
    final apiUrl =
        'https://ba4l8zwsyf.execute-api.ap-south-1.amazonaws.com/DEV';

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

      setState(() {
        otp = responseJson['body'].toString();
      });

      print('OTP: $otp');

      if (await checkUserExistence(phoneNumber)) {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => HomeScreen(),
        //   ),
        // );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OTPScreen(otp: otp),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('User credentials not exists'),
            duration: Duration(seconds: 5),
          ),
        );
      }
    } else {
      setState(() {
        errorMessage = 'Failed to send OTP. Please try again.';
      });
    }
  }

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

      if (responseJson != null && responseJson.isNotEmpty) {
        // Check if the list contains any elements
        final Map<String, dynamic> user = responseJson.first;
        // Access the first user in the list, assuming it's a Map
        if (user.containsKey('Consumer_id')) {
          // Check if 'Consumer_id' key exists in the user data
          return true;
        }
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: Column(
          children: [
            Container(
              width: 100.w,
              height: 35.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Hi, Consumer',
                          style: Theme.of(context).textTheme.titleMedium),
                      Text('Sign in to continue',
                          style: Theme.of(context).textTheme.titleSmall),
                      SizedBox(height: kDefaultPadding),
                    ],
                  ),
                  Image.asset(
                    'assets/images/Rhenix_1_Logo.png',
                    height: 20.h,
                    width: 40.w,
                  ),
                  SizedBox(height: kDefaultPadding / 2),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 5.w, right: 5.w),
                decoration: BoxDecoration(
                  color: kOtherColor,
                  borderRadius: kTopBorderRadius,
                ),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: kDefaultPadding),
                        buildPhoneNumberField(),
                        SizedBox(height: kDefaultPadding),
                        DefaultButton(
                          onPress: () {
                            if (_formKey.currentState!.validate()) {
                              sendOTP(phoneNumberController.text, '+91');
                            }
                          },
                          title: 'SIGN IN',
                          iconData: Icons.arrow_forward_outlined,
                        ),
                        SizedBox(height: kDefaultPadding),
                        if (errorMessage.isNotEmpty)
                          Text(
                            errorMessage,
                            style: TextStyle(color: Colors.red),
                          ),
                        SizedBox(height: kDefaultPadding),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, SignupScreen.routeName);
                            },
                            child: Text(
                              'Don\'t have an account',
                              textAlign: TextAlign.end,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextFormField buildPhoneNumberField() {
    return TextFormField(
      controller: phoneNumberController,
      textAlign: TextAlign.start,
      keyboardType: TextInputType.phone,
      style: kInputTextStyle,
      decoration: InputDecoration(
        labelText: 'Mobile Number',
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a phone number';
        } else if (value.length != 10) {
          return 'Phone number must be 10 digits long';
        }
        return null;
      },
    );
  }
}
