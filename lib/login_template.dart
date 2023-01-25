import 'package:shared_preferences/shared_preferences.dart';
import 'package:students_portal/constants.dart';
import 'package:students_portal/register.dart';
import 'package:students_portal/registered_classes.dart';

import 'my_attendance.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  bool validate = false;

  String loginMessage = "";
  bool loginFailed = false;
  bool loginSuccess = false;

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Student Login",
              style: TextStyle(color: Colors.white, fontSize: 35),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.1,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 45),
              child: TextField(
                controller: emailController,
                // textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintStyle: const TextStyle(
                    color: Color.fromARGB(255, 90, 104, 110),
                  ),
                  border: OutlineInputBorder(),
                  hintText: "Email",
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 45, vertical: 20),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                // textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintStyle: TextStyle(
                    color: Color.fromARGB(255, 90, 104, 110),
                  ),
                  border: OutlineInputBorder(),
                  hintText: 'Password',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.1),
              child: ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ))),
                onPressed: () async {
                  setState(() {
                    validate = true;
                    print(validate);
                  });

                  var url = Uri.parse(baseurl + studentLogin);
                  String email = emailController.text;
                  String password = passwordController.text;

                  if (email.isEmpty || password.isEmpty) {
                    setState(() {
                      validate = false;
                      loginMessage = "All fields required!";
                      loginFailed = true;
                    });
                  } else {
                    var response = await http.post(
                      url,
                      body: {"email": email, "password": password},
                    );
                    print(response.body);
                    if (response.statusCode == 200) {
                      setState(() {
                        loginFailed = false;
                        loginMessage = "Login Successful!";
                        loginSuccess = true;
                        validate = false;
                      });
                      await Future.delayed(Duration(seconds: 1));

                      final prefs = await SharedPreferences.getInstance();

                      String studentKey = response.body;

                      await prefs.setString('key', studentKey);

                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (_) => RegisteredClasses(
                                    studentKey: studentKey,
                                  )),
                          (route) => false);
                    } else {
                      setState(() {
                        loginMessage = "Login failed!";
                        validate = false;
                        loginFailed = true;
                      });
                    }
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "Login",
                    style: TextStyle(fontSize: 25),
                  ),
                ),
              ),
            ),
            if (validate) CircularProgressIndicator(),
            if (loginFailed)
              Text(
                loginMessage,
                style: TextStyle(color: Colors.red),
              ),
            if (loginSuccess)
              Text(
                loginMessage,
                style: TextStyle(color: Colors.green),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StudentRegister()),
                      );
                      // navigate(studentLogin: false);
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
