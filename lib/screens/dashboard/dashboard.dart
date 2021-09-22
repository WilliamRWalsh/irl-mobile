import 'package:flutter/material.dart';
import 'package:irl_mobile/firebase/calories_list_state.dart';
import 'package:irl_mobile/firebase/goal_state.dart';
import 'package:irl_mobile/screens/dashboard/local_widgets/add_calories_dialog.dart';
import 'package:irl_mobile/screens/dashboard/local_widgets/edit_goal_dialog.dart';
import 'package:irl_mobile/screens/dashboard/local_widgets/ledger.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (BuildContext context) => CaloriesListState(),
          ),
          ChangeNotifierProvider(
            create: (BuildContext context) => GoalState(),
          ),
        ],
        child: Builder(
          builder: (context) {
            final GoalState goalState = Provider.of(context);
            final CaloriesListState caloriesListState = Provider.of(
                context); // this needs to only be around remaining cals

            final int goal = goalState.goal?.calorieGoal ?? 0;
            final int calories = caloriesListState.calorieTotal ?? 0;
            final int remainingCalories = goal - calories;
            return Scaffold(
              resizeToAvoidBottomInset: false,
              body: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Container(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          flex: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Calorie Goal: ',
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              Text(
                                '$goal',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () => showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return EditGoalDialog();
                                      }),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.yellow,
                                    radius: 15,
                                    child: Icon(
                                      Icons.edit_rounded,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Text(
                            'Remaining Calories',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(decoration: TextDecoration.underline),
                          ),
                        ),
                        Flexible(
                          flex: 4,
                          child: Text(
                            "$remainingCalories",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .copyWith(fontSize: 100),
                          ),
                        ),
                        Flexible(
                          fit: FlexFit.tight,
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
              ),
            );
          },
        ),
      ),
    );
  }
}
