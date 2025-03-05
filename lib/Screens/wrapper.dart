import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/Screens/hompage.dart';
import 'package:project/Screens/login.dart';
import 'package:project/Screens/verifyemail.dart';
import 'package:project/dashboard.dart';
class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context,snapshot){
            if(snapshot.hasData){
              print(snapshot.data);
              if(snapshot.data!.emailVerified){
                return DashboardPage();
              }else{
                return Verify();
              }
            }else{
              return Login();
            }
          }
      ),
    );
  }
}
