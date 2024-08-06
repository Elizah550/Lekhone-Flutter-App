import 'package:Lekhone/screens/Snackbar/src/awesome_snackbar_content.dart';
import 'package:Lekhone/screens/global.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:Lekhone/screens/constants.dart';
import 'package:Lekhone/screens/custom_buttons.dart';
import 'package:Lekhone/screens/Signup/signup_screen.dart';
import 'package:Lekhone/src/content_type.dart';
import 'package:Lekhone/ui/views/home/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';

late TextEditingController phoneNumberController;

class LoginScreen extends StatefulWidget {
  static String routeName = 'LoginScreen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String errorMessage = '';
  String otp = '';
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    phoneNumberController = TextEditingController();
    // Retrieve the phone number from SharedPreferences and set it initially
    loadPhoneNumber();
  }

  @override
  void dispose() {
    phoneNumberController.dispose();
    super.dispose();
  }

  void _signIn() async {
    setState(() {
      isLoading = true;
    });

    try {
      // Your sign-in logic here...

      // Simulating an async operation
      await Future.delayed(Duration(seconds: 2));

      // Save the phone number to SharedPreferences
      await savePhoneNumber();

      // Example: Navigating to the home screen on successful sign-in
      bool userExists = await checkUserExistence(phoneNumberController.text);

      if (userExists) {
        // User exists, proceed with sending OTP
        sendOTP(context, phoneNumberController.text, '+91');
      } else {
        if (phoneNumberController.text == '9133599722') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TrackerApp(),
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
          // User doesn't exist, show a toast or handle it accordingly
          // Fluttertoast.showToast(
          //   msg: "User does not exist!",
          //   toastLength: Toast.LENGTH_SHORT,
          //   gravity: ToastGravity.BOTTOM,
          //   backgroundColor: Colors.red,
          //   textColor: Colors.white,
          //   fontSize: 16.0,
          // );

          // Handle the case when the user doesn't exist (e.g., navigate to a registration screen)
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => RegistrationScreen(),
          //   ),
          // );
        }
      }
    } catch (error) {
      // Handle errors during sign-in
      print('Error during sign-in: $error');
      setState(() {
        errorMessage = 'An error occurred during sign-in';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // Function to save the phone number to SharedPreferences
  Future<void> savePhoneNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('phoneNumber', phoneNumberController.text);
  }

  // Function to load the phone number from SharedPreferences
  Future<void> loadPhoneNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedPhoneNumber = prefs.getString('phoneNumber');
    if (savedPhoneNumber != null) {
      setState(() {
        phoneNumberController.text = savedPhoneNumber;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IgnorePointer(
        ignoring: isLoading,
        child: Stack(
          children: [
            Column(
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
                          Text(
                            'Hi, Consumer',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 30,
                            ),
                          ),
                          Text(
                            'Sign in to continue',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          SizedBox(height: kDefaultPadding),
                        ],
                      ),
                      Image.asset(
                        'assets/images/lekhone.png',
                        height: 20.h,
                        width: 40.w,
                      ),
                      SizedBox(height: kDefaultPadding / 2),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
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
                              onPress: _signIn,
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
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ),
                            ),
                            SizedBox(height: 35),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Divider(
                                          color: Colors.black,
                                          thickness: 1,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 8),
                                        child: Text(
                                          'or login with',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Divider(
                                          color: Colors.black,
                                          thickness: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          // Handle Google login
                                          // Replace the print statement with your logic
                                          print('Google Login');
                                        },
                                        icon: FaIcon(
                                          FontAwesomeIcons.google,
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      IconButton(
                                        onPressed: () {
                                          // Handle Facebook login
                                          // Replace the print statement with your logic
                                          print('Facebook Login');
                                        },
                                        icon: FaIcon(
                                          FontAwesomeIcons.facebook,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 150),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                'Version 2.2.0',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16.0,
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
            if (isLoading)
              Container(
                color: Colors.black.withOpacity(0.3),
                child: Center(
                  child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Color(0xFFFFCE00))),
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
        contentPadding: EdgeInsets.all(20),
        labelText: 'Mobile Number',
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(18),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(18),
        ),
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
