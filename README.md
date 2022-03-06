# flutter_navigation2_nested
Small working demo for nested router with Navigation2.0 in Flutter

## How this works

https://user-images.githubusercontent.com/58211188/156921765-48211978-a4c5-44c3-bf36-82d201eadb53.mov

Not users can switch tabs and its tab states are not lost.

In concept this structure has 2 AppState managers:
- the AppGlobalState (which handles login/logout)
- the TabState (which handles local 'within' tab state, so users can explore within its tab while holding other tabs' state)

Looks like:
```
App (**GlobalAppState**, GlobalRouterDelegate)
 | - Login
 | - AppTabs (IndexedStack)
    | - Food Tab (**FoodTabState**, FoodTabRouterDelegate)
    | - Settings Tab
```

## TODO
- Try connecting with Riverpod provider for appState Manager
