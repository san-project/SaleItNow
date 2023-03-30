class CategoryModel {
  final String id;
  final String name;
  CategoryModel({required this.id, required this.name});

  CategoryModel.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        name = json['category'];
}
