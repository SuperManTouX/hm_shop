class CarouselItem {
  String id;
  String url;
  CarouselItem({required this.id, required this.url});
  factory CarouselItem.fromJSON(Map<String, dynamic> json) {
    // 别忘了空判断
    return CarouselItem(id: json["id"] ?? "", url: json["imgUrl"] ?? "");
  }
}

class CategoryItem {
  String id;
  String url;
  String name;
  List<CategoryItem>? children;
  Null goods = null;
  CategoryItem({
    required this.id,
    required this.url,
    required this.name,
    this.children,
  });
  factory CategoryItem.fromJSON(Map<String, dynamic> json) {
    // 别忘了空判断
    return CategoryItem(
      id: json["id"] ?? "",
      url: json["picture"] ?? "",
      name: json["name"] ?? "",
      children: json["children"] == null
          ? []
          : (json["children"] as List)
                .map((e) => CategoryItem.fromJSON(e))
                .toList(),
    );
  }
}
