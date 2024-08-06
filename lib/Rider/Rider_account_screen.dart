import 'package:Lekhone/Rider/DashboardScreen.dart';
import 'package:Lekhone/Rider/Login.dart';
import 'package:Lekhone/Rider/Logoutscreen/Rider_Logout.dart';
import 'package:Lekhone/Rider/Rider_edit_screen.dart';
import 'package:Lekhone/main.dart';
import 'package:Lekhone/screens/Login/Login.dart';
import 'package:Lekhone/screens/Logoutscreen/Logout.dart';
import 'package:Lekhone/screens/Splashscreen/splash_screen_pavan_edit.dart';
import 'package:Lekhone/screens/settings/edit_screen.dart';
import 'package:Lekhone/ui/views/parcel_center/parcel_center_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RiderAccountScreen extends StatefulWidget {
  const RiderAccountScreen({Key? key});

  @override
  State<RiderAccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<RiderAccountScreen> {
  final RiderphoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile screen',
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.w600, color: Colors.black),
        ),
        backgroundColor: Color(0xFFFFCE00),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RiderDashboardScreen(),
              ),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              const Text(
                "Account",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundImage: AssetImage("assets/avatar.png"),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: FutureBuilder<Map<String, dynamic>?>(
                        future: RiderFetchuser(RiderphoneNumberController.text),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError ||
                              snapshot.data == null) {
                            return Text("Error loading user details");
                          } else {
                            final user = snapshot.data!;
                            final userName = user['Name'] ?? 'No Name';

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  userName,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 10),
                              ],
                            );
                          }
                        },
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RiderEditAccountScreen(),
                          ),
                        );
                      },
                      child: Text('Edit Profile'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                "Settings",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                title: Text("Payments"),
                onTap: () {
                  // Handle payments setting
                },
              ),
              ListTile(
                title: Text("Language"),
                onTap: () {
                  // Handle language setting
                },
              ),
              ListTile(
                title: Text("Notifications"),
                onTap: () {
                  // Handle notifications setting
                },
              ),
              SwitchListTile(
                title: Text("Dark Mode"),
                value: isDarkMode,
                onChanged: (value) {
                  setState(() {
                    isDarkMode = value;
                  });
                },
              ),
              ListTile(
                title: Text("Help"),
                onTap: () {
                  // Handle help setting
                },
              ),
              ListTile(
                title: Text("Log out"),
                onTap: () {
                  onTaplogout(context);
                },
              ),

              // ListTile(
              //   title: Text("Log out"),
              //   onTap: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) => LoginScreen(),
              //       ),
              //     );
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

bool isDarkMode = false;

Future<Map<String, dynamic>?> RiderFetchuser(String phoneNumber) async {
  final apiUrl =
      'https://4q97i45wf0.execute-api.ap-south-1.amazonaws.com/EmployerFetch';

  final response = await http.post(
    Uri.parse(apiUrl),
    body: jsonEncode({'Employee_id': RiderphoneNumberController.text}),
    headers: {
      'Content-Type': 'application/json',
    },
  );

  print(
      'Check User Existence Response: ${response.statusCode} - ${response.body}');

  if (response.statusCode == 200) {
    final List<dynamic> responseJson = jsonDecode(response.body);
    print('User Existence Response: $responseJson');

    if (responseJson.isNotEmpty) {
      final Map<String, dynamic> user = responseJson.first;

      if (user.containsKey('Employee_id')) {
        return user;
      }
    }
  }
  return null;
}

onTaplogout(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return AlertDialog(
        insetPadding: EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: EdgeInsets.zero,
        content: RiderLogoutScreen(),
      );
    },
  );
}
