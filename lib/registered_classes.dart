import 'dart:io';

import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:students_portal/main.dart';
import 'dart:convert';

import 'constants.dart';

import 'package:http/http.dart' as http;

class RegisteredClasses extends StatefulWidget {
  RegisteredClasses({required this.studentKey});

  final String studentKey;

  @override
  State<RegisteredClasses> createState() => _RegisteredClassesState();
}

class _RegisteredClassesState extends State<RegisteredClasses> {
  var parsedJson;
  bool loading = true;

  Future<void> getClasses() async {
    var url = Uri.parse(baseurl + studentGetAttendance);

    String k = widget.studentKey.substring(1, widget.studentKey.length - 1);
    print(k);
    var response = await http.post(
      url,
      body: {"key": k},
    );
    print("hello");
    if (response.statusCode == 201) {
      print(response.statusCode);
      print(response.body);

      setState(() {
        loading = false;
      });
      if (response.body != "No courses Yet")
        parsedJson = jsonDecode(response.body);
      else
        parsedJson = [];
    } else {
      print(response.statusCode);
      print(response.body);
    }
    print(parsedJson["CourseAndAtttendances"]);
  }

  void responseBody() async {
    var url = Uri.parse(baseurl + studentGetAttendance);

    String k = widget.studentKey.substring(1, widget.studentKey.length - 1);

    var response = await http.post(
      url,
      body: {"key": k},
    );
    print("hello");
    if (response.statusCode == 201) {
      print(response.statusCode);
      print(response.body);

      setState(() {
        loading = false;
      });
      if (response.body != "No courses Yet")
        parsedJson = jsonDecode(response.body);
      else
        parsedJson = [];
    } else {
      print(response.statusCode);
      print(response.body);
    }
    print(parsedJson["CourseAndAtttendances"]);
  }

  @override
  void initState() {
    super.initState();
    responseBody();
  }

  List<String> images = [
    "https://media.istockphoto.com/id/1162337513/photo/school-supplies-border-against-white-background.jpg?s=170667a&w=0&k=20&c=pe0jcmBkYmrDxOMkTPEoRqP-RgOtDRrlpLW6Jvdv9xs=",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTM4J70kWDfTxbb4P_WNjvj6Ethr4Qcobcpxx3_DdsFb082OWxFeV_lyHtq6UemK3mBSY8&usqp=CAU",
    "https://i.pinimg.com/736x/af/9f/a8/af9fa80248793a4c95302a6426e656a2.jpg",
    "https://img.freepik.com/free-vector/back-school-background-with-empty-space_23-2148609200.jpg?w=2000",
    "https://static.vecteezy.com/system/resources/previews/005/964/667/original/welcome-back-to-school-background-template-school-supplies-on-white-background-vector.jpg",
    "https://c8.alamy.com/zooms/9/4bf27f42c0734108a7400d06f8f1066b/p7637d.jpg",
    "https://s3.envato.com/files/252564750/20180720-Capture0012.jpg",
    "https://img.freepik.com/free-photo/back-school-background-with-school-supplies-copy-space_23-2148958973.jpg?w=2000",
    "https://www.freevector.com/uploads/vector/preview/31305/Revision_Freevector_School-Stationary_Background_Mf0421-01.jpg"
  ];
  int length = 0;

  final classCodeController = TextEditingController();
  String errorMessage = "";
  bool error = false;
  bool success = false;
  bool formBuffering = false;

  @override
  Widget build(BuildContext context) {
    final List<GlobalKey<ExpansionTileCardState>> card = [
      new GlobalKey(),
      new GlobalKey(),
      new GlobalKey(),
      new GlobalKey(),
      new GlobalKey(),
      new GlobalKey(),
      new GlobalKey(),
      new GlobalKey(),
      new GlobalKey(),
      new GlobalKey(),
      new GlobalKey(),
      new GlobalKey(),
      new GlobalKey(),
      new GlobalKey(),
      new GlobalKey(),
      new GlobalKey(),
      new GlobalKey(),
      new GlobalKey(),
      new GlobalKey(),
      new GlobalKey(),
      new GlobalKey(),
      new GlobalKey(),
      new GlobalKey(),
      new GlobalKey(),
    ];
    int count = 0;
    Widget customeTile(GlobalKey<ExpansionTileCardState> card, String subject,
        String total, String attended, String attendance) {
      if (attendance.length > 5) attendance = attendance.substring(0, 4);

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
        child: ExpansionTileCard(
          key: card,
          leading: CircleAvatar(child: Text(subject[0] + subject[1])),
          title: Text(subject),
          subtitle: Text("Credits: 4"),
          children: <Widget>[
            Divider(
              thickness: 1.0,
              height: 1.0,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Column(
                  children: [
                    Text("Classes held: " +
                        total +
                        "\n" +
                        "Attended: " +
                        attended +
                        "\n" +
                        "Attendance%: " +
                        attendance),
                    TextButton(
                        onPressed: () async {
                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: const Text("Are You Sure?"),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(ctx).pop();
                                  },
                                  child: Text("No"),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    var url = Uri.parse(
                                        baseurl + studentDeleteCourse);

                                    String k = widget.studentKey.substring(
                                        1, widget.studentKey.length - 1);

                                    var response = await http.post(
                                      url,
                                      body: {"key": k, "courseName": subject},
                                    );

                                    print(response.body);
                                    print(response.statusCode);

                                    responseBody();
                                    Navigator.of(ctx).pop();
                                  },
                                  child: Text(
                                    "Yes",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        child: Text(
                          "Exit Course",
                          style: TextStyle(color: Colors.red),
                        ))
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    return WillPopScope(
      onWillPop: () async => exit(0),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            PopupMenuButton(
              // add icon, by default "3 dot" icon
              icon: Icon(
                Icons.more_vert,
                color: Colors.black,
              ),
              itemBuilder: (context) {
                return [
                  PopupMenuItem<int>(
                    value: 2,
                    child: TextButton(
                        onPressed: () async {
                          final prefs = await SharedPreferences.getInstance();

                          await prefs.remove('key');
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (_) => Home()),
                              (route) => false);
                        },
                        child: Text("Logout")),
                  ),
                ];
              },
            ),
          ],
          leading: const BackButton(
            color: Colors.black,
          ),
          centerTitle: true,
          toolbarHeight: MediaQuery.of(context).size.height * 0.15,
          title: Text(
            "My Classes",
            style: TextStyle(color: Colors.black),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: const DecorationImage(
                    image: NetworkImage(
                      "https://img.freepik.com/free-vector/green-sand-paper_53876-86281.jpg?w=2000",
                    ),
                    fit: BoxFit.fill)),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return StatefulBuilder(
                  builder: (context, setState) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AlertDialog(
                        title: Text(
                          "Join Classroom",
                          textAlign: TextAlign.center,
                        ),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                controller: classCodeController,
                                // textAlign: TextAlign.center,
                                decoration: const InputDecoration(
                                  hintStyle: TextStyle(
                                    color: Color.fromARGB(255, 90, 104, 110),
                                  ),
                                  border: OutlineInputBorder(),
                                  hintText: 'Class-Code',
                                ),
                              ),
                            ),
                            if (formBuffering)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircularProgressIndicator(),
                              ),
                            if (error)
                              Text(
                                errorMessage,
                                style: TextStyle(color: Colors.red),
                              ),
                            if (success)
                              Text(
                                "Successfully joined Class",
                                style: TextStyle(color: Colors.green),
                              )
                          ],
                        ),
                        actions: <Widget>[
                          ElevatedButton(
                            child: Text("Cancel"),
                            onPressed: () {
                              formBuffering = false;
                              error = false;
                              Navigator.of(context).pop();
                            },
                          ),
                          ElevatedButton(
                            child: Text("Join"),
                            onPressed: () async {
                              setState(() {
                                formBuffering = true;
                              });
                              if (classCodeController.text.isEmpty) {
                                setState(() {
                                  error = true;
                                  formBuffering = false;
                                  errorMessage = "Class-Code is Empty";
                                });
                              }
                              var url1 =
                                  Uri.parse(baseurl + studentRegisterCourse);

                              String k = widget.studentKey
                                  .substring(1, widget.studentKey.length - 1);

                              var response1 = await http.post(
                                url1,
                                body: {
                                  "key": k,
                                  "courseName": classCodeController.text
                                },
                              );
                              print("Hello");
                              print(response1.statusCode);
                              print(response1.body);
                              print("Hello World");
                              if (response1.statusCode == 201) {
                                if (response1.body ==
                                    "Course Already Exsiting") {
                                  setState(() {
                                    success = false;
                                    formBuffering = false;
                                    error = true;
                                    errorMessage = "You've already registerd!";
                                  });
                                }
                              } else if (response1.statusCode == 401) {
                                setState(() {
                                  error = true;
                                  formBuffering = false;
                                  errorMessage = response1.body;
                                });
                              } else if (response1.statusCode == 200) {
                                setState(() {
                                  error = false;
                                  formBuffering = false;
                                  success = true;
                                });
                              }
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            );
          },
          child: Icon(Icons.add),
        ),
        body: loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : RefreshIndicator(
                onRefresh: getClasses,
                child: parsedJson["CourseAndAtttendances"].length == 0
                    ? Stack(
                        children: [
                          ListView(),
                          Center(
                            child: Text("No Classes Created Yet!"),
                          ),
                        ],
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 15),
                        child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: ListView.builder(
                                itemCount:
                                    parsedJson["CourseAndAtttendances"].length,
                                itemBuilder: ((context, index) {
                                  return customeTile(
                                      card[index],
                                      parsedJson["CourseAndAtttendances"][index]
                                          ["name"],
                                      parsedJson["CourseAndAtttendances"][index]
                                              ["TotalClasses"]
                                          .toString(),
                                      parsedJson["CourseAndAtttendances"][index]
                                              ["AttendedClasses"]
                                          .toString(),
                                      parsedJson["CourseAndAtttendances"][index]
                                                  ["Attendancepercentage"] ==
                                              null
                                          ? "0"
                                          : parsedJson["CourseAndAtttendances"]
                                                      [index]
                                                  ["Attendancepercentage"]
                                              .toString());
                                }))),
                      ),
              ),
      ),
    );
  }
}
