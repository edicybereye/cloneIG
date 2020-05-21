import 'package:flutter/material.dart';

class DotsInddicator extends AnimatedWidget {
  final PageController controller;
  final int itemCount;
  final ValueChanged<int> onPageSelected;
  final Color color;

  DotsInddicator(
      {this.controller, this.itemCount, this.onPageSelected, this.color})
      : super(listenable: controller);

  @override
  Widget _buildDot(int index) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: Center(
        child: Material(
          color: index == (controller.page ?? controller.initialPage)
              ? color
              : color.withOpacity(0.4),
          type: MaterialType.circle,
          child: Container(
            height: 9,
            width: 9,
            child: InkWell(
              onTap: () => onPageSelected(index),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(itemCount, _buildDot),
    );
  }
}

class CarouselCustom extends StatelessWidget {
  PageController carouselController = PageController();
  final ValueChanged<int> carouselPageChanged;
  static const carouselDuration = const Duration(microseconds: 300);
  static const carouselCurve = Curves.ease;
  final List<Widget> carouselList;
  final Color indicatorColor;

  CarouselCustom({
    this.carouselController,
    this.carouselPageChanged,
    this.carouselList,
    this.indicatorColor,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Stack(
        children: <Widget>[
          PageView.builder(
              physics: AlwaysScrollableScrollPhysics(),
              controller: carouselController,
              onPageChanged: carouselPageChanged,
              itemCount: carouselList.length,
              itemBuilder: (context, i) {
                return carouselList[i % carouselList.length];
              }),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              padding: EdgeInsets.all(16),
              child: Center(
                child: DotsInddicator(
                  color: indicatorColor,
                  controller: carouselController,
                  itemCount: carouselList.length,
                  onPageSelected: (int page) {
                    carouselController.animateToPage(
                      page,
                      duration: carouselDuration,
                      curve: carouselCurve,
                    );
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
