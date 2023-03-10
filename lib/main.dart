// import 'package:attendance/curve_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:students_portal/register.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:students_portal/registered_classes.dart';
import 'dart:async';

import 'login_template.dart';
import 'student_login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void getUserKey() async {
    final prefs = await SharedPreferences.getInstance();
    final String? userKey = prefs.getString('key');

    String userKey1 = "";

    if (userKey != null) {
      userKey1 = userKey;
      Timer(
          Duration(seconds: 3),
          () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      RegisteredClasses(studentKey: userKey1))));
    } else {
      Timer(
          Duration(seconds: 3),
          () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Home())));
    }
  }

  @override
  void initState() {
    super.initState();

    getUserKey();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 220,
              width: 220,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Text(
                "Attendance System \n  Students's Portal",
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 25,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Home extends StatelessWidget {
  Widget gradientButton(
      {required String name,
      required Function navigate,
      required bool studentLogin}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    Color(0xFF0D47A1),
                    Color(0xFF1976D2),
                    Color(0xFF42A5F5),
                  ],
                ),
              ),
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Color.fromARGB(255, 255, 255, 255),
              padding: const EdgeInsets.all(16.0),
              textStyle: const TextStyle(fontSize: 20),
            ),
            onPressed: () {
              navigate(studentLogin: studentLogin);
            },
            child: Text(name),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    void navigate({required bool studentLogin}) {
      Navigator.push(
        context,
        studentLogin
            ? MaterialPageRoute(builder: (context) => StudentLogin())
            : MaterialPageRoute(builder: (context) => StudentRegister()),
      );
    }

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 220,
              width: 220,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Text(
                "Attendance System \n  Students's Portal",
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 25,
                ),
              ),
            ),
            SizedBox(
              height: 60,
            ),
            gradientButton(
                name: "Student Login ", navigate: navigate, studentLogin: true),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "New to the portal, ",
                  style: TextStyle(color: Colors.white),
                ),
                TextButton(
                    onPressed: () {
                      navigate(studentLogin: false);
                    },
                    child: Text("Register here"))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
