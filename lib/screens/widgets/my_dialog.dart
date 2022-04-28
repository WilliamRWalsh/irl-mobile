// @dart=2.12

import 'package:flutter/material.dart';

class MyDialog extends StatelessWidget {
  MyDialog({required this.title, required this.onConfirm});
  final String title;
  final Function onConfirm;
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return AlertDialog(
      backgroundColor: Theme.of(context).backgroundColor,
      contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      content: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.bodyText2,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                ),
                child: TextFormField(
                  controller: controller,
                  keyboardType: TextInputType.phone,
                  style: Theme.of(context).textTheme.bodyText2,
                  decoration: const InputDecoration(
                    fillColor: Colors.black,
                  ),
                  autofocus: true,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(120, 40),
                      // ignore: deprecated_member_use
                      primary: Theme.of(context).buttonColor,
                      onPrimary: Theme.of(context).primaryColorDark,
                      textStyle: Theme.of(context).textTheme.button,
                    ),
                    onPressed: () async {
                      _formKey.currentState?.save();
                      if (!(_formKey.currentState?.validate() ?? false)) {
                        return;
                      }
                      await onConfirm(controller.text);
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.check),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(120, 40),
                      // ignore: deprecated_member_use
                      primary: Theme.of(context).accentColor,
                      onPrimary: Theme.of(context).primaryColorDark,
                      textStyle: Theme.of(context).textTheme.button,
                    ),
                    onPressed: () async {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.close_outlined),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
