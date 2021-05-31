import 'package:flutter/material.dart';
import 'package:irl_mobile/models/questModel.dart';
import 'package:irl_mobile/services/quests.dart';

class QuestList extends StatefulWidget {
  @override
  _QuestListState createState() => _QuestListState();
}

class _QuestListState extends State<QuestList> {
  Future<Quest> futureQuests;

  @override
  void initState() {
    super.initState();
    print('quests...');
    futureQuests = fetchQuests();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<Quest>(
            future: futureQuests,
            builder: (context, snapshot) {
              print(snapshot);
              if (snapshot.hasData) {
                return Text(snapshot.data.name);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
