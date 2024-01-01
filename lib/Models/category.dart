class Category{
  int categoryId;
  String categoryLabel;

  Category({required this.categoryId, required this.categoryLabel});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      categoryId: json['category_id'] as int,
      categoryLabel: json['category_label'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category_id': categoryId,
      'category_label': categoryLabel,
    };
  }





}