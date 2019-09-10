import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback callback;
  final String actionText;

  CustomAlertDialog(this.title, this.content, this.callback,
      [this.actionText = "Reset"]);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        FlatButton(
          onPressed: callback,
          color: Colors.white,
          child: Text(
            actionText,
            style: TextStyle(color: Colors.redAccent),
          ),
        )
      ],
    );
  }
}
