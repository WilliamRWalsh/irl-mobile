import 'package:flutter/material.dart';
import 'package:irl_mobile/models/cal_record_modal.dart';
import 'package:irl_mobile/screens/dashboard/local_widgets/ledger_card.dart';

class Dashboard extends StatelessWidget {
  final List<CalRecord> ledger = [
    CalRecord(calories: 210),
    CalRecord(calories: 360),
    CalRecord(calories: 100),
    CalRecord(calories: 50),
    CalRecord(calories: 85),
    CalRecord(calories: 310),
    CalRecord(calories: 20),
    CalRecord(calories: 10),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Container(
        child: Center(
          child: Column(
            children: [
              Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Text(
                    'Cal\'s Remaining'.toUpperCase(),
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Text(
                    "1425",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Text(
                    'Ledger',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ),
              ),
              Flexible(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: SingleChildScrollView(
                    child: Expanded(
                      child: Column(
                        children: [
                          for (var record in ledger) ...[
                            LedgerCard(
                              record: record,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                          ]
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(175, 50),
                  primary: Theme.of(context).buttonColor,
                  onPrimary: Theme.of(context).primaryColorDark,
                  textStyle: Theme.of(context).textTheme.button,
                ),
                onPressed: () async {},
                child: Text('Add Cal'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
