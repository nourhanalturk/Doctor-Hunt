import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tender/core/widgets/empty_favorites.dart';
import 'package:tender/core/widgets/main_background.dart';
import 'package:tender/features/favorites/presentation/controller/favorites_controller.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: GetBuilder<FavoritesController>(
        builder: (controller) {
          return controller.favorites.isEmpty ? emptyFavorites() : Column();
        },
      ),
    );
  }
}
