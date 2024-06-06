import 'package:flutter/material.dart';

class NavigatorUtil {
  static Future<T?> navigateScreen<T extends Object?>(
      BuildContext context, Widget screen) async {
    return await Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return screen;
        },
        transitionsBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation, Widget child) {
          return Align(
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
          );
        },
      ),
    );
  }

  static Future<void> replaceScreen(BuildContext context, Widget screen) async {
    // while (Navigator.canPop(context)) {
    //   Navigator.pop(context);
    // }
    await Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  static pushAndRemoveUntil(BuildContext context, Widget screen) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => screen),
        ModalRoute.withName("/Home"));
  }

  static replaceAllScreen(BuildContext context, Widget screen) {
    while (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }
}
