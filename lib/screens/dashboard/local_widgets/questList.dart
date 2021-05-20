import 'package:flutter/material.dart';

class QuestList extends StatefulWidget {
  @override
  _QuestListState createState() => _QuestListState();
}

class _QuestListState extends State<QuestList> {
  final _quests = [
    {'id': 1, 'name': 'Practice Skill', 'xp': 100, 'rarity': 0},
    {'id': 1, 'name': 'Learn', 'xp': 100, 'rarity': 0},
    {'id': 1, 'name': 'Calm Your Mind', 'xp': 100, 'rarity': 0},
    {'id': 1, 'name': 'Run!', 'xp': 100, 'rarity': 0},
    {'id': 1, 'name': 'Practice', 'xp': 100, 'rarity': 0},
    {'id': 1, 'name': 'Practice', 'xp': 100, 'rarity': 0}
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
      child: ListView.separated(
        itemCount: _quests.length,
        separatorBuilder: (context, index) => Container(
          height: 10,
        ),
        itemBuilder: (context, index) => Center(
          child: Container(
            height: 100,
            color: Colors.blue[100],
            child: Center(child: Text('${_quests[index]['name']}')),
          ),
        ),
      ),
    );
  }
}
