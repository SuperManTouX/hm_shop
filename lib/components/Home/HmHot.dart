import 'package:flutter/material.dart';
import 'package:hm_shop/types/Home.dart';

class HmHot extends StatefulWidget {
  // 热门卡片数据
  final SpecialOfferResult HotData;
  final String cardType;

  HmHot({Key? key, required this.HotData, required this.cardType}) : super(key: key);

  @override
  _HmHotState createState() => _HmHotState();
}

class _HmHotState extends State<HmHot> {
  // 获取热门卡片的子类型商品,的前两个商品
  List<GoodsItem> _getSubTypes() {
    try {
      if (widget.HotData.subTypes.isEmpty) {
        return [];
      }
      final firstSubType = widget.HotData.subTypes.first;
      if (firstSubType.goodsItems.items.isEmpty) {
        return [];
      }
      return firstSubType.goodsItems.items.take(2).toList();
    } catch (e) {
      print("Error getting subtypes: $e");
      return [];
    }
  }

  List<Widget> _subTypesWidgets() {
    return _getSubTypes().map((e) {
      return Column(
        children: [
          Image.network(e.picture, width: 100, height: 120, fit: BoxFit.cover),
          Text(e.price),
        ],
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: widget.cardType == 'inVogue' ? Color.fromARGB(255, 202, 224, 237) : Color.fromARGB(255, 249, 244, 216),
        borderRadius: BorderRadius.circular(10),
      ),
      height: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                widget.HotData.title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 92, 40, 36),
                ),
              ),
              SizedBox(width: 10),
              Text(
                widget.cardType == 'inVogue' ? "最受欢迎" : "精心优选",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 92, 40, 36),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: _subTypesWidgets(),
          ),
        ],
      ),
    );
  }
}
