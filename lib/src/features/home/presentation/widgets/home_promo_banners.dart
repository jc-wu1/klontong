import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants.dart';
import '../../../../core/extensions.dart';

class HomePromoBanners extends StatefulWidget {
  const HomePromoBanners({
    super.key,
  });

  @override
  State<HomePromoBanners> createState() => _HomePromoBannersState();
}

class _HomePromoBannersState extends State<HomePromoBanners> {
  final CarouselSliderController controller = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      carouselController: controller,
      itemCount: banners.length,
      itemBuilder: (BuildContext context, int index, int realIndex) {
        return GestureDetector(
          onTap: () {
            openUrl(githubUrl);
          },
          child: SizedBox(
            width: double.infinity,
            child: Image.asset(
              banners[index],
              fit: BoxFit.fitWidth,
            ),
          ),
        );
      },
      options: CarouselOptions(
        viewportFraction: 1,
        autoPlay: true,
      ),
    );
  }
}
