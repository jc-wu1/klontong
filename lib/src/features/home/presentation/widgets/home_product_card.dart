import 'package:flutter/material.dart';

import '../../../../core/design_system/design_system.dart';

class HomeProductCard extends StatelessWidget {
  const HomeProductCard({
    super.key,
    required this.img,
  });

  final String img;

  @override
  Widget build(BuildContext context) {
    return Container(
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
              img,
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          Text(
            'Ini sample produk saja, silahkan klik Lihat Semua',
            style: caption1Regular,
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
    );
  }
}
