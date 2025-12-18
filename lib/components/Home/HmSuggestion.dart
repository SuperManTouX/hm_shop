import 'package:flutter/material.dart';
import 'package:hm_shop/types/Home.dart';

class HmSuggestion extends StatefulWidget {
  final SpecialOfferResult specialOfferResult;
  HmSuggestion({Key? key, required this.specialOfferResult}) : super(key: key);

  @override
  _HmSuggestionState createState() => _HmSuggestionState();
}

class _HmSuggestionState extends State<HmSuggestion> {
  // specialOfferResult的subtypes中的第一个只取前三条
  List<GoodsItem> _getSubTypes() {
    try {
      if (widget.specialOfferResult.subTypes.isEmpty) {
        return [];
      }
      final firstSubType = widget.specialOfferResult.subTypes.first;
      if (firstSubType.goodsItems.items.isEmpty) {
        return [];
      }
      return firstSubType.goodsItems.items.take(3).toList();
    } catch (e) {
      print("Error getting subtypes: $e");
      return [];
    }
  }

  List<Widget> _subTypesWidgets() {
    final subTypes = _getSubTypes();
    if (subTypes.isEmpty) {
      // 返回一个占位widget，避免空列表导致的布局问题
      return [
        Container(
          width: 100,
          height: 150,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(child: Text('加载中...')),
        ),
      ];
    }
    return subTypes.map((e) {
      return Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              errorBuilder: (context, error, stackTrace) => Image.asset(
                "lib/assets/home_cmd_inner.png",
                width: 100,
                height: 150,
                fit: BoxFit.cover,
              ),
              e.picture,
              width: 100,
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Text(
              "￥" + e.price,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      );
    }).toList();
  }

  // 完成渲染
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 10),
      child: Container(
        height: 300,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/assets/home_cmd_sm.png"),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(width: 200, "lib/assets/home_cmd_title.png"),
            SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  width: 100,
                  height: 150,
                  "lib/assets/home_cmd_inner.png",
                  fit: BoxFit.fill,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: _subTypesWidgets(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
