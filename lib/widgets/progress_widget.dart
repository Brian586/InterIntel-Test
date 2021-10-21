import 'package:flutter/material.dart';
import 'package:interintel/config/app_config.dart';

circularProgress() {
  // This returns a circular progress indicator type
  return Container(
    alignment: Alignment.center,
    padding: const EdgeInsets.only(top: 12.0),
    child: const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(InterIntel.themeColor),),
  );
}

linearProgress() {
  // This returns a linear type progress indicator
  return Container(
    alignment: Alignment.center,
    padding: const EdgeInsets.only(top: 12.0),
    child: const LinearProgressIndicator(valueColor: AlwaysStoppedAnimation(InterIntel.themeColor),),
  );
}
