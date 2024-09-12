import 'package:flutter/material.dart';

import '../../../../core/assets/asset_icons.dart';
import '../../../../core/design_system/design_system.dart';

class Benefits extends StatelessWidget {
  const Benefits({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Keuntungan Pembelian',
              style: body2SemiBold,
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Image.asset(
                  icGaransi,
                  width: 20,
                  height: 20,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  'Jaminan garansi',
                  style: body2Regular,
                )
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              children: [
                Image.asset(
                  icJaminan,
                  width: 20,
                  height: 20,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  'Pembayaran aman terjamin',
                  style: body2Regular,
                )
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              children: [
                Image.asset(
                  icGratisOngkir,
                  width: 20,
                  height: 20,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  'Gratis ongkir se-Jabodetabek',
                  style: body2Regular,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
