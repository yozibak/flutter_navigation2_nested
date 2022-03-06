import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nested_nav2/models.dart';
import 'package:nested_nav2/router_things/app_state.dart';
import 'package:nested_nav2/router_things/path_conf.dart';
import 'package:nested_nav2/screen.dart';

class GlobalRouterDelegate extends RouterDelegate<PathConf>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<PathConf> {
  @override
  late final GlobalKey<NavigatorState> navigatorKey;

  GlobalAppState globalAppState = GlobalAppState();

  GlobalRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>() {
    globalAppState.addListener(notifyListeners);
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        MaterialPage(
            child: Container(
          color: Colors.white,
          child: TextButton(
            child: const Text('login'),
            onPressed: globalAppState.logIn,
          ),
        )),
        if (globalAppState.isLoggedIn)
          MaterialPage(
            child: AppTabs(globalAppState: globalAppState),
          ),
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }
        // exit app when user taps 'back button' on this level
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(configuration) async {}
}

class AppTabs extends StatefulWidget {
  GlobalAppState globalAppState;
  AppTabs({Key? key, required this.globalAppState}) : super(key: key);

  @override
  _AppTabsState createState() => _AppTabsState();
}

class _AppTabsState extends State<AppTabs> {
  int _selectedIndex = 0;
  late FoodTabState _foodTabState;
  late ChildBackButtonDispatcher _backButtonDispatcher;

  @override
  void initState() {
    super.initState();
    _foodTabState = FoodTabState();
    // add other tab state here
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _backButtonDispatcher = Router.of(context)
        .backButtonDispatcher!
        .createChildBackButtonDispatcher();
  }

  @override
  Widget build(BuildContext context) {
    _backButtonDispatcher.takePriority();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Nested Router Demo'),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: <Widget>[
          Router(
            routerDelegate: FoodRouterDelegate(foodTabState: _foodTabState),
            backButtonDispatcher: _backButtonDispatcher,
          ),
          SettingsScreen(logOut: widget.globalAppState.logOut),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'My Foods'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings')
        ],
        currentIndex: _selectedIndex,
        onTap: (idx) {
          setState(() {
            if (_selectedIndex != idx) {
              _selectedIndex = idx;
            } else {
              // go back to home when user tapped tab button again
              _foodTabState.unSelectFood();
            }
          });
        },
      ),
    );
  }
}

class FoodRouterDelegate extends RouterDelegate<PathConf>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<PathConf> {
  @override
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  FoodTabState foodTabState;
  FoodTabState get foodState => foodTabState;
  set foodState(FoodTabState value) {
    if (value == foodTabState) {
      return;
    }
    foodTabState = value;
    notifyListeners();
  }

  FoodRouterDelegate({required this.foodTabState});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        MaterialPage(
          child: FoodListScreen(
            onTapped: _handleFoodTapped,
            key: const ValueKey('foodTab'),
          ),
        ),
        if (foodState.selectedFood != null)
          MaterialPage(
            key: ValueKey(foodState.selectedFood!.name),
            child: FoodDetailScreen(foodState.selectedFood!),
          ),
      ],
      onPopPage: (route, result) {
        foodState.unSelectFood();
        notifyListeners();
        return route.didPop(result);
      },
    );
  }

  @override
  Future<void> setNewRoutePath(PathConf configuration) async {
    assert(false);
  }

  void _handleFoodTapped(Food food) {
    foodState.selectFood(food);
    notifyListeners();
  }
}
