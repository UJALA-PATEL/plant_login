import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project/Screens/forgot.dart';
import 'package:project/Screens/hompage.dart';
import 'package:project/Screens/signup.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool isloading = false;

  Future<void> signIn() async {
    setState(() => isloading = true);
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text,
      );
      Get.offAll(Homepage());
    } on FirebaseAuthException catch (e) {
      String errorMessage = "An error occurred. Please try again.";

      switch (e.code) {
        case "invalid-email":
          errorMessage = "Invalid email format. Please check your email.";
          break;
        case "user-not-found":
          errorMessage = "No account found for this email. Please sign up.";
          break;
        case "wrong-password":
          errorMessage = "Incorrect password. Please try again.";
          break;
        case "user-disabled":
          errorMessage = "This account has been disabled. Contact support.";
          break;
        case "too-many-requests":
          errorMessage = "Too many login attempts. Try again later.";
          break;
      }

      Get.snackbar("Login Failed", errorMessage, snackPosition: SnackPosition.BOTTOM);
    } finally {
      setState(() => isloading = false);
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return;

      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      Get.offAll(Homepage());
    } catch (e) {
      Get.snackbar("Google Sign-In Failed", "Please try again: $e",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    return isloading
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: email,
              decoration: InputDecoration(hintText: 'Enter Email'),
            ),
            TextField(
              controller: password,
              obscureText: true,
              decoration: InputDecoration(hintText: 'Enter Password'),
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: signIn, child: Text("Login")),
            SizedBox(height: 10),
            ElevatedButton(
                onPressed: signInWithGoogle,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.login, color: Colors.white),
                    SizedBox(width: 10),
                    Text("Sign in with Google"),
                  ],
                )),
            SizedBox(height: 30),
            ElevatedButton(
                onPressed: () => Get.to(Signup()),
                child: Text("Register Now")),
            SizedBox(height: 30),
            ElevatedButton(
                onPressed: () => Get.to(Forgot()),
                child: Text("Forgot Password?")),
          ],
        ),
      ),
    );
  }
}