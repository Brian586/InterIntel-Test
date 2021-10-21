import 'package:flutter/material.dart';

class ErrorAlertDialog extends StatelessWidget
{
  final String? message;
  const ErrorAlertDialog({Key? key, this.message}) : super(key: key);

  // this widget displays errors

  @override
  Widget build(BuildContext context)
  {
    return AlertDialog(
      key: key,
      content: Text(message!),
      actions: <Widget>[
        TextButton(
          onPressed: ()=> Navigator.pop(context),
          child: const Text("OK", style: TextStyle(color: Colors.red),),
        )
      ],
    );
  }
}
