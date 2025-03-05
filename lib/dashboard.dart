import 'package:flutter/material.dart';
import 'search_page.dart';
import 'voice_search_page.dart';
import 'camera_page.dart';
import 'reminder_page.dart';
import 'my_plant_page.dart';
import 'plant_identification_page.dart'; // Import Plant Identification Scanner Page
import 'setting_page.dart';
import 'profile_page.dart';
import 'home_page.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;

  // Pages list for bottom navigation
  final List<Widget> _pages = [
    HomeScreen(),
    MyPlantPage(),
    PlantIdentificationPage(), // Scanner Page
    SettingsPage(),
    UserProfileScreen(),
  ];

  // Function to update selected index
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _selectedIndex == 0 // ✅ Sirf Home page pe AppBar dikhayega
          ? AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
        title: Text(
          'Plant Care',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      )
          : null, // ✅ Baaki pages pe AppBar hata diya

      body: _pages[_selectedIndex], // ✅ Selected page show karega

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).bottomAppBarTheme.color, // ✅ Auto background
        selectedItemColor: Theme.of(context).colorScheme.secondary, // ✅ Auto selected color
        unselectedItemColor: Theme.of(context).colorScheme.onSurface, // ✅ Auto unselected color
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.local_florist), label: "My Plant"),
          BottomNavigationBarItem(icon: Icon(Icons.qr_code_scanner), label: "Scan"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
