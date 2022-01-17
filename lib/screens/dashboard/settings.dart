// @dart=2.12

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  Settings();

  bool sendNotifications = true;

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Settings'),
        FutureBuilder<SharedPreferences>(
            future: getSharedPrefs(),
            builder: (BuildContext context,
                AsyncSnapshot<SharedPreferences> snapshot) {
              if (snapshot.connectionState.index == 1) {
                return SizedBox();
              }
              return Switch(
                activeTrackColor: Colors.blue[200],
                activeColor: Colors.blue,
                value: snapshot.data?.getBool('sendNotifications') ?? true,
                onChanged: (bool val) {
                  snapshot.data?.setBool('sendNotifications', val);
                  setState(() {
                    widget.sendNotifications = val;
                  });
                },
              );
            })
      ],
    );
  }

  Future<SharedPreferences> getSharedPrefs() async {
    return await SharedPreferences.getInstance();
  }
}
