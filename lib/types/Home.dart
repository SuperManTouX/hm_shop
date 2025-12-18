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

// 特惠推荐相关类型
class SpecialOfferResult {
  String id;
  String title;
  List<SubType> subTypes;

  SpecialOfferResult({
    required this.id,
    required this.title,
    required this.subTypes,
  });

  factory SpecialOfferResult.fromJSON(Map<String, dynamic> json) {
    return SpecialOfferResult(
      id: json["id"] ?? "",
      title: json["title"] ?? "",
      subTypes: json["subTypes"] == null
          ? []
          : (json["subTypes"] as List).map((e) => SubType.fromJSON(e)).toList(),
    );
  }
}

class SubType {
  String id;
  String title;
  GoodsItems goodsItems;

  SubType({required this.id, required this.title, required this.goodsItems});

  factory SubType.fromJSON(Map<String, dynamic> json) {
    return SubType(
      id: json["id"] ?? "",
      title: json["title"] ?? "",
      goodsItems: GoodsItems.fromJSON(json["goodsItems"] ?? {}),
    );
  }
}

class GoodsItems {
  int counts;
  int pageSize;
  int pages;
  int page;
  List<GoodsItem> items;

  GoodsItems({
    required this.counts,
    required this.pageSize,
    required this.pages,
    required this.page,
    required this.items,
  });

  factory GoodsItems.fromJSON(Map<String, dynamic> json) {
    return GoodsItems(
      counts: json["counts"] ?? 0,
      pageSize: json["pageSize"] ?? 0,
      pages: json["pages"] ?? 0,
      page: json["page"] ?? 0,
      items: json["items"] == null
          ? []
          : (json["items"] as List).map((e) => GoodsItem.fromJSON(e)).toList(),
    );
  }
}

class GoodsItem {
  String id;
  String name;
  String? desc;
  String price;
  String picture;
  int orderNum;

  GoodsItem({
    required this.id,
    required this.name,
    this.desc,
    required this.price,
    required this.picture,
    required this.orderNum,
  });

  factory GoodsItem.fromJSON(Map<String, dynamic> json) {
    return GoodsItem(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      desc: json["desc"],
      price: json["price"] ?? "",
      picture: json["picture"] ?? "",
      orderNum: json["orderNum"] ?? 0,
    );
  }
}
