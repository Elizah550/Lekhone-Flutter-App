import 'package:Lekhone/utils/image_utils.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(
              fontSize: 30,
              fontFamily:
                  'Poppins'), // Set the font family for the app bar text
        ),
        centerTitle: true,
        // backgroundColor:
        //     Colors.transparent, // Make the app bar background transparent
        elevation: 0, // Remove the elevation shadow
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              // CircleAvatar(
              //   radius: 50,
              //   backgroundImage: const AssetImage(ImageUtils.icProfile),
              // ),
              CircleAvatar(
                radius: 50,
                child: ClipOval(
                  child: Image.network(ImageUtils.icProfile),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Pavan kumar',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'pavan@test.com',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Personal Information'),
                onTap: () {},
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Settings'),
                onTap: () {},
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
