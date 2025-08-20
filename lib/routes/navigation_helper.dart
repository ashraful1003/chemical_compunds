import 'package:flutter/material.dart';

class NavigationHelper {
  NavigationHelper._internal();

  static final NavigationHelper _instance = NavigationHelper._internal();

  factory NavigationHelper() => _instance;

  final GlobalKey<NavigatorState> parentNavigatorKey =
      GlobalKey<NavigatorState>();

  final Map<String, int> _routeInstanceCounts = <String, int>{};

  void _addInstanceCount(String routeName) {
    _routeInstanceCounts[routeName] =
        (_routeInstanceCounts[routeName] ?? 0) + 1;
  }

  void _removeInstanceCount(String routeName) {
    if (_routeInstanceCounts.containsKey(routeName)) {
      _routeInstanceCounts[routeName] =
          (_routeInstanceCounts[routeName] ?? 1) - 1;
      if (_routeInstanceCounts[routeName] == 0) {
        _routeInstanceCounts.remove(routeName);
      }
    }
  }

  void handlePush(String? routeName) {
    if (routeName == null) {
      return;
    }
    _addInstanceCount(routeName);
  }

  void handlePop(String? routeName) {
    if (routeName == null) {
      return;
    }
    _removeInstanceCount(routeName);
  }
}
