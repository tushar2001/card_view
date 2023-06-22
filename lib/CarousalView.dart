import 'package:flutter/material.dart';
// import 'package:gallery_view/smooth_page_indicator_new/smooth_page_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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
  late List<String> imageUrls;
  int activePage = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.imageUrls = widget.imageUrls;
  }

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
              setState(() {
                activePage = page;
              });
            },
          ),
          Positioned(
              bottom: 12,
              child: SmoothPageIndicator(
                controller: controller,
                count: imageUrls.length,
                effect: ScrollingDotsEffect(
                  activeStrokeWidth: 1,
                  dotWidth: 8,
                  dotHeight: 8,
                  activeDotColor: Colors.white,
                  activeDotScale: 1,
                  dotColor: Color.fromRGBO(255, 255, 255, 0.2),
                  maxVisibleDots: 9,
                ),
              ))
        ],
      ),
    );
  }
}
