import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'theme.dart';
import 'package:gallery_view/AdTileView.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  final ThemeEnum currentTheme = ThemeEnum.light;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeConfig.getTheme(currentTheme),
      home: ImageGridView(),
    );
  }
}

class ImageGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ad Listing Page'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(children: [
            AdTileView(
              price: '529 000 zł',
              title:
                  'Beautiful apartment after renovation in the heart of Łazarz',
              location: 'Poznan, Lazarus, ul. Józef Łukaszewic',
              sizedPrice: '10 796  zł/m²',
              area: '49  m²',
              rooms: '3  rooms',
            ),
            AdTileView(
              price: '529 000 zł',
              title:
                  'Beautiful apartment after renovation in the heart of Łazarz',
              location: 'Poznan, Lazarus, ul. Józef Łukaszewic',
              sizedPrice: '10 796  zł/m²',
              area: '49  m²',
              rooms: '3  rooms',
            ),
          ]),
        ),
      ),
    );
  }
}

List<Widget> indicators(imagesLength, currentIndex) {
  return List<Widget>.generate(imagesLength, (index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4),
      width: (index <= 9) ? 8 : (8 * 0.25 * (12 - index)),
      height: 8,
      decoration: BoxDecoration(
          color: currentIndex == index
              ? Colors.white
              : Color.fromRGBO(255, 255, 255, 0.5),
          shape: BoxShape.circle),
    );
  });
}
