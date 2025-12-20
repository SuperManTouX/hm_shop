import 'package:flutter/material.dart';
import 'package:hm_shop/api/home.dart';
import 'package:hm_shop/components/Home/HmSuggestion.dart';
import 'package:hm_shop/components/Home/HmCategory.dart';
import 'package:hm_shop/components/Home/HmHot.dart';
import 'package:hm_shop/components/Home/HmMoreList.dart';
import 'package:hm_shop/components/Home/HmSlider.dart';
import 'package:hm_shop/types/Home.dart';

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


  @override
  void initState() {
    super.initState();
    _getBannerList();
    _getCategoryList();
    _getSpecialOffer();
    _getInVogue();
    _getOneStop();
    _getRecommendList();
  }

  void _getBannerList() async {
    _bannerList = await getBannerList();
    setState(() {});
  }

  // 获取分类列表
  void _getCategoryList() async {
    _categoryList = await getCategoryList();
    setState(() {});
  }

  // 特惠推荐
  void _getSpecialOffer() async {
    _specialOfferResult = await getSpecialOffer();
    setState(() {});
  }
  // 热榜推荐
  void _getInVogue() async {
    _inVogueResult = await getInVogue();
    setState(() {});
  }
  // 一站式推荐
  void _getOneStop() async {
    _oneStopResult = await getOneStop();
    setState(() {});
  }
  // 获取推荐列表
  void _getRecommendList() async {
    _recommendList = await getRecommendListAPI({"limit": 10});
    setState(() {});
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
              Expanded(child: HmHot(HotData: _inVogueResult, cardType: 'inVogue',)),
              SizedBox(width: 10),
              Expanded(child: HmHot(HotData: _oneStopResult, cardType: 'oneStop',)),
            ],
          ),
        ),
      ),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      HmMoreList(recommendList: _recommendList,),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: getScrollChildren());
  }
}
