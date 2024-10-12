import 'package:flutter/material.dart';
import 'package:food_advisor/features/Home/widgets/circle_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Black background
      body: Stack(
        children: [
          // Top-left circle
          const CircleWidget(
            top: -700,
            left: -50,
            size: 500,
            gradientColors: [Colors.orangeAccent, Colors.deepOrange],
          ),
          // Bottom-right circle
          const CircleWidget(
            bottom: -900,
            right: -100,
            size: 200,
            gradientColors: [Colors.orangeAccent, Colors.deepOrange],
          ),
          // Profile icon and app name
          Positioned(
            top: 30, // Position to appear on top of the circle
            left: 20,
            right: 20, // Use both left and right to align the elements
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.person,
                      color: Colors.white), // Profile icon
                  onPressed: () {
                    // Profile icon action
                  },
                ),
                const Text(
                  'FOOD-VISOR', // App name on top-right
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          // Center text "Hello, Username"
          const Positioned(
            top: 90, // Adjusted position to display "Hello" and "Username"
            left: 40,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello,',
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.black, // "Hello" in black color
                  ),
                ),
                SizedBox(height: 4), // Space between "Hello" and "Username"
                Text(
                  '\t\t\t\t\t\t\tKrishna',
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.w400,
                    color: Colors.white, // "Username" in white color
                  ),
                ),
                SizedBox(
                  height: 160,
                ),
                Text(
                  'Click the button to scan.',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w200,
                    color: Colors.white, // Text in white color
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding:
            const EdgeInsets.only(bottom: 30.0), // Adjust the padding as needed
        child: FloatingActionButton(
          backgroundColor: const Color.fromARGB(
              129, 255, 153, 0), // Floating action button with scanner icon
          child: const Icon(Icons.qr_code_scanner),
          onPressed: () {
            Navigator.pushNamed(context, '/scan'
                // Navigate to next screen
                );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
