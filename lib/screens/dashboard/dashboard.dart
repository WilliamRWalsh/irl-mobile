import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
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
                    "0",
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
                    child: Column(
                      children: [
                        SizedBox(
                          height: 40,
                          child: Text('+50'),
                        ),
                        SizedBox(
                          height: 40,
                          child: Text('+245'),
                        ),
                        SizedBox(
                          height: 40,
                          child: Text('+105'),
                        ),
                      ],
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
