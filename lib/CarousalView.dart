// import 'package:gallery_view/smooth_page_indicator_new/smooth_page_indicator.dart';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class CarousalView extends StatefulWidget {
  final List<String> imageUrls;

  const CarousalView({
    super.key,
    required this.imageUrls,
  });

  @override
  State<CarousalView> createState() => _CarousalViewState();
}

class _CarousalViewState extends State<CarousalView> {
  final controller = PageController(keepPage: true);
  final scrollDirection = Axis.horizontal;
  final dotSize = 10.0;
  final spaceBetweenDots = 10.0;
  final visibleDots = 8;
  late final AutoScrollController _autoScrollController;
  late List<String> imageUrls;
  int activePage = 0;
  late int firstVisibleDot;
  late int lastVisibleDot;
  bool isMovingForward = false;
  bool isMovingBackward = false;
  List<int> scale3 = [];
  List<int> scale6 = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firstVisibleDot = 0;
    lastVisibleDot = visibleDots - 1;
    this.imageUrls = widget.imageUrls;
    lastVisibleDot = visibleDots - 1;
    _autoScrollController = AutoScrollController(
      //choose vertical/horizontal
      axis: scrollDirection,
    );
    if (visibleDots < imageUrls.length) {
      scale3.add(7);
      scale6.add(6);
    }
  }

  double get computedDot => (visibleDots / 2);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240,
      width: 343,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          PageView.builder(
            controller: controller,
            itemCount: imageUrls.length,
            itemBuilder: (BuildContext context, int index) {
              return CachedNetworkImage(
                imageUrl: imageUrls[index],
                fit: BoxFit.fill,
              );
            },
            onPageChanged: (page) {
              this.isMovingForward = activePage < page;
              this.isMovingBackward = activePage > page;
              activePage = page;

              if (isMovingForward && page >= computedDot) {
                _autoScrollController.scrollToIndex(page + 2);
              }

              if (isMovingBackward &&
                  page <= (imageUrls.length - computedDot)) {
                _autoScrollController.scrollToIndex(page - 2);
              }
              if (isMovingForward &&
                  activePage < imageUrls.length - 2 &&
                  activePage == lastVisibleDot - 1) {
                firstVisibleDot++;
                lastVisibleDot++;
              } else if (isMovingBackward &&
                  activePage == firstVisibleDot + 1 &&
                  activePage > 1) {
                firstVisibleDot--;
                lastVisibleDot--;
              }
              scale3.clear();
              scale6.clear();
              setState(() {
                if (firstVisibleDot > 0) {
                  scale3.add(firstVisibleDot);
                  scale6.add(firstVisibleDot + 1);
                }
                if (lastVisibleDot < imageUrls.length - 1) {
                  scale3.add(lastVisibleDot);
                  scale6.add(lastVisibleDot - 1);
                }
              });
            },
          ),
          Positioned(
            bottom: 12,
            child: SizedBox(
              width: (dotSize + spaceBetweenDots) *
                  (visibleDots < imageUrls.length
                      ? visibleDots
                      : imageUrls.length),
              height: 40,
              child: ListView.separated(
                controller: _autoScrollController,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: scrollDirection,
                itemCount: imageUrls.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  bool isCurrentDot = index == activePage;
                  double scale = 1;
                  for (int itemIndex in scale3) {
                    if (index == itemIndex) scale = 0.6;
                  }
                  for (int itemIndex in scale6) {
                    if (index == itemIndex) scale = 0.8;
                  }

                  return AutoScrollTag(
                    key: ValueKey(index),
                    controller: _autoScrollController,
                    index: index,
                    child: SizedBox(
                      width: dotSize,
                      height: dotSize,
                      child: FractionallySizedBox(
                        widthFactor: scale,
                        heightFactor: scale,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(
                                  color: (isCurrentDot)
                                      ? Colors.white
                                      : Colors.blueGrey,
                                  width: (isCurrentDot) ? 3 : 2),
                              shape: BoxShape.circle),
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                  width: 10,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
