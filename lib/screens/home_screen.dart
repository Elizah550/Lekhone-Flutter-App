import 'package:flutter/material.dart';
import 'package:Warehouse/screens/Appointments.dart';
import 'package:Warehouse/screens/Login.dart';
import 'package:Warehouse/screens/search_screen.dart';
import 'package:Warehouse/widgets/action_container_large.dart';
// Import the AppointmentsScreen

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static String routeName = 'HomeScreen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(
          child: Image.asset('assets/images/Rhenix_logo.png', height: 220),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          // IconButton(
          //   icon: Icon(Icons.book, color: Colors.red), // Add Appointments icon
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) =>
          //             AppointmentsScreen(), // Navigate to AppointmentsScreen
          //       ),
          //     );
          //   },
          // ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Colors.grey[100],
              child: IconButton(
                onPressed: () {
                  _showLogoutConfirmationDialog(
                      context); // Call the confirmation dialog function
                },
                icon: Icon(
                  Icons.logout,
                  color: Colors.grey[500],
                ),
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Row(
              children: [
                Expanded(
                  child: ActionContainerLarge(
                    img: 'assets/images/suv.png',
                    title: 'Ride',
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: ActionContainerLarge(
                    img: 'assets/images/box.png',
                    title: 'Package',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Row(
              children: [
                // Expanded(
                //   child: ActionContainerSmall(
                //     img: 'assets/images/car.png',
                //     title: 'Car',
                //   ),
                // ),
                SizedBox(width: 10),
                // Expanded(
                //   child: ActionContainerSmall(
                //     img: 'assets/images/train.png',
                //     title: 'Train',
                //   ),
                // ),
                SizedBox(width: 10),
                // Expanded(
                //   child: ActionContainerSmall(
                //     img: 'assets/images/bus.png',
                //     title: 'Bus',
                //   ),
                // ),
                SizedBox(width: 10),
                // Expanded(
                //   child: ActionContainerSmall(
                //     img: 'assets/images/car.png',
                //     title: 'Transit',
                //   ),
                // ),
              ],
            ),
            const SizedBox(height: 20),
            TextField(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SearchScreen(),
                    fullscreenDialog: true,
                  ),
                );
              },
              autofocus: false,
              showCursor: false,
              decoration: InputDecoration(
                hintText: 'Start your "Trip -01"',
                hintStyle: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 24,
                ),
                filled: true,
                fillColor: Colors.grey[200],
                border: InputBorder.none,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 150,
                  height: 150,
                  color: Colors.green, // Green square tile
                  child: const Icon(
                    Icons.traffic,
                    color: Colors.white,
                    size: 80,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AppointmentsScreen(),
                      ),
                    );
                  },
                  child: Container(
                    width: 150,
                    height: 150,
                    color: Colors.green, // Green square tile
                    child: const Icon(
                      Icons.alarm,
                      color: Colors.white,
                      size: 80,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 150,
                  height: 150,
                  color: Colors.green, // Green square tile
                  child: const Icon(
                    Icons.star,
                    color: Colors.white,
                  ),
                ),
                Container(
                  width: 150,
                  height: 150,
                  color: Colors.green, // Green square tile
                  child: const Icon(
                    Icons.star,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void _showLogoutConfirmationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Logout"),
        content: const Text("Are you sure you want to logout?"),
        actions: <Widget>[
          TextButton(
            child: const Text("No"),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
          ),
          TextButton(
            child: const Text("Yes"),
            onPressed: () {
              // Perform logout actions here, including disposing of user details.
              // For example, clear the user session or tokens.
              // Then, navigate to the login screen or any appropriate screen.
              // You might use Navigator.popUntil to clear the route stack.

              Navigator.pushNamedAndRemoveUntil(context, LoginScreen.routeName,
                  (route) => false); // Close the dialog
            },
          ),
        ],
      );
    },
  );
}
