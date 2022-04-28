// @dart=2.12

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  Settings();

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool sendNotifications = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Center(child: Text('Settings')),
          FutureBuilder<SharedPreferences>(
              future: getSharedPrefs(),
              builder: (BuildContext context,
                  AsyncSnapshot<SharedPreferences> snapshot) {
                if (snapshot.connectionState.index == 1) {
                  return SizedBox();
                }
                return Row(
                  children: [
                    Switch(
                      activeTrackColor: Colors.blue[200],
                      activeColor: Colors.blue,
                      value:
                          snapshot.data?.getBool('sendNotifications') ?? true,
                      onChanged: (bool val) {
                        snapshot.data?.setBool('sendNotifications', val);
                        setState(() {
                          sendNotifications = val;
                        });
                      },
                    ),
                    Text(
                      'Send daily reminder',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ],
                );
              })
        ],
      ),
    );
  }

  Future<SharedPreferences> getSharedPrefs() async {
    return await SharedPreferences.getInstance();
  }
}
