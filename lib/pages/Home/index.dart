import 'package:flutter/material.dart';
import 'package:hm_shop/api/home.dart';
import 'package:hm_shop/components/Home/HmSuggestion.dart';
import 'package:hm_shop/components/Home/HmCategory.dart';
import 'package:hm_shop/components/Home/HmHot.dart';
import 'package:hm_shop/components/Home/HmMoreList.dart';
import 'package:hm_shop/components/Home/HmSlider.dart';
import 'package:hm_shop/types/Home.dart';
import 'package:hm_shop/utils/ToastUtils.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<CarouselItem> _bannerList = [
    // CarouselItem(
    //   id: "1",
    //   url: "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meituan/1.jpg",
    // ),
    // CarouselItem(
    //   id: "2",
    //   url: "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meituan/2.jpg",
    // ),
    // CarouselItem(
    //   id: "3",
    //   url: "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meituan/3.jpg",
    // ),
  ];
  List<CategoryItem> _categoryList = [];
  SpecialOfferResult _specialOfferResult = SpecialOfferResult(
    id: "",
    title: "",
    subTypes: [],
  );
  // 热榜推荐数据
  SpecialOfferResult _inVogueResult = SpecialOfferResult(
    id: "",
    title: "",
    subTypes: [],
  );
  // 一站式推荐数据
  SpecialOfferResult _oneStopResult = SpecialOfferResult(
    id: "",
    title: "",
    subTypes: [],
  );

  // 推荐列表
  List<GoodDetailItem> _recommendList = [];

  // 滚动控制器
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    //initState执行时Build方法还没有执行，所以创建微任务延迟执行
    Future.microtask(() {
      paddingTop = 100;
      _refreshIndicatorKey.currentState?.show();
    });
    _addScrollEvent();
  }

  Future<void> _getBannerList() async {
    _bannerList = await getBannerList();
  }

  // 获取分类列表
  Future<void> _getCategoryList() async {
    _categoryList = await getCategoryList();
  }

  // 特惠推荐
  Future<void> _getSpecialOffer() async {
    _specialOfferResult = await getSpecialOffer();
  }

  // 热榜推荐
  Future<void> _getInVogue() async {
    _inVogueResult = await getInVogue();
  }

  // 一站式推荐
  Future<void> _getOneStop() async {
    _oneStopResult = await getOneStop();
  }

  // 获取推荐列表
  Future<void> _getRecommendList() async {
    _recommendList = await getRecommendListAPI({"limit": 10});
  }

  List<Widget> getScrollChildren() {
    return [
      SliverToBoxAdapter(child: HmSlider(bannerList: _bannerList)),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      SliverToBoxAdapter(child: HmCategory(categoryList: _categoryList)),
      SliverToBoxAdapter(child: SizedBox(height: 10)),

      SliverToBoxAdapter(
        child: HmSuggestion(specialOfferResult: _specialOfferResult),
      ),
      SliverToBoxAdapter(child: SizedBox(height: 10)),

      SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 10),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                child: HmHot(HotData: _inVogueResult, cardType: 'inVogue'),
              ),
              SizedBox(width: 10),
              Expanded(
                child: HmHot(HotData: _oneStopResult, cardType: 'oneStop'),
              ),
            ],
          ),
        ),
      ),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      HmMoreList(recommendList: _recommendList),
    ];
  }

  bool isLoading = false;
  int page = 1;
  // 添加滚动事件
  _addScrollEvent() {
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 50) {
        if (isLoading) {
          return;
        }
        isLoading = true;
        ToastUtils.showSuccess(context, "加载中");
        _recommendList = await getRecommendListAPI({"limit": ++page * 10});
        isLoading = false;
        setState(() {});
      }
    });
  }

  Future<void> _refresh() async {
    page = 1;
    isLoading = false;
   await _getBannerList();
   await _getCategoryList();
   await _getSpecialOffer();
   await _getInVogue();
   await _getOneStop();
   await _getRecommendList();
    ToastUtils.showSuccess(context, "刷新成功");
    paddingTop = 0;
    setState(() {});
  }

  // GlobalKey是一个方法，可以创建一个key绑定到Widget组件上，
  // 可以通过这个key来获取到组件的状态，或者调用组件的方法
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
 double paddingTop = 100;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      padding: EdgeInsets.only(top: paddingTop),
      duration: Duration(milliseconds: 300),
      child: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refresh,
        child: CustomScrollView(
          controller: _scrollController,
          slivers: getScrollChildren(),
        ),
      ),
    );
  }
}
