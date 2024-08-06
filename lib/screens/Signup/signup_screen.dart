import 'package:Lekhone/screens/Login/Login.dart';
import 'package:Lekhone/screens/custom_buttons.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignupScreen extends StatefulWidget {
  static String routeName = 'SignupScreen';

  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController secondaryPhoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController zipcodeController = TextEditingController();

  String errorMessage = '';

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    secondaryPhoneController.dispose();
    addressController.dispose();
    zipcodeController.dispose();
    super.dispose();
  }

  Future<void> registerUser() async {
    const apiUrl =
        'https://3efa8808kk.execute-api.ap-south-1.amazonaws.com/DEV/consumer';

    final userExists = await checkIfUserExists(phoneController.text);

    if (userExists) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('User already exists'),
          duration: Duration(seconds: 3),
        ),
      );
      clearControllers();
    } else {
      final response = await http.put(
        Uri.parse(apiUrl),
        body: jsonEncode({
          'Consumer_id': phoneController.text,
          'Name': nameController.text,
          'Phone': phoneController.text,
          'Email': emailController.text,
          'SecondaryPhone': secondaryPhoneController.text,
          'Address': addressController.text,
          'Zipcode': zipcodeController.text,
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        showSuccessSnackBar();
        clearControllers();
        navigateToLoginScreen();
      } else {
        showFailureSnackBar();
      }
    }
  }

  Future<bool> checkIfUserExists(String consumerId) async {
    const apiUrl =
        'https://rruqo66rti.execute-api.ap-south-1.amazonaws.com/Fetch_Consumer';

    final response = await http.post(
      Uri.parse(apiUrl),
      body: jsonEncode({
        'Consumer_id': consumerId,
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final userList = jsonDecode(response.body) as List<dynamic>;
      return userList.isNotEmpty;
    }

    return false;
  }

  void clearControllers() {
    nameController.clear();
    phoneController.clear();
    emailController.clear();
    secondaryPhoneController.clear();
    addressController.clear();
    zipcodeController.clear();
  }

  void showSuccessSnackBar() {
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Color.fromARGB(0, 236, 232, 232),
      content: AwesomeSnackbarContent(
        title: 'Oh Great !',
        message: 'Signed up successfully',
        contentType: ContentType.success,
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  void showFailureSnackBar() {
    setState(() {
      errorMessage = 'Registration failed. Please try again.';
    });
  }

  void navigateToLoginScreen() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      LoginScreen.routeName,
      (route) => false,
    );
  }

  String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Fill your name';
    }
    if (value.length > 20) {
      return 'Text must not exceed 20 characters';
    }
    if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
      return 'Special characters are not allowed';
    }
    return null;
  }

  String? phoneValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a phone number';
    }
    if (value.length != 10) {
      return 'Phone number must be 10 digits long';
    }
    return null;
  }

  String? zipcodeValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a zipcode';
    }
    if (value.length != 6) {
      return 'Zipcode must be 6 digits long';
    }
    return null;
  }

  String? addressValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter address';
    }
    if (value.length > 50) {
      return 'Text must not exceed 50 characters';
    }
    if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
      return 'Special characters are not allowed';
    }
    return null;
  }

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email address';
    }
    if (value.length > 50) {
      return 'Email must not exceed 50 characters';
    }
    if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
        .hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Signup',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w300,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    labelText: 'Name',
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
                    errorMaxLines: 1,
                  ),
                  validator: nameValidator,
                  keyboardType: TextInputType.text,
                  style: TextStyle(fontSize: 25),
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: phoneController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    labelText: 'Phone number',
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
                    errorMaxLines: 1,
                  ),
                  validator: phoneValidator,
                  keyboardType: TextInputType.phone,
                  style: TextStyle(fontSize: 25),
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    labelText: 'Email',
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
                    errorMaxLines: 1,
                  ),
                  validator: emailValidator,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(fontSize: 25),
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: secondaryPhoneController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    labelText: 'Secondary Phone',
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
                    errorMaxLines: 1,
                  ),
                  validator: phoneValidator,
                  keyboardType: TextInputType.phone,
                  style: TextStyle(fontSize: 25),
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: addressController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    labelText: 'Address',
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
                    errorMaxLines: 1,
                  ),
                  validator: addressValidator,
                  keyboardType: TextInputType.text,
                  style: TextStyle(fontSize: 25),
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: zipcodeController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    labelText: 'Zipcode',
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
                    errorMaxLines: 1,
                  ),
                  validator: zipcodeValidator,
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontSize: 25),
                ),
                SizedBox(height: 28),
                DefaultButton(
                  onPress: () {
                    if (_formKey.currentState!.validate()) {
                      registerUser();
                    } else if (nameController.text.isEmpty ||
                        phoneController.text.isEmpty ||
                        addressController.text.isEmpty ||
                        zipcodeController.text.isEmpty ||
                        secondaryPhoneController.text.isEmpty ||
                        emailController.text.isEmpty) {
                      final snackBar = SnackBar(
                        elevation: 0,
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Color.fromARGB(0, 236, 232, 232),
                        content: AwesomeSnackbarContent(
                          title: 'Oh know !',
                          message: 'Empty fields please fill',
                          contentType: ContentType.failure,
                        ),
                      );

                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(snackBar);
                    }
                  },
                  title: 'Submit',
                  iconData: Icons.arrow_forward_outlined,
                ),
                if (errorMessage.isNotEmpty)
                  Text(
                    errorMessage,
                    style: const TextStyle(color: Colors.red),
                  ),
                TextButton(
                  onPressed: () {
                    navigateToLoginScreen();
                  },
                  // style: TextButton.styleFrom(
                  //   backgroundColor:
                  //       Colors.white, // Set background color to white
                  //   padding: EdgeInsets.symmetric(
                  //       vertical: 15), // Adjust padding for better appearance
                  // ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account? ',
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Login',
                        style: TextStyle(fontSize: 17, color: Colors.white
                            // Set the color you want for the "Login" text
                            ),
                      ),
                    ],
                  ),
                ),

                // TextButton(
                //   onPressed: () {
                //     navigateToLoginScreen();
                //   },
                //   child: const Text(
                //     'Already have an account? Login',
                //     style: TextStyle(
                //       fontSize: 15,
                //       color: Colors.black,
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
