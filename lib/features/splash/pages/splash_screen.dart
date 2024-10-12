import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // Controller for PageView
  PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            children: <Widget>[
              // First Splash Page
              _buildSplashPage(
                context,
                'assets/home.png', // Image for the first page
                'Welcome to \n Food Visor',
                'Ingredient insights at your fingertips',
              ),
              // Second Splash Page
              _buildSplashPage(
                context,
                'assets/home.png', // Image for the second page
                'Make right choices on what to eat.',
                'Easily scan the ingredients of the food you are about to eat.',
              ),
              // Third Splash Page
              _buildSplashPageWithButton(
                context,
                'assets/home.png', // Image for the third page
                'Let\'s Get Started!',
                'Pick that pack up.....',
              ),
            ],
          ),

          // Back and Next Button at the bottom corners
          Positioned(
            bottom: 20,
            left: 20,
            child: _currentPage > 0
                ? IconButton(
                    onPressed: () {
                      _pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      // Use MaterialIcons for back arrow
                      color: Color.fromARGB(255, 226, 157, 9),
                    ),
                  )
                : Container(), // No "Back" button on the first page
          ),
          Positioned(
              bottom: 20,
              right: 20,
              child: _currentPage < 2
                  ? IconButton(
                      onPressed: () {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                        );
                      },
                      icon: const Icon(
                        Icons
                            .arrow_forward_ios, // Use MaterialIcons for forward arrow
                        color: Color.fromARGB(255, 226, 157, 9),
                      ),
                    )
                  : Container() // No "Next" button on the last page
              ),
        ],
      ),
    );
  }

  // Common method for the first two splash pages
  Widget _buildSplashPage(
    BuildContext context,
    String imagePath,
    String title,
    String subtitle,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(imagePath, height: 300, width: 300), // Splash image
        const SizedBox(height: 20),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 40, fontWeight: FontWeight.w400, color: Colors.orange),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  // Third splash page with "Get Started" button
  Widget _buildSplashPageWithButton(
    BuildContext context,
    String imagePath,
    String title,
    String subtitle,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(imagePath, height: 300, width: 300), // Splash image
        const SizedBox(height: 20),
        Text(
          title,
          style: const TextStyle(
              fontSize: 34, fontWeight: FontWeight.bold, color: Colors.orange),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/home');
          },
          child: const Text('Get Started'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange, // Background color
            foregroundColor: Colors.white, // Text color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30), // Border radius
            ),
          ),
        ),
      ],
    );
  }
}
