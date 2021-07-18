import 'package:flutter/material.dart';
import 'package:irl_mobile/screens/dashboard/local_widgets/add_calories_dialog.dart';
import 'package:irl_mobile/screens/dashboard/local_widgets/ledger.dart';

class Dashboard extends StatelessWidget {
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
                child: Ledger(),
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
                        return AddCaloriesDialog();
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
