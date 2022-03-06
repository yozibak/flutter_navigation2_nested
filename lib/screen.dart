import 'package:flutter/material.dart';
import 'package:nested_nav2/models.dart';
import 'package:nested_nav2/router_things/app_state.dart';

class FadeAnimationPage extends Page {
  final Widget child;
  const FadeAnimationPage({LocalKey? key, required this.child})
      : super(key: key);

  @override
  Route createRoute(BuildContext context) {
    return PageRouteBuilder(
        settings: this,
        pageBuilder: (context, animation, animation2) {
          var curveTween = CurveTween(curve: Curves.easeIn);
          return FadeTransition(
            opacity: animation.drive(curveTween),
            child: child,
          );
        });
  }
}

class FoodListScreen extends StatelessWidget {
  final ValueChanged<Food> onTapped;
  const FoodListScreen({required this.onTapped, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        for (var food in foods)
          ListTile(
            title: Text(food.name),
            subtitle: Text('${food.kcal.toString()} kcal'),
            onTap: () => onTapped(food),
          )
      ],
    ));
  }
}

class FoodDetailScreen extends StatelessWidget {
  final Food food;
  const FoodDetailScreen(this.food, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                TextButton(
                  child: const Text('back'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                Text(food.name, style: Theme.of(context).textTheme.headline3),
                Text('${food.kcal.toString()} kcal',
                    style: Theme.of(context).textTheme.bodyText2),
              ],
            )));
  }
}

class SettingsScreen extends StatelessWidget {
  final VoidCallback logOut;
  const SettingsScreen({Key? key, required this.logOut}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(children: [
      const Text('Settings screen'),
      TextButton(
        child: const Text('log out'),
        onPressed: logOut,
      )
    ])));
  }
}
