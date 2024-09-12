import 'package:flutter/material.dart';

import '../../../../core/design_system/design_system.dart';
import '../../../shared/shimmers.dart';

class ProductInfo extends StatelessWidget {
  const ProductInfo({
    super.key,
    required this.title,
    required this.brand,
    required this.description,
    required this.rating,
    required this.numOfReviews,
  });

  final String title, brand, description;
  final String rating;
  final String numOfReviews;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(16),
      sliver: SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: primaryColor20,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                brand.toUpperCase(),
                style: body2Regular,
              ),
            ),
            const SizedBox(height: 16 / 2),
            Text(
              title,
              maxLines: 2,
              style: subheadline1Bold,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                const SizedBox(width: 16 / 4),
                Text(
                  "$rating ",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text("($numOfReviews Reviews)")
              ],
            ),
            const SizedBox(height: 16),
            Text(
              "Product info",
              style: body2SemiBold,
            ),
            const SizedBox(height: 16 / 2),
            Text(
              description,
              style: const TextStyle(height: 1.4),
            ),
            const SizedBox(height: 16 / 2),
          ],
        ),
      ),
    );
  }
}

class ProductInfoShimmer extends StatelessWidget {
  const ProductInfoShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(16),
      sliver: SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ShimmerStrip(height: 20, width: 189),
            const SizedBox(height: 16 / 2),
            const ShimmerStrip(height: 20, width: 240),
            const SizedBox(height: 16),
            const ShimmerStrip(height: 20, width: 210),
            const SizedBox(height: 16),
            Text(
              "Product info",
              style: body2SemiBold,
            ),
            const SizedBox(height: 16 / 2),
            const ShimmerStrip(
              height: 120,
              width: double.infinity,
            ),
            const SizedBox(height: 16 / 2),
          ],
        ),
      ),
    );
  }
}
