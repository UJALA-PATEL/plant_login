import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';
import 'camera_page.dart';
import 'reminder_page.dart';
import 'search_page.dart';
import 'voice_search_page.dart';
import 'CareRecommendationScreen.dart';
import 'community_page.dart';
import 'WeatherScreen.dart';
import 'PlantDiagnosisScreen.dart';
import 'GrowthTrackingScreen.dart';
import 'ARScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController(viewportFraction: 0.9);
  int _currentPage = 0;
  Timer? _sliderTimer;

  final List<String> imageList = [
    'assets/images/snakeplant.jpg',
    'assets/images/succulent.jpg',
    'assets/images/swisscheeseplant.jpg',
    'assets/images/aloevera.jpg',
    'assets/images/pothos.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _startImageSlider();
  }

  void _startImageSlider() {
    _sliderTimer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (_currentPage < imageList.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _sliderTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 🔹 Search Bar + Icons (Top Par La Diya)
            _buildSearchBar(context, isDarkMode),

            SizedBox(height: 10),

            // 🔹 "Plant Care" Text (Sirf Home Page Par)
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Plants",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black, // Adaptive color
                ),
              ),
            ),

            SizedBox(height: 16),

            // 🔹 Image Slider
            _buildImageSlider(),

            SizedBox(height: 16),

            // 🔹 Features Grid
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.3,
                children: [
                  _featureBox("Care Guide", Icons.eco, Colors.green, context, CareRecommendationScreen(), isDarkMode),
                  _featureBox("Community", Icons.people, Colors.blue, context, CommunityPage(), isDarkMode),
                  _featureBox("Weather", Icons.cloud, Colors.orange, context, WeatherScreen(), isDarkMode),
                  _featureBox("Plant Diagnosis", Icons.local_hospital, Colors.red, context, PlantDiagnosisScreen(), isDarkMode),
                  _featureBox("Growth Tracking", Icons.track_changes, Colors.purple, context, GrowthTrackingScreen(), isDarkMode),
                  _featureBox("AR View", Icons.view_in_ar, Colors.teal, context, ARScreen(), isDarkMode),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 SEARCH BAR + ICONS
  Widget _buildSearchBar(BuildContext context, bool isDarkMode) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage())),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.black54 : Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 6)],
              ),
              child: Row(
                children: [
                  Icon(Icons.search, color: isDarkMode ? Colors.white : Colors.black),
                  SizedBox(width: 10),
                  Text("Search...", style: TextStyle(color: isDarkMode ? Colors.white70 : Colors.grey, fontSize: 16)),
                ],
              ),
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.mic, color: Colors.green, size: 28),
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => VoiceSearchPage())),
        ),
        IconButton(
          icon: Icon(Icons.camera_alt, color: Colors.orange, size: 28),
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CameraPage())),
        ),
        IconButton(
          icon: Icon(Icons.notifications, color: Colors.red, size: 28),
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ReminderPage())),
        ),
      ],
    );
  }

  // 🔹 IMAGE SLIDER
  Widget _buildImageSlider() {
    return SizedBox(
      height: 180,
      child: PageView.builder(
        controller: _pageController,
        itemCount: imageList.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 6)],
              image: DecorationImage(image: AssetImage(imageList[index]), fit: BoxFit.cover),
            ),
          );
        },
      ),
    );
  }

  // 🔹 FEATURE BOX WITH ORIGINAL ICON COLORS
  Widget _featureBox(String title, IconData icon, Color iconColor, BuildContext context, Widget screen, bool isDarkMode) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 5, offset: Offset(0, 3))],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: iconColor, size: 36),
            SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black, // Fixed Syntax
              ),
            ),
          ],
        ),
      ),
    );
  }
}
