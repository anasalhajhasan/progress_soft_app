import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

///check if we can pop back
bool navigationCanPop({required BuildContext context}) =>
    Navigator.of(context).canPop();

///go back to previous screen
goBack({required BuildContext context}) {
  if (navigationCanPop(context: context)) Navigator.pop(context);
}

///go back with arguments to previous screen
goBackWithArguments({required BuildContext context, dynamic arguments}) {
  if (navigationCanPop(context: context)) Navigator.pop(context, arguments);
}

/// navigate to new screen named
navigatePushNamed({
  required BuildContext context,
  required String pageName,
  arguments,
}) =>
    Navigator.pushNamed(context, pageName, arguments: arguments);

/// navigate to new screen replacing current one named
navigatePushReplacementNamed({
  required BuildContext context,
  required String pageName,
  arguments,
}) =>
    Navigator.of(context).pushReplacementNamed(pageName, arguments: arguments);

/// navigate to new screen replacing and removing until one named
navigatePushRemUntilNamedArguments({
  required BuildContext context,
  required String pageName,
  arguments,
}) =>
    Navigator.of(context).pushNamedAndRemoveUntil(
      pageName,
      (Route<dynamic> route) => false,
      arguments: arguments,
    );

/// navigate to new screen removing all behind named
navigatePopUntilNamed({
  required BuildContext context,
  required String pageName,
}) =>
    Navigator.of(context).popUntil(ModalRoute.withName(pageName));

/// navigate to new screen
navigatePush({required BuildContext context, required Widget pageName}) =>
    Navigator.push(
      context,
      MaterialPageRoute(builder: (BuildContext context) => pageName),
    );

/// navigate to new screen with replacement
navigateWithReplacement({
  required BuildContext context,
  required Widget pageName,
}) =>
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (BuildContext context) => pageName),
    );

/// navigate to new screen with replacement
navigatePushAndRemoveUntil({
  required BuildContext context,
  required Widget pageName,
}) =>
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (BuildContext context) => pageName),
    );

/// navigate to first screen in route
navigateToFirstRoute({required BuildContext context}) =>
    Navigator.of(context).popUntil((Route route) => route.isFirst);
