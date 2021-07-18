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

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 1,
                child: Text(
                  'Cal\'s Remaining'.toUpperCase(),
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
              Flexible(
                flex: 4,
                child: Text(
                  "1425",
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
              Flexible(
                flex: 1,
                child: Text(
                  'Ledger',
                  style: Theme.of(context).textTheme.headline2,
                ),
              ),
              Flexible(
                flex: 8,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: SingleChildScrollView(
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
              Flexible(
                flex: 1,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(195, 80),
                    primary: Theme.of(context).buttonColor,
                    onPrimary: Theme.of(context).primaryColorDark,
                    textStyle: Theme.of(context).textTheme.button,
                  ),
                  onPressed: () => showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 0, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          content: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40),
                                  child: TextFormField(
                                    controller: TextEditingController(),
                                    keyboardType: TextInputType.phone,
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                    decoration: const InputDecoration(
                                      fillColor: Colors.black,
                                    ),
                                    autofocus: true,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: Size(150, 50),
                                      primary: Theme.of(context).buttonColor,
                                      onPrimary:
                                          Theme.of(context).primaryColorDark,
                                      textStyle:
                                          Theme.of(context).textTheme.button,
                                    ),
                                    onPressed: () async {
                                      _formKey.currentState.save();
                                      if (!_formKey.currentState.validate()) {
                                        return;
                                      }
                                    },
                                    child: Text('OK'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                  child: Text('Add Calories'),
                ),
              ),
              SizedBox(
                height: 14,
              )
            ],
          ),
        ),
      ),
    );
  }
}
