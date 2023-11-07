import 'package:flutter/material.dart';
import 'package:Warehouse/screens/Login.dart';
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
      nameController.clear();
      phoneController.clear();
      emailController.clear();
      secondaryPhoneController.clear();
      addressController.clear();
      zipcodeController.clear();
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Signed up successfully'),
            duration: Duration(seconds: 3),
          ),
        );
        nameController.clear();
        phoneController.clear();
        emailController.clear();
        secondaryPhoneController.clear();
        addressController.clear();
        zipcodeController.clear();
        Navigator.pushNamedAndRemoveUntil(
          context,
          LoginScreen.routeName,
          (route) => false,
        );
      } else {
        setState(() {
          errorMessage = 'Registration failed. Please try again.';
        });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signup'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
                keyboardType: TextInputType.text,
              ),
              TextFormField(
                controller: phoneController,
                decoration: const InputDecoration(labelText: 'Phone Number'),
                validator: phoneValidator,
                keyboardType: TextInputType.phone,
              ),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    if (!value.contains('@')) {
                      return 'Invalid email format';
                    }
                  }
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
              ),
              TextFormField(
                controller: secondaryPhoneController,
                decoration: const InputDecoration(labelText: 'Secondary Phone'),
                keyboardType: TextInputType.phone,
              ),
              TextFormField(
                controller: addressController,
                decoration: const InputDecoration(labelText: 'Address'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an address';
                  }
                  return null;
                },
                keyboardType: TextInputType.text,
              ),
              TextFormField(
                controller: zipcodeController,
                decoration: const InputDecoration(labelText: 'Zipcode'),
                validator: zipcodeValidator,
                keyboardType: TextInputType.number,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    registerUser();
                  }
                },
                child: const Text('Submit'),
              ),
              if (errorMessage.isNotEmpty)
                Text(
                  errorMessage,
                  style: const TextStyle(color: Colors.red),
                ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    LoginScreen.routeName,
                    (route) => false,
                  );
                },
                child: const Text(
                  'Already have an account? Login',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
