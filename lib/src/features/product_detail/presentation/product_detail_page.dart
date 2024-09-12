import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/injector.dart';
import '../../shared/shimmers.dart';
import 'bloc/product_detail_bloc.dart';
import 'widgets/benefits.dart';
import 'widgets/cart_button.dart';
import 'widgets/product_info.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({
    super.key,
    required this.productId,
  });

  final String productId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductDetailBloc(
        usecases: sl(),
      )..add(
          ProductDetailRequested(
            productId: productId,
          ),
        ),
      child: const ProductDetailPageView(),
    );
  }
}

class ProductDetailPageView extends StatefulWidget {
  const ProductDetailPageView({super.key});

  @override
  State<ProductDetailPageView> createState() => _ProductDetailPageViewState();
}

class _ProductDetailPageViewState extends State<ProductDetailPageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BlocBuilder<ProductDetailBloc, ProductDetailState>(
        builder: (context, state) {
          if (state is ProductDetailLoaded) {
            return CartButton(
              price: double.parse(state.product.price!),
              press: () {},
            );
          }
          return const ShimmerStrip(
            width: double.infinity,
            height: 64,
          );
        },
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              floating: true,
              title: const Text("Detail"),
            ),
            SliverToBoxAdapter(
              child: BlocBuilder<ProductDetailBloc, ProductDetailState>(
                builder: (context, state) {
                  if (state is ProductDetailLoaded) {
                    return Image.network(
                      state.product.image!,
                    );
                  }
                  return const ShimmerStrip(
                    width: double.infinity,
                    height: 400,
                  );
                },
              ),
            ),
            BlocBuilder<ProductDetailBloc, ProductDetailState>(
              builder: (context, state) {
                if (state is ProductDetailLoaded) {
                  return ProductInfo(
                    brand: state.product.categoryName!,
                    title: state.product.name!,
                    description: state.product.description!,
                    rating:
                        (Random.secure().nextDouble() * 5).toStringAsFixed(2),
                    numOfReviews: "102",
                  );
                }
                return const ProductInfoShimmer();
              },
            ),
            const Benefits(),
            const SliverToBoxAdapter(
              child: SizedBox(height: 16),
            )
          ],
        ),
      ),
    );
  }
}
