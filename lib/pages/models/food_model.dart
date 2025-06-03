class FoodModel {
  final String name;
  final String imagePath;
  final double price;
  final double rating;

  FoodModel({
    required this.name,
    required this.imagePath,
    required this.price,
    required this.rating,
  });

  String get _name => name;
  String get _imagePath => imagePath;
  double get _price => price;
  double get _rating => rating;
}