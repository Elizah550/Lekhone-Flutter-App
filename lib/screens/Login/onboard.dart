import 'package:Lekhone/Rider/Login.dart';
import 'package:Lekhone/screens/Login/Login.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Onboarding Screen'),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/box.png', // Replace with your image asset path
              height: 150,
              width: 150,
            ),
            SizedBox(height: 20),
            Text(
              'Welcome to Our App!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Experience the joy of doorstep deliveries with our app. '
              'Effortlessly order your favorite meals, groceries, and more, '
              'and have them delivered to your door in no time. '
              'Discover the convenience that fits your lifestyle!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),

            // Text(
            //   'Explore the features and benefits of our app. '
            //   'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
            //   'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
            //   textAlign: TextAlign.center,
            //   style: TextStyle(fontSize: 16),
            // ),
            SizedBox(height: 250),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    );
                    // Handle Consumer button press
                    print('Consumer button pressed');
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10.0), // Adjust the radius as needed
                    ),
                  ),
                  child: Text('Consumer'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    // Handle Employee button press
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RiderLoginScreen(),
                      ),
                    );
                    print('Employee button pressed');
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10.0), // Adjust the radius as needed
                    ),
                  ),
                  child: Text('Employee'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
