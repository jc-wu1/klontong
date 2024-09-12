import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../core/assets/asset_images.dart';
import '../../../core/design_system/design_system.dart';
import '../../../core/injector.dart';
import '../../../core/widgets/textfield_widget.dart';
import '../../home/presentation/widgets/home_section.dart';
import '../domain/usecases/products_usecases.dart';
import 'bloc/products_bloc.dart';
import 'widgets/products_card.dart';
import 'widgets/products_shimmer.dart';

class FlashSalePage extends StatelessWidget {
  const FlashSalePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductsBloc(
        usecases: sl<ProductsUsecases>(),
      )..add(const LoadProducts()),
      child: const FlashSaleView(),
    );
  }
}

class FlashSaleView extends StatefulWidget {
  const FlashSaleView({super.key});

  @override
  State<FlashSaleView> createState() => _FlashSaleViewState();
}

class _FlashSaleViewState extends State<FlashSaleView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor10,
      body: CustomScrollView(
        slivers: [
          const FlashSaleAppBar(),
          const FlashSaleBanner(),
          const FlashSaleTimer(),
          BlocBuilder<ProductsBloc, ProductsState>(
            builder: (context, state) {
              switch (state.status) {
                case LoadStatus.initial:
                  return const ProductsShimmer();
                case LoadStatus.success:
                  if (state.products.isEmpty) {
                    return const SliverToBoxAdapter(
                      child: Center(
                        child: Text('Not found'),
                      ),
                    );
                  }
                  return SliverPadding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                    ),
                    sliver: SliverMasonryGrid.count(
                      crossAxisCount: 2,
                      childCount: state.products.length,
                      itemBuilder: (context, index) {
                        var product = state.products[index];
                        return ProductCard(
                          product: product,
                          index: index,
                        );
                      },
                    ),
                  );
                case LoadStatus.failure:
                  if (state.products.isNotEmpty) {
                    return SliverPadding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                      ),
                      sliver: SliverMasonryGrid.count(
                        crossAxisCount: 2,
                        childCount: state.products.length,
                        itemBuilder: (context, index) {
                          var product = state.products[index];
                          return ProductCard(
                            product: product,
                            index: index,
                          );
                        },
                      ),
                    );
                  } else {
                    return const SliverToBoxAdapter(
                      child: Center(
                        child: Text('Not found'),
                      ),
                    );
                  }
              }
            },
          )
        ],
      ),
    );
  }
}

class FlashSaleBanner extends StatelessWidget {
  const FlashSaleBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Image.asset(
        imgFlashSale,
      ),
    );
  }
}

class FlashSaleTimer extends StatelessWidget {
  const FlashSaleTimer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: HomeSection(
        isFlashSale: true,
        flashSaleDuration: 23923,
        title: "Flash Sale",
        icon: const Icon(
          Icons.thunderstorm_sharp,
          color: Colors.amber,
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const FlashSalePage(),
            ),
          );
        },
        useSeeAllButton: false,
      ),
    );
  }
}

class FlashSaleAppBar extends StatelessWidget {
  const FlashSaleAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      elevation: 0.0,
      pinned: true,
      backgroundColor: whiteColor10,
      title: const MyTextField(
        prefixIcon: Icon(Icons.search),
        hint: 'Cari barang disini',
      ),
      flexibleSpace: const FlexibleSpaceBar(
        background: ColoredBox(
          color: flashSaleColor,
        ),
      ),
      expandedHeight: kToolbarHeight + 16,
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.shopping_bag,
          ),
        ),
      ],
    );
  }
}
