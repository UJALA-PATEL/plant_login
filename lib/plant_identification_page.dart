import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class PlantIdentificationPage extends StatefulWidget {
  @override
  _PlantIdentificationPageState createState() => _PlantIdentificationPageState();
}

class _PlantIdentificationPageState extends State<PlantIdentificationPage> {
  File? _selectedImage;
  String _plantName = "Unknown Plant"; // Default plant name

  final ImagePicker _picker = ImagePicker();

  // Function to pick image from Camera
  Future<void> _pickImageFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
        _identifyPlant(); // Dummy AI Model
      });
    }
  }

  // Function to pick image from Gallery
  Future<void> _pickImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
        _identifyPlant(); // Dummy AI Model
      });
    }
  }

  // Fake AI Model to Identify Plant
  void _identifyPlant() {
    List<String> plantList = [
      "Aloe Vera",
      "Snake Plant",
      "Money Plant",
      "Rose",
      "Basil",
      "Tulsi",
      "Cactus",
      "Unknown Plant"
    ];
    setState(() {
      _plantName = (plantList..shuffle()).first; // Random plant name
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Plant Identifier"),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _selectedImage == null
                ? Text(
              "No Image Selected",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            )
                : Image.file(_selectedImage!, height: 250), // Show Selected Image
            SizedBox(height: 20),
            Text(
              "Detected: $_plantName",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: _pickImageFromCamera,
                  icon: Icon(Icons.camera_alt),
                  label: Text("Camera"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                ),
                SizedBox(width: 20),
                ElevatedButton.icon(
                  onPressed: _pickImageFromGallery,
                  icon: Icon(Icons.photo_library),
                  label: Text("Gallery"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
