import 'package:Lekhone/screens/Snackbar/src/awesome_snackbar_content.dart';
import 'package:Lekhone/src/content_type.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EditAccountScreen extends StatefulWidget {
  const EditAccountScreen({super.key});

  @override
  State<EditAccountScreen> createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
  String gender = "man";
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool isEditMode = false;

  @override
  void initState() {
    super.initState();
    // Fetch and set initial data when the screen is created
    getAndSetInitialData();
  }

  // Function to fetch and set initial user data
  Future<void> getAndSetInitialData() async {
    final existingUserData = await getUserData();

    setState(() {
      nameController.text = existingUserData['Name'] ?? '';
      ageController.text = existingUserData['Age']?.toString() ?? '';
      emailController.text = existingUserData['Email'] ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Ionicons.chevron_back_outline),
        ),
        leadingWidth: 80,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () async {
                // If in update mode, call the function to update user details
                if (isEditMode) {
                  await updateUserDetails();
                  setState(() {
                    isEditMode = false;
                  });
                } else {
                  // Switch to edit mode
                  setState(() {
                    isEditMode = true;
                  });
                }
              },
              style: IconButton.styleFrom(
                backgroundColor: Colors.lightBlueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                fixedSize: Size(60, 50),
                elevation: 3,
              ),
              icon: Icon(
                isEditMode ? Ionicons.checkmark : Ionicons.create_outline,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Account",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),

              // EditItem for Photo
              EditItem(
                title: "Photo",
                widget: Column(
                  children: [
                    Image.asset(
                      "assets/avatar.png",
                      height: 100,
                      width: 100,
                    ),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.lightBlueAccent,
                      ),
                      child: const Text("Upload Image"),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 40),

              // EditItem for Name
              EditItem(
                title: "Name",
                widget: TextField(
                  controller: nameController,
                  style: TextStyle(
                    color: isEditMode ? Colors.black : Colors.grey,
                  ),
                  enabled: isEditMode,
                ),
              ),
              const SizedBox(height: 40),

              // EditItem for Gender
              EditItem(
                title: "Gender",
                widget: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          gender = "man";
                        });
                      },
                      style: IconButton.styleFrom(
                        backgroundColor: gender == "man"
                            ? Colors.deepPurple
                            : Colors.grey.shade200,
                        fixedSize: const Size(50, 50),
                      ),
                      icon: Icon(
                        Ionicons.male,
                        color: gender == "man" ? Colors.white : Colors.black,
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 20),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          gender = "woman";
                        });
                      },
                      style: IconButton.styleFrom(
                        backgroundColor: gender == "woman"
                            ? Colors.deepPurple
                            : Colors.grey.shade200,
                        fixedSize: const Size(50, 50),
                      ),
                      icon: Icon(
                        Ionicons.female,
                        color: gender == "woman" ? Colors.white : Colors.black,
                        size: 18,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 40),

              // EditItem for Age
              EditItem(
                widget: TextField(
                  controller: ageController,
                  style: TextStyle(
                    color: isEditMode ? Colors.black : Colors.grey,
                  ),
                  enabled: isEditMode,
                ),
                title: "Age",
              ),
              const SizedBox(height: 40),

              // EditItem for Email
              EditItem(
                widget: TextField(
                  controller: emailController,
                  style: TextStyle(
                    color: isEditMode ? Colors.black : Colors.grey,
                  ),
                  enabled: isEditMode,
                ),
                title: "Email",
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to update user details
  Future<void> updateUserDetails() async {
    final apiUrl =
        'https://3efa8808kk.execute-api.ap-south-1.amazonaws.com/DEV/consumer';

    final existingUserData = await getUserData(); // Fetch existing user data

    final response = await http.put(
      Uri.parse(apiUrl),
      body: jsonEncode({
        'Consumer_id': "9133599721", // Use the appropriate consumer ID
        ...existingUserData, // Include existing user data
        'Name': nameController.text,
        'Age': int.tryParse(ageController.text) ?? 0,
        'Email': emailController.text,
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    print(
        'Update User Details Response: ${response.statusCode} - ${response.body}');

    if (response.statusCode == 200) {
      // Show a snackbar indicating success
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Color.fromARGB(0, 236, 232, 232),
        content: AwesomeSnackbarContent(
          title: 'Yes !',
          message: 'Your data has updated successfully !!',
          contentType: ContentType.success,
        ),
      );

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);

      // Update successful, you can handle the response accordingly
    } else {
      // Show a snackbar indicating failure
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Color.fromARGB(0, 236, 232, 232),
        content: Text(
          'Failed to update data. Please try again.',
          style: TextStyle(
            color: Colors.red,
          ),
        ),
      );
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);

      // Update failed, you can handle the response accordingly
    }
  }

  // Function to fetch existing user data
  Future<Map<String, dynamic>> getUserData() async {
    final apiUrl =
        'https://3efa8808kk.execute-api.ap-south-1.amazonaws.com/DEV/consumer';

    final response = await http.post(
      Uri.parse(apiUrl),
      body: jsonEncode(
          {'Consumer_id': "9133599721"}), // Use the appropriate consumer ID
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> responseJson = jsonDecode(response.body);

      if (responseJson.isNotEmpty) {
        // Check if the list contains any elements
        final Map<String, dynamic> existingUserData = responseJson.first;
        // Access the first user in the list, assuming it's a Map
        return existingUserData;
      }
    }

    return {}; // Return an empty map if no existing data is found
  }
}

class EditItem extends StatelessWidget {
  const EditItem({
    Key? key,
    required this.title,
    required this.widget,
  }) : super(key: key);

  final String title;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        widget,
      ],
    );
  }
}
