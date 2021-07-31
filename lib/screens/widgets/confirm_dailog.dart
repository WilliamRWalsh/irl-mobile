import 'package:flutter/material.dart';

class ConfirmDialog extends StatelessWidget {
  ConfirmDialog({key, @required this.widget}) : super(key: key);
  Widget widget;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).backgroundColor,
      contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      content: Padding(
        padding: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Are you sure you want to delete?",
              style: Theme.of(context).textTheme.bodyText2,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 30,
            ),
            widget,
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(120, 40),
                      primary: Theme.of(context).buttonColor,
                      onPrimary: Theme.of(context).primaryColorDark,
                      textStyle: Theme.of(context).textTheme.button,
                    ),
                    onPressed: () => Navigator.pop<bool>(context, true),
                    child: Text('Yes')),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(120, 40),
                      primary: Theme.of(context).accentColor,
                      onPrimary: Theme.of(context).primaryColorDark,
                      textStyle: Theme.of(context).textTheme.button,
                    ),
                    onPressed: () => Navigator.pop<bool>(context, false),
                    child: Text('No'))
              ],
            )
          ],
        ),
      ),
    );
  }
}
