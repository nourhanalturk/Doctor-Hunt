import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tender/core/extensions/extensions.dart';
import 'package:tender/core/resources/manager_strings.dart';
import 'package:tender/core/widgets/content_card.dart';
import 'package:tender/core/widgets/doctor_info_card.dart';
import 'package:tender/core/widgets/home_care_header.dart';
import 'package:tender/core/widgets/home_search_panel.dart';
import 'package:tender/core/widgets/home_section_header.dart';
import 'package:tender/core/widgets/main_background.dart';
import 'package:tender/features/home/domain/model/home_data_model.dart';
import 'package:tender/features/home/presentation/controller/home_controller.dart';

import '../../../../core/resources/manager_colors.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return GetBuilder<HomeController>(
      builder: (controller) {
        SystemChrome.setSystemUIOverlayStyle(
          const SystemUiOverlayStyle(
            statusBarColor: ManagerColors.transparent,
            statusBarIconBrightness: Brightness.dark,
          ),
        );

        final bool hasData = controller.popularDoctors.isNotEmpty ||
            controller.featuredDoctors.isNotEmpty;
        final bool isSearching =
            controller.searchController.text.trim().isNotEmpty;
        final List<HomeModel> results = controller.searchDoctors();

        return RefreshIndicator(
          onRefresh: () => controller.homeRequest(),
          child: AppScaffold(
            body: ListView(
              padding: const EdgeInsets.only(bottom: 96),
              children: [
                HomeCareHeader(
                  userName: controller.userName,
                  userImage: controller.userImage,
                  onProfileTap: controller.navigateToProfileInfo,
                  searchPanel: HomeSearchPanel(
                    controller: controller.searchController,
                    onChanged: (_) => controller.update(),
                    onClear: () {
                      controller.onSearchButtonClearPressed();
                      controller.update();
                    },
                  ),
                ),
                if (!hasData)
                  SizedBox(
                    height: size.height * 0.5,
                    child: Center(
                      child: controller.isLoading
                          ? const CircularProgressIndicator(
                              color: Color(0xFF168A57),
                            )
                          : Text(
                              ManagerStrings.noContent,
                              style: const TextStyle(
                                color: const Color(0xFF7E8A86),
                                fontSize: 14,
                              ),
                            ),
                    ),
                  )
                else if (isSearching)
                  _SearchResults(
                    results: results,
                    controller: controller,
                  )
                else
                  _HomeSections(controller: controller),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _HomeSections extends StatelessWidget {
  const _HomeSections({required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        HomeSectionHeader(
          title: ManagerStrings.popularDoctors,
          topPadding: 44,
          titleFontSize: 20,
          actionFontSize: 13.5,
        ),
        SizedBox(
          height: 252,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsetsDirectional.only(start: 20, end: 20),
            itemCount: controller.popularDoctors.length,
            separatorBuilder: (_, __) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              final model = controller.popularDoctors[index];
              return contentCard(
                image: model.image.onNull(),
                doctorName: model.name.onNull(),
                doctorSpecialty: model.specialty,
                onTap: () => controller.navigateToDoctorDetails(model.id),
                width: 200,
                height: 252,
                imageHeight: 145,
                doctorId: model.id,
                doctorRate: model.rating.toString(),
                coastByHour: model.coastPerHour.onNull().toString(),
              );
            },
          ),
        ),
        HomeSectionHeader(title: ManagerStrings.featureDoctors),
        _DoctorGrid(
          doctors: controller.featuredDoctors,
          controller: controller,
          cardHeight: 196,
        ),
      ],
    );
  }
}

class _SearchResults extends StatelessWidget {
  const _SearchResults({required this.results, required this.controller});

  final List<HomeModel> results;
  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    if (results.isEmpty) {
      return SizedBox(
        height: 260,
        child: Center(
          child: Text(
            ManagerStrings.noContent,
            style: const TextStyle(
              color: const Color(0xFF7E8A86),
              fontSize: 14,
            ),
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        HomeSectionHeader(
          title: ManagerStrings.search,
          topPadding: 44,
          titleFontSize: 19,
        ),
        _DoctorGrid(
          doctors: results,
          controller: controller,
          cardHeight: 196,
        ),
      ],
    );
  }
}

class _DoctorGrid extends StatelessWidget {
  const _DoctorGrid({
    required this.doctors,
    required this.controller,
    required this.cardHeight,
  });

  final List<HomeModel> doctors;
  final HomeController controller;
  final double cardHeight;

  @override
  Widget build(BuildContext context) {
    const double gap = 14;
    const double side = 20;

    return Padding(
      padding: const EdgeInsetsDirectional.only(start: side, end: side),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double itemWidth = (constraints.maxWidth - gap) / 2;
          return Wrap(
            spacing: gap,
            runSpacing: gap,
            children: doctors.map((model) {
              return SizedBox(
                width: itemWidth,
                height: cardHeight,
                child: doctorInfoCard(
                  doctorId: model.id,
                  onTap: () => controller.navigateToDoctorDetails(model.id),
                  onFavoritePressed: () {},
                  doctorRate: model.rating.toString(),
                  doctorName: model.name,
                  coastByHour: model.coastPerHour.onNull().toString(),
                  image: model.image.onNull(),
                  cardHeight: cardHeight,
                  cardWidth: itemWidth,
                  imageRadius: 14,
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
