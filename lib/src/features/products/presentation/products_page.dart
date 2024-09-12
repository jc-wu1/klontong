import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../core/design_system/design_system.dart';
import '../../../core/injector.dart';
import '../../shared/shimmers.dart';
import '../domain/usecases/products_usecases.dart';
import 'bloc/products_bloc.dart';
import 'widgets/products_app_bar.dart';
import 'widgets/products_card.dart';
import 'widgets/products_shimmer.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductsBloc(
        usecases: sl<ProductsUsecases>(),
      )..add(const LoadProducts()),
      child: const ProductsPageView(),
    );
  }
}

class ProductsPageView extends StatefulWidget {
  const ProductsPageView({super.key});

  @override
  State<ProductsPageView> createState() => _ProductsPageViewState();
}

class _ProductsPageViewState extends State<ProductsPageView> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      BlocProvider.of<ProductsBloc>(context).add(const LoadProducts());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.95);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor10,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          const ProductsAppBar(),
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
                      childCount: state.hasReachedMax
                          ? state.products.length
                          : state.products.length + 2,
                      itemBuilder: (context, index) {
                        final product = index >= state.products.length
                            ? state.products[index - 2]
                            : state.products[index];
                        return index >= state.products.length
                            ? const ShimmerStrip(
                                height: 200,
                                width: 150,
                              )
                            : ProductCard(
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
                        childCount: state.hasReachedMax
                            ? state.products.length
                            : state.products.length + 2,
                        itemBuilder: (context, index) {
                          final product = index >= state.products.length
                              ? state.products[index - 2]
                              : state.products[index];
                          return index >= state.products.length
                              ? const ShimmerStrip(
                                  height: 200,
                                  width: 150,
                                )
                              : ProductCard(
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
