import 'package:flutter/material.dart';
import 'package:irl_mobile/models/questsModel.dart';
import 'package:irl_mobile/services/quests.dart';

class QuestList extends StatefulWidget {
  @override
  _QuestListState createState() => _QuestListState();
}

class _QuestListState extends State<QuestList> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<Quests>(
        future: futureQuests,
        builder: (context, snapshot) {
          print(snapshot);
          if (snapshot.hasData) {
            return Text(snapshot.data.quests[0].name);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          // By default, show a loading spinner.
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
