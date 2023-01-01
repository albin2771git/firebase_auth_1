import 'package:firebase_auth_1/authentication.dart';
import 'package:firebase_auth_1/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
        child: Text('Welcome'),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AuthenticationHelper().signOut().then((_) =>
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginScreen())));
        },
        child: Icon(Icons.logout),
        tooltip: 'Logout',
      ),
    );
  }
}
