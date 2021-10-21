
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:interintel/widgets/progress_widget.dart';

class LoadingAlertDialog extends StatelessWidget {
  final String? message;
  const LoadingAlertDialog({Key? key, this.message}) : super(key: key);

  // This widget displays loading progress
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: key,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          circularProgress(),
          const SizedBox(
            height: 10,
          ),
          Text(message!),
        ],
      ),
    );
  }
}
