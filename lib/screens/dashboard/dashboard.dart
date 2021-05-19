import 'package:flutter/material.dart';
import './local_widgets/questList.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
            Flexible(
              flex: 1,
              child: FractionallySizedBox(
                widthFactor: 0.90,
                child: Placeholder(),
              ),
            ),
            Flexible(
              flex: 2,
              child: FractionallySizedBox(
                widthFactor: 0.90,
                child: Placeholder(),
              ),
            ),
            Flexible(
              flex: 1,
              child: FractionallySizedBox(
                widthFactor: 0.90,
                child: Placeholder(),
              ),
            ),
            Flexible(
              flex: 4,
              child: FractionallySizedBox(
                widthFactor: 0.90,
                child: QuestList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
