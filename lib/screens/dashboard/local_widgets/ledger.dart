import 'package:flutter/material.dart';
import 'package:slim_sams_cal_calc/firebase/calories_list_state.dart';
import 'package:slim_sams_cal_calc/models/calories_modal.dart';
import 'package:slim_sams_cal_calc/screens/dashboard/local_widgets/ledger_card.dart';
import 'package:provider/provider.dart';

class Ledger extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CaloriesListState caloriesListState = Provider.of(context);
    final totalCalories = caloriesListState.calorieTotal ?? 0;

    return Padding(
      padding: EdgeInsets.only(bottom: 12.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Stack(
          fit: StackFit.passthrough,
          alignment: Alignment.bottomCenter,
          children: [
            Positioned(
              child: Ink(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(26),
                  color: Colors.blue[200],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    bottom: 2.0,
                  ),
                  child: Align(
                    child: Text(
                      'Total: $totalCalories',
                      style: TextStyle(color: Colors.black, fontSize: 36),
                    ),
                    alignment: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              bottom: 45,
              left: 0,
              right: 0,
              child: Ink(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(26),
                  color: Colors.black,
                ),
                child: caloriesListState.caloriesList != null
                    ? Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: caloriesListState.caloriesList.isEmpty
                            ? Text(
                                'Today\'s ledger is empty.',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline3
                                    .copyWith(color: Colors.white),
                                textAlign: TextAlign.center,
                              )
                            : SingleChildScrollView(
                                reverse: true,
                                child: Column(
                                  children: caloriesListState.caloriesList
                                      .map((CaloriesModel calories) {
                                    return Column(
                                      children: [
                                        LedgerCard(
                                          calories: calories,
                                        ),
                                        SizedBox(
                                          height: 8,
                                        )
                                      ],
                                    );
                                  }).toList(),
                                )),
                      )
                    : Center(child: CircularProgressIndicator()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
