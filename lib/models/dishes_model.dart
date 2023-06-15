class DishesModel {
  int? id;
  String? name;
  int? price;
  int? weight;
  String? description;
  String? imageUrl;
  List<String>? tegs;

  DishesModel(
      {required this.id,
      required this.name,
      required this.price,
      required this.weight,
      required this.description,
      required this.imageUrl,
      required this.tegs});

  DishesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    weight = json['weight'];
    description = json['description'];
    imageUrl = json['image_url'];
    tegs = json['tegs'].cast<String>();
  }
}
