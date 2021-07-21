import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:irl_mobile/firebase/calories_list_state.dart';
import 'package:irl_mobile/models/calories_modal.dart';
import 'package:irl_mobile/screens/dashboard/local_widgets/ledger_card.dart';
import 'package:provider/provider.dart';

class Ledger extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CaloriesListState caloriesListState = Provider.of(context);
    return Padding(
      padding: EdgeInsets.only(bottom: 12.0),
      child: StreamBuilder<QuerySnapshot>(
          stream: caloriesListState.caloriesStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading...");
            }

            final totalCalories = caloriesListState.calorieTotal ?? 0;
            return Stack(
              fit: StackFit.passthrough,
              alignment: Alignment.bottomCenter,
              children: [
                Positioned(
                  child: Ink(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(26),
                      color: Colors.blue[200],
                    ),
                    child: SizedBox(
                      width: 332,
                      height: 50,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
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
                ),
                Positioned(
                  top: 0,
                  bottom: 45,
                  child: Ink(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(26),
                      color: Colors.black,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SingleChildScrollView(
                          child: caloriesListState.caloriesList != null
                              ? Column(
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
                                )
                              : null),
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
