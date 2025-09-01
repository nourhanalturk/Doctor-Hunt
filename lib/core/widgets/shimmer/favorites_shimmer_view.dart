import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/resources/manager_height.dart';
import '../../../../core/resources/manager_opacity.dart';
import '../../../../core/resources/manager_radius.dart';
import '../../../../core/resources/manager_width.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/resources/manager_strings.dart';

class FavoritesShimmerView extends StatelessWidget {
  const FavoritesShimmerView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(ManagerHeight.h20),
          child: customAppBar(
            appBarTitle: ManagerStrings.favoriteDoctors,
          ),
        ),
        Expanded(
          child: GridView.builder(
            padding: EdgeInsets.all(ManagerWidth.w20),
            itemCount: 6,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: ManagerWidth.w10,
              mainAxisSpacing: ManagerWidth.w10,
              childAspectRatio: ManagerOpacity.op0_7,
            ),
            itemBuilder: (_, __) {
              return Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Container(
                  width: size.width * ManagerOpacity.op0_8,
                  height: size.height * ManagerOpacity.op0_4,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(ManagerRadius.r12),
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
