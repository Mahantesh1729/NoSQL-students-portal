import 'courses.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MyAttendance extends StatefulWidget {
  @override
  State<MyAttendance> createState() => _MyAttendanceState();
}

class _MyAttendanceState extends State<MyAttendance> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Attendance"),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  "Academic Year",
                  style: TextStyle(fontSize: 30),
                ),
              ),
              YearButton(
                year: "2019-20",
              ),
              YearButton(
                year: "2020-21",
              ),
              YearButton(
                year: "2021-22",
              ),
              YearButton(
                year: "2022-23",
              )
            ],
          ),
        ),
      ),
    );
  }
}

class YearButton extends StatelessWidget {
  String year;

  YearButton({required this.year});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Subjects(title: "Courses")),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(20),
              right: Radius.circular(20),
            ),
            color: Color.fromARGB(255, 201, 219, 235),
          ),
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.075,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(child: Text(year)),
          ),
        ),
      ),
    );
  }
}
