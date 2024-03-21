import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Orientation options
// Extend it and handle more options, if you need them
enum ScreenOrientation {
  portraitOnly,
  landscapeOnly,
  rotating,
}

// This function helps to build RouteSettings object for the orientation
RouteSettings rotationSettings(
    RouteSettings settings, ScreenOrientation rotation) {
  return RouteSettings(name: settings.name, arguments: rotation);
}

// NavigatorObserver which tracks the orientation
class NavigatorObserverWithOrientation extends NavigatorObserver {
  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    final routeName = previousRoute?.settings.name;

    if (routeName == null) {
      return;
    }

    if (routeName == '/') {
      _setOrientation(ScreenOrientation.portraitOnly);
      return;
    }

    _setOrientation(ScreenOrientation.portraitOnly);
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    final routeName = route.settings.name;

    if (routeName == '/') {
      _setOrientation(ScreenOrientation.portraitOnly);
      return;
    }

    _setOrientation(ScreenOrientation.portraitOnly);
  }
}

@override
void didReplace({Route? newRoute, Route? oldRoute}) {
  final routeName = newRoute?.settings.name;

  if (routeName == null) {
    return;
  }
  if (routeName == '/') {
    _setOrientation(ScreenOrientation.portraitOnly);
    return;
  }
}

// Set orientation
void _setOrientation(ScreenOrientation orientation) {
  List<DeviceOrientation> orientations;
  switch (orientation) {
    case ScreenOrientation.portraitOnly:
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
          overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
      SystemChrome.setSystemUIOverlayStyle(
          const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

      orientations = [
        DeviceOrientation.portraitUp,
      ];
      break;
    case ScreenOrientation.landscapeOnly:
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky,
          overlays: [SystemUiOverlay.top]);

      orientations = [
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ];
      break;
    case ScreenOrientation.rotating:
      orientations = [
        DeviceOrientation.portraitUp,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ];
      break;
  }
  SystemChrome.setPreferredOrientations(orientations);
}
