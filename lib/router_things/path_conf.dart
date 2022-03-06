abstract class PathConf {}

class FoodListPath extends PathConf {}

class SettingsPath extends PathConf {}

class FoodDetailPath extends PathConf {
  final int id;
  FoodDetailPath(this.id);
}
