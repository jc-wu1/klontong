import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../core/design_system/design_system.dart';
import 'widgets/home_app_bar.dart';
import 'widgets/home_categories.dart';
import 'widgets/home_promo_banners.dart';
import 'widgets/home_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

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

  List<String> imgs = [
    "https://plus.unsplash.com/premium_photo-1664474619075-644dd191935f?q=80&w=2069&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1579544787614-fa683917e045?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTR8fGltYWdlfGVufDB8fDB8fHww",
    "https://images.unsplash.com/photo-1578589315522-9e5521b9c158?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTl8fGltYWdlfGVufDB8fDB8fHww",
    "https://plus.unsplash.com/premium_photo-1664304102989-6048cbdc2051?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjV8fGltYWdlfGVufDB8fDB8fHww",
    "https://images.unsplash.com/photo-1579781403299-11c35baa47e2?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MzB8fGltYWdlfGVufDB8fDB8fHww",
    "https://plus.unsplash.com/premium_photo-1663047168154-d5425fd4d1e5?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MzN8fGltYWdlfGVufDB8fDB8fHww",
    "https://images.unsplash.com/photo-1579544787614-fa683917e045?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTR8fGltYWdlfGVufDB8fDB8fHww",
    "https://plus.unsplash.com/premium_photo-1682513184135-b7b9b76fb4eb?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mzd8fGltYWdlfGVufDB8fDB8fHww",
    "https://images.unsplash.com/photo-1579544787614-fa683917e045?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTR8fGltYWdlfGVufDB8fDB8fHww",
    "https://images.unsplash.com/photo-1579544787614-fa683917e045?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTR8fGltYWdlfGVufDB8fDB8fHww",
  ];

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
                const HomeSection(
                  isFlashSale: true,
                  flashSaleDuration: 23923,
                  title: "Flash Sale",
                  icon: Icon(
                    Icons.thunderstorm_sharp,
                    color: Colors.amber,
                  ),
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
                  itemBuilder: (context, index) => Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: whiteColor50,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Image.network(
                            imgs[index],
                          ),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Text(
                          'Ini produknya sadklsajd ksla jdklsadk ads',
                          style: caption1Bold,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Rp20.000',
                              style: subheadline2Bold,
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.favorite,
                                color: errorColor50,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
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
