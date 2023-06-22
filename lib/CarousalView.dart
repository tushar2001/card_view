// import 'package:gallery_view/smooth_page_indicator_new/smooth_page_indicator.dart';
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
  final dotSize = 15.0;
  final spaceBetweenDots = 10.0;
  final visibleDots = 8;
  late final AutoScrollController _autoScrollController;
  late List<String> imageUrls;
  int activePage = 0;
  bool isMovingForward = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.imageUrls = widget.imageUrls;
    _autoScrollController = AutoScrollController(
      //choose vertical/horizontal
      axis: scrollDirection,
    );
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
              bool isMovingForward = activePage < page;
              setState(() {
                this.isMovingForward = isMovingForward;
                activePage = page;
              });

              if (isMovingForward && page >= computedDot) {
                _autoScrollController.scrollToIndex(page + 2);
              }

              if (!isMovingForward &&
                  page <= (imageUrls.length - computedDot)) {
                _autoScrollController.scrollToIndex(page - 2);
              }
            },
          ),
          Positioned(
            bottom: 12,
            child: SizedBox(
              width: (dotSize + spaceBetweenDots) * visibleDots,
              height: 40,
              child: ListView.separated(
                controller: _autoScrollController,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: scrollDirection,
                itemCount: imageUrls.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  bool isCurrentDot = index == activePage;
                  var shouldReduceDot = activePage > computedDot + 1
                      // || activePage < (imageUrls.length - computedDot)
                      ;
                  bool isFirstSmallDot = !isMovingForward &&
                      shouldReduceDot &&
                      index < activePage - computedDot;
                  return AutoScrollTag(
                    key: ValueKey(index),
                    controller: _autoScrollController,
                    index: index,
                    child: SizedBox(
                      width: dotSize,
                      height: dotSize,
                      child: FractionallySizedBox(
                        widthFactor: isFirstSmallDot ? 0.4 : 1,
                        heightFactor: isFirstSmallDot ? 0.4 : 1,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: isCurrentDot ? Colors.blue : Colors.red,
                            shape: BoxShape.circle,
                          ),
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
