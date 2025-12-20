import 'package:hm_shop/constants/index.dart';
import 'package:hm_shop/types/Home.dart';
import 'package:hm_shop/utils/DioRequest.dart';

// 猜你喜欢列表
Future<GoodsDetailItems> getGuessLikeListAPI(
  Map<String, dynamic> params,
) async {
  // 返回请求
  return GoodsDetailItems.fromJSON(
    await DioRequest().get(HttpConstants.GUESS_LIKE_LIST, params: params),
  );
}
