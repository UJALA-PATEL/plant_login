import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:permission_handler/permission_handler.dart';

class VoiceSearchPage extends StatefulWidget {
  @override
  _VoiceSearchPageState createState() => _VoiceSearchPageState();
}

class _VoiceSearchPageState extends State<VoiceSearchPage> {
  stt.SpeechToText _speech = stt.SpeechToText();
  String _detectedText = "Press the mic to speak";
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    _requestPermission(); // ✅ Microphone Permission Request
    _speech = stt.SpeechToText();
  }

  // ✅ Microphone Permission Request Function
  void _requestPermission() async {
    var status = await Permission.microphone.request();

    if (status.isGranted) {
      print("✅ Microphone Permission Granted");
    } else if (status.isDenied) {
      print("❌ Microphone Permission Denied");
    } else if (status.isPermanentlyDenied) {
      print("⚠️ Permission permanently denied. Open settings.");
      await openAppSettings();
    }
  }

  void _startListening() async {
    bool available = await _speech.initialize(
      onStatus: (status) {
        print("🔄 Status: $status");
        if (status == "notListening") {
          setState(() {
            _isListening = false;
          });
        }
      },
      onError: (error) => print("❌ Error: $error"),
    );

    if (available) {
      setState(() {
        _isListening = true;
        _detectedText = "Listening...";
      });

      _speech.listen(
        onResult: (result) {
          setState(() {
            _detectedText = result.recognizedWords; // ✅ Jo bola wo likh diya
          });
        },
        listenFor: Duration(minutes: 1), // ✅ 1 minute tak sunega
        pauseFor: Duration(seconds: 3),  // ✅ 3 sec pause ke baad stop hoga
        partialResults: true,            // ✅ Live words update honge
        localeId: "en_US",               // ✅ Hindi ke liye "hi_IN", Urdu ke liye "ur_PK"
      );
    } else {
      setState(() {
        _detectedText = "Speech recognition not available";
      });
    }
  }

  void _stopListening() {
    _speech.stop().then((value) {
      setState(() {
        _isListening = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Voice Search"),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // **Detected Speech Text**
            Container(
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                _detectedText,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(height: 50),

            // **Microphone Button**
            GestureDetector(
              onTap: _isListening ? _stopListening : _startListening,
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: _isListening ? Colors.red : Colors.green,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.withOpacity(0.5),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Icon(
                  _isListening ? Icons.mic_off : Icons.mic,
                  color: Colors.white,
                  size: 50,
                ),
              ),
            ),
            SizedBox(height: 30),

            // **Instructions**
            Text(
              "Tap the microphone to start voice search",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
