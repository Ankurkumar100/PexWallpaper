class CategoryModel {
  String cateName;
  String cateImgUrl;

  CategoryModel({required this.cateImgUrl, required this.cateName});

  static CategoryModel fromApiApp(Map<String, dynamic> category) {
    return CategoryModel(
        cateImgUrl: category["imgUrl"], cateName: category["CategoryName"]);
  }
}
