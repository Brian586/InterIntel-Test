import 'package:flutter/material.dart';

class RouterAnimation {
  Route animateToRoute(Widget newPage) {
    // This navigates to the next page with a fade animation
    return PageRouteBuilder(
      pageBuilder: (c, a1, a2) => newPage,
      transitionsBuilder: (c, anim, a2, child) =>
          FadeTransition(opacity: anim, child: child),
      transitionDuration: const Duration(milliseconds: 2000),
    );
  }

  Route popAnimateToRoute(Widget newPage) {
    // This navigates to the next page with a pop animation
    return PageRouteBuilder(
      pageBuilder: (c, a1, a2) => newPage,
      transitionsBuilder: (c, anim, a2, child) {
        anim = CurvedAnimation(parent: anim, curve: Curves.elasticInOut);

        return ScaleTransition(
          scale: anim,
          child: child,
          alignment: Alignment.center,
        );
      },
      transitionDuration: const Duration(milliseconds: 2000),
    );
  }
}
