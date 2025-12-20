import 'package:hm_shop/constants/index.dart';
import 'package:hm_shop/types/Home.dart';
import 'package:hm_shop/utils/DioRequest.dart';

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

// 热榜推荐
Future<SpecialOfferResult> getInVogue() async {
  return SpecialOfferResult.fromJSON(
    await DioRequest().get(HttpConstants.IN_VOGUE_LIST),
  );
}
// 一站式推荐，数据结构和热榜推荐相同
Future<SpecialOfferResult> getOneStop() async {
  return SpecialOfferResult.fromJSON(
    await DioRequest().get(HttpConstants.ONE_STOP_LIST),
  );
}

// 推荐列表
Future<List<GoodsDetailItem>> getRecommendListAPI(
  Map<String, dynamic> params,
) async {
  // 返回请求
  return ((await DioRequest().get(HttpConstants.RECOMMEND_LIST, params: params))
          as List)
      .map((item) {
        return GoodsDetailItem.formJSON(item as Map<String, dynamic>);
      })
      .toList();
}

