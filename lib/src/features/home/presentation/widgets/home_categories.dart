import 'package:flutter/material.dart';

import '../../../../core/constants.dart';
import '../../../../core/design_system/design_system.dart';

class HomeCategories extends StatelessWidget {
  const HomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 16,
      ),
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
      ),
      itemCount: 8,
      itemBuilder: (context, index) {
        final category = homeCategories[index];
        return GestureDetector(
          onTap: () {
            if (index != 7) {
            } else {}
          },
          child: Column(
            children: [
              if (index != 7)
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: whiteColor50,
                        ),
                      ),
                      padding: const EdgeInsets.all(8.0),
                      margin: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        category["icon"],
                        width: 28,
                        height: 28,
                      ),
                    ),
                    Text(
                      category["name"],
                      style: caption1Regular,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
              if (index == 7)
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: whiteColor50,
                        ),
                      ),
                      padding: const EdgeInsets.all(8.0),
                      margin: const EdgeInsets.all(8.0),
                      child: const Icon(
                        Icons.window,
                        color: primaryColor50,
                      ),
                    ),
                    Text(
                      "Lihat Semua",
                      style: caption1Bold,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }
}
