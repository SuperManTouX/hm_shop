import 'package:flutter/material.dart';
import 'package:hm_shop/api/mine.dart';
import 'package:hm_shop/components/Home/HmMoreList.dart';
import 'package:hm_shop/types/Home.dart';
import 'package:hm_shop/utils/ToastUtils.dart';

class MineView extends StatefulWidget {
  MineView({Key? key}) : super(key: key);

  @override
  _MineViewState createState() => _MineViewState();
}

class _MineViewState extends State<MineView> {
  // 订单状态项方法
  Widget _orderStatusItem(String imagePath, String title) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(imagePath, width: 25, height: 25),
          SizedBox(height: 5),
          Text(title, style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  // 用户信息区块
  Widget _userInfoSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      height: 100,
      color: Color.fromARGB(255, 254, 241, 233),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("lib/assets/goods_avatar.png", width: 50, height: 50),
              SizedBox(width: 10),
              Text("用户昵称"),
            ],
          ),
        ],
      ),
    );
  }

  // 会员和功能区块
  Widget _memberSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          // 会员
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 242, 188, 146),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Row(
              children: [
                Image.asset(
                  "lib/assets/ic_user_vip.png",
                  width: 25,
                  height: 25,
                ),
                SizedBox(width: 5),
                Expanded(
                  child: Text(
                    "升级商城会员，尊享无限免邮",
                    style: TextStyle(color: Color.fromARGB(255, 163, 105, 68)),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(126, 43, 26, 1),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: const Text('立即开通', style: TextStyle(fontSize: 12)),
                ),
              ],
            ),
          ),
          // 收藏足迹客服
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 254, 241, 233),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _orderStatusItem("lib/assets/ic_user_collect.png", "我的收藏"),
                _orderStatusItem("lib/assets/ic_user_history.png", "我的足迹"),
                _orderStatusItem("lib/assets/ic_user_unevaluated.png", "我的客服"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 订单区块
  Widget _orderSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(85, 158, 158, 158),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 2),
            ),
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "我的订单",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _orderStatusItem("lib/assets/ic_user_obligation.png", "待付款"),
                _orderStatusItem("lib/assets/ic_user_unshipped.png", "待发货"),
                _orderStatusItem("lib/assets/ic_user_unreceived.png", "待收货"),
                _orderStatusItem("lib/assets/ic_user_unevaluated.png", "待评价"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<GoodsDetailItem> _guessLikeList = [];
  bool isLoading = false;
  Map<String, dynamic> _guessLikeParams = {"page": 1, "pageSize": 10};
  @override
  void initState() {
    super.initState();
    _getGuessLikeList();
    _addScrollEvent() ;
  }

  // 猜你喜欢列表
  Future<void> _getGuessLikeList() async {
    final items = await getGuessLikeListAPI(_guessLikeParams);
    _guessLikeList = items.items;
    setState(() {});
  }

  // 滚动控制器
  final ScrollController _scrollController = ScrollController();
  _addScrollEvent() {
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 50) {
        if (isLoading) {
          return;
        }
        isLoading = true;
        _guessLikeParams["page"]++;
        final result = await getGuessLikeListAPI(_guessLikeParams);
        _guessLikeList.addAll(result.items);
        isLoading = false;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      padding: EdgeInsets.only(top: 0),
      duration: Duration(milliseconds: 300),
      child: RefreshIndicator(
        onRefresh: () async {},
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverToBoxAdapter(child: _userInfoSection()),
            SliverToBoxAdapter(child: SizedBox(height: 10)),
            SliverToBoxAdapter(child: _memberSection()),
            SliverToBoxAdapter(child: SizedBox(height: 10)),
            SliverToBoxAdapter(child: _orderSection()),
            HmMoreList(recommendList: _guessLikeList),
          ],
        ),
      ),
    );
  }
}
