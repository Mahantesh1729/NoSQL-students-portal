import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';

class Subjects extends StatefulWidget {
  String title;
  Subjects({required this.title});

  @override
  _SubjectsState createState() => _SubjectsState();
}

class _SubjectsState extends State<Subjects> {
  final GlobalKey<ExpansionTileCardState> cardA = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardB = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardC = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardD = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardE = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardF = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardG = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
    );

    Widget customeTile(GlobalKey<ExpansionTileCardState> card, String subject) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
        child: ExpansionTileCard(
          key: card,
          leading: CircleAvatar(child: Text(subject[0] + subject[1])),
          title: Text(subject),
          subtitle: Text("Credits: 4"),
          children: const <Widget>[
            Divider(
              thickness: 1.0,
              height: 1.0,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Text(
                  """Classes held: 25
Attended: 18
Attendance: 85%""",
                  // style: Theme.of(context)
                  //     .textTheme
                  //     .bodyText2!
                  //     .copyWith(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 202, 190, 190),
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 5,
          ),
          customeTile(cardA, "Data Structures"),
          customeTile(cardB, "Java Programming"),
          customeTile(cardC, "Operating Systems"),
          customeTile(cardD, "Computer Networks"),
          customeTile(cardE, "DBMS"),
          customeTile(cardF, "Cloud Computing"),
          customeTile(cardG, "Cryptography")
        ],
      ),
    );
  }
}
