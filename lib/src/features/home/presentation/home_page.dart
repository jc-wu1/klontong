import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants.dart';
import '../../../core/design_system/design_system.dart';
import 'widgets/home_app_bar.dart';
import 'widgets/home_categories.dart';
import 'widgets/home_product_card.dart';
import 'widgets/home_promo_banners.dart';
import 'widgets/home_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ScrollController _controller;
  late StreamController<bool> _streamController;

  @override
  void initState() {
    super.initState();
    _streamController = StreamController.broadcast();
    _controller = ScrollController()..addListener(_isScrolledDown);
  }

  void _isScrolledDown() {
    if (_controller.offset > 10) {
      return _streamController.sink.add(true);
    }
    return _streamController.sink.add(false);
  }

  @override
  void dispose() {
    _controller.removeListener(_isScrolledDown);
    _controller.dispose();
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        controller: _controller,
        slivers: [
          HomeAppBar(streamController: _streamController),
          SliverList(
            delegate: SliverChildListDelegate.fixed(
              [
                const HomeCategories(),
                const HomePromoBanners(),
                const Divider(
                  thickness: 12,
                  color: sketchColor,
                ),
                HomeSection(
                  isFlashSale: true,
                  flashSaleDuration: 23923,
                  title: "Flash Sale",
                  icon: const Icon(
                    Icons.thunderstorm_sharp,
                    color: Colors.amber,
                  ),
                  onTap: () {
                    context.pushNamed("productFlashSale");
                  },
                  useSeeAllButton: true,
                ),
                ColoredBox(
                  color: sketchColor,
                  child: MasonryGridView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 10,
                    gridDelegate:
                        const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemBuilder: (context, index) => HomeProductCard(
                      img: imgs[index],
                    ),
                  ),
                ),
                HomeSection(
                  isFlashSale: false,
                  flashSaleDuration: 23923,
                  title: "Semua Produk",
                  icon: const Icon(
                    Icons.align_horizontal_left_sharp,
                  ),
                  onTap: () {
                    context.pushNamed("products");
                  },
                  useSeeAllButton: true,
                ),
                MasonryGridView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 10,
                  gridDelegate:
                      const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) => HomeProductCard(
                    img: imgs[index],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
