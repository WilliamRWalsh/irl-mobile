import 'package:flutter/material.dart';
import 'package:irl_mobile/firebase/calories_list_state.dart';
import 'package:irl_mobile/firebase/goal_state.dart';
import 'package:irl_mobile/screens/dashboard/home.dart';
import 'package:irl_mobile/screens/history/progress.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int selectedIndex = 1;

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
            return Scaffold(
              resizeToAvoidBottomInset: false,
              body: (selectedIndex == 1) ? Home() : Progress(),
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
                ],
                currentIndex: selectedIndex,
                selectedItemColor: Theme.of(context).primaryColor,
                unselectedItemColor: Colors.white,
                onTap: (int index) => setState(() {
                  selectedIndex = index;
                }),
              ),
            );
          },
        ),
      ),
    );
  }
}
