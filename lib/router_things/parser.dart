import 'package:flutter/material.dart';
import 'package:nested_nav2/router_things/path_conf.dart';

class AppRouteParser extends RouteInformationParser<PathConf> {
  @override
  Future<PathConf> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location!);

    if (uri.pathSegments.isNotEmpty && uri.pathSegments.first == 'settings') {
      return SettingsPath();
    } else {
      if (uri.pathSegments.length >= 2) {
        final fid = int.tryParse(uri.pathSegments[1]);
        if (uri.pathSegments[0] == 'food' && fid != null) {
          return FoodDetailPath(fid);
        }
      }
      return FoodListPath();
    }
  }

  @override
  RouteInformation restoreRouteInformation(PathConf configuration) {
    if (configuration is SettingsPath) {
      return const RouteInformation(location: '/settings');
    } else if (configuration is FoodDetailPath) {
      return RouteInformation(location: '/food/${configuration.id}');
    } else {
      return const RouteInformation(location: '/home');
    }
  }
}
