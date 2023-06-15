class CategoriesModel {
  int? id;
  String? name;
  String? imageUrl;

  CategoriesModel(
      {required this.id, required this.name, required this.imageUrl});

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageUrl = json['image_url'];
  }
}
