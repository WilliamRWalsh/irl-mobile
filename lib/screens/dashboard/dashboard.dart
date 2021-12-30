import 'package:flutter/material.dart';
import 'package:irl_mobile/firebase/calories_list_state.dart';
import 'package:irl_mobile/firebase/goal_state.dart';
import 'package:irl_mobile/screens/dashboard/home.dart';
import 'package:irl_mobile/screens/dashboard/local_widgets/add_calories_dialog.dart';
import 'package:irl_mobile/screens/dashboard/local_widgets/edit_goal_dialog.dart';
import 'package:irl_mobile/screens/dashboard/local_widgets/ledger.dart';
import 'package:irl_mobile/screens/history/history.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int selectedIndex = 1;
  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
    if (index == 0) {
      // Navigator.pushNamed(context, '/history');
      // Navigator.push(
      //   context,
      //   PageTransition(
      //     type: PageTransitionType.leftToRight,
      //     child: History(),
      //   ),
      // );
    }
  }

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
              body: (selectedIndex == 1) ? Home() : History(),

              //  Navigator(
              //   onGenerateRoute: (settings) {
              //     Widget page = Home();
              //     if (settings.name == '/history') page = History();
              //     return MaterialPageRoute(builder: (_) => page);
              //   },
              // ),
              bottomNavigationBar: BottomNavigationBar(
                backgroundColor: Colors.black,
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.auto_graph),
                    label: 'Progress',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  // BottomNavigationBarItem(
                  //   icon: Icon(Icons.settings),
                  //   label: 'Settings',
                  // ),
                ],
                currentIndex: selectedIndex,
                selectedItemColor: Theme.of(context).primaryColor,
                unselectedItemColor: Colors.white,
                onTap: _onItemTapped,
              ),
            );
          },
        ),
      ),
    );
  }
}
