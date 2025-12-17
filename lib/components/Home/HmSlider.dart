import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hm_shop/types/Home.dart';

class HmSlider extends StatefulWidget {
  List<CarouselItem> bannerList;
  HmSlider({Key? key, required this.bannerList}) : super(key: key);

  @override
  _HmSliderState createState() => _HmSliderState();
}

class _HmSliderState extends State<HmSlider> {
  int _carouselIndex = 0;
  double _getScreenWidth() {
    return MediaQuery.of(context).size.width;
  }

  Widget _getSearch() {
    return Positioned(
      top: 10,
      left: 0,
      right: 0,
      child: Container(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 10),
          child: TextField(
            decoration: InputDecoration(
              fillColor: Color.fromARGB(117, 17, 17, 17),
              filled: true,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(50),
              ),
              hint: Text("搜索", style: TextStyle(color: Colors.white)),
            ),
          ),
        ),
      ),
    );
  }

  Widget _getCarousel() {
    return CarouselSlider(
      items: List.generate(widget.bannerList.length, (int index) {
        return Image.network(
          widget.bannerList[index].url,
          fit: BoxFit.cover,
          width: _getScreenWidth(),
        );
      }),
      options: CarouselOptions(
        onPageChanged: (int index, reason) {
          _carouselIndex = index;
          setState(() {});
        },
        viewportFraction: 1,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 5),
      ),
    );
  }

  Widget _getDots() {
    return Positioned(
      bottom: 10,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(widget.bannerList.length, (int index) {
          return AnimatedContainer(
            duration: Duration(milliseconds: 300),
            width: _carouselIndex == index ? 40 : 20,
            height: 5,
            margin: EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: _carouselIndex == index ? Colors.black : Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
          );
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [_getCarousel(), _getDots(), _getSearch()]);
    // return Container(
    //   height: 300,
    //   color: Colors.blue,
    //   child: Center(child: Text("轮播图")),
    // );
  }
}
