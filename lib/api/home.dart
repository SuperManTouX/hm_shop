import 'package:hm_shop/constants/index.dart';
import 'package:hm_shop/types/Home.dart';
import 'package:hm_shop/utils/index.dart';

Future<List<CarouselItem>> getBannerList() async {
  // 要手动转换为List类型，才能使用map函数
  return (await DioRequest().get(HttpConstants.BANNER_LIST) as List).map((
    item,
  ) {
    return CarouselItem.fromJSON(item);
  }).toList();
}

// 获取分类列表
Future<List<CategoryItem>> getCategoryList() async {
  // 要手动转换为List类型，才能使用map函数
  return (await DioRequest().get(HttpConstants.CATEGORY_LIST) as List).map((
    item,
  ) {
    return CategoryItem.fromJSON(item);
  }).toList();
}

// 特惠推荐
Future<SpecialOfferResult> getSpecialOffer() async {
  return SpecialOfferResult.fromJSON(
    await DioRequest().get(HttpConstants.PRODUCT_LIST),
  );
}
