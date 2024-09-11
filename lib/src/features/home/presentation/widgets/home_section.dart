import 'package:flutter/material.dart';

import '../../../../core/design_system/design_system.dart';
import 'count_down_timer.dart';

class HomeSection extends StatelessWidget {
  const HomeSection({
    super.key,
    required this.isFlashSale,
    this.flashSaleDuration,
    required this.title,
    this.onTap,
    required this.useSeeAllButton,
    this.icon,
  });

  final bool isFlashSale;
  final int? flashSaleDuration;
  final String title;
  final VoidCallback? onTap;
  final bool useSeeAllButton;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Row(
                children: [
                  if (icon == null) ...[
                    const SizedBox.shrink(),
                  ] else ...[
                    icon!,
                    const SizedBox(
                      width: 4,
                    )
                  ],
                  Text(
                    title,
                    style: subheadline2Bold,
                  ),
                ],
              ),
              if (isFlashSale) ...[
                const SizedBox(
                  width: 8,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: errorColor50,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: CountDownTimer(
                    secondsRemaining: isFlashSale ? flashSaleDuration! : 0,
                    whenTimeExpires: () {},
                    countDownTimerStyle: caption1Bold.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ]
            ],
          ),
          if (useSeeAllButton)
            TextButton(
              style: TextButton.styleFrom(
                textStyle: caption1Bold,
                foregroundColor: primaryColor50,
              ),
              onPressed: onTap,
              child: const Text(
                'Lihat Semua',
              ),
            ),
        ],
      ),
    );
  }
}
