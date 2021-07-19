import 'package:cloud_firestore/cloud_firestore.dart';
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

            return Ink(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(26),
                color: Colors.amber[300],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    children:
                        snapshot.data.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data = document.data();

                      return Column(
                        children: [
                          LedgerCard(
                            calories: Calories(
                              calories: data['calories'],
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          )
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
            );
          }),
    );
  }
}


// [
//                   for (var calories in caloriesList) ...[
//                     LedgerCard(
//                       calories: calories,
//                     ),
//                     SizedBox(
//                       height: 8,
//                     ),
//                   ]
//                 ]