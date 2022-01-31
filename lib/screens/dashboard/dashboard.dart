import 'package:flutter/material.dart';
import 'package:slim_sams_cal_calc/firebase/calories_list_state.dart';
import 'package:slim_sams_cal_calc/firebase/goal_state.dart';
import 'package:slim_sams_cal_calc/screens/dashboard/home.dart';
import 'package:slim_sams_cal_calc/screens/dashboard/progress.dart';
import 'package:slim_sams_cal_calc/screens/dashboard/settings.dart';
import 'package:slim_sams_cal_calc/screens/login/login_state.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    final LoginState loginState = Provider.of(context);
    return SafeArea(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (BuildContext context) =>
                CaloriesListState(userID: loginState.user.uid),
          ),
          ChangeNotifierProvider(
            create: (BuildContext context) =>
                GoalState(userID: loginState.user.uid),
          ),
        ],
        child: Builder(
          builder: (context) {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              body: whichNavPage(),
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
                  BottomNavigationBarItem(
                    icon: Icon(Icons.settings),
                    label: 'Settings',
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

  Widget whichNavPage() {
    if (selectedIndex == 0) {
      return Progress();
    } else if (selectedIndex == 1) {
      return Home();
    } else if (selectedIndex == 2) {
      return Settings();
    }
    return null;
  }
}
