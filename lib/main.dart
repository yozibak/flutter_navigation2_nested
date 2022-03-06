import 'package:flutter/material.dart';
import 'package:nested_nav2/router_things/parser.dart';
import 'package:nested_nav2/router_things/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppRouteParser _parser = AppRouteParser();

  final GlobalRouterDelegate _delegate = GlobalRouterDelegate();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: _delegate,
      routeInformationParser: _parser,
    );
  }
}
