import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tender/core/resources/manager_fonts.dart';
import 'package:tender/core/resources/manager_strings.dart';
import 'package:tender/core/widgets/glass_card.dart';
import 'package:tender/core/widgets/main_background.dart';
import 'package:tender/core/widgets/modern_clinic_map.dart';
import 'package:tender/core/widgets/modern_doctor_card.dart';
import 'package:tender/core/widgets/modern_empty_state.dart';
import 'package:tender/core/widgets/modern_sub_page_header.dart';
import 'package:tender/core/widgets/shimmer/doctor_details_view_shimmer.dart';
import 'package:tender/features/doctor_details/domain/di/di.dart';
import 'package:tender/features/doctor_details/presentation/controller/doctor_details_controller.dart';

class DoctorDetailsView extends StatelessWidget {
  const DoctorDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DoctorDetailsController>(builder: (controller) {
      return AppScaffold(
        body: ListView(
          padding: const EdgeInsets.only(bottom: 30),
          children: [
            ModernSubPageHeader(
              title: ManagerStrings.doctorDetails,
              subtitle: ManagerStrings.doctorDetailsSubtitle,
              onBack: () {
                disposeDoctorDetails();
                Get.back();
              },
              trailing: controller.isChatLoading
                  ? const Padding(
                      padding: EdgeInsetsDirectional.only(end: 8),
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Color(0xFF168A57),
                        ),
                      ),
                    )
                  : null,
            ),
            if (controller.isLoading)
              const DoctorDetailsShimmer()
            else if (controller.hasError)
              modernEmptyState(
                icon: Icons.cloud_off_rounded,
                title: ManagerStrings.couldNotLoadDoctor,
                subtitle: ManagerStrings.unexpectedError,
                buttonText: ManagerStrings.retry,
                buttonIcon: Icons.refresh_rounded,
                onPressed: controller.retryGetDoctorDetails,
              )
            else ...[
              const SizedBox(height: 22),
              ModernDoctorCard(
                doctorId: controller.doctorId,
                name: controller.doctorName,
                specialty: controller.doctorSpeciality,
                imageUrl: controller.image,
                rating: controller.rating,
                priceLabel:
                    '${ManagerStrings.dollarSign}${controller.coastPerHour.toStringAsFixed(0)}${ManagerStrings.byHour}',
                onBookNow: controller.navigateToAppointment,
                onChat: controller.createOrOpenChat,
              ),
              _patientStats(controller),
              _servicesCard(controller.services),
              ModernClinicMap(
                coordinates: controller.coordinates,
                location: controller.location,
              ),
            ],
          ],
        ),
      );
    });
  }

  Widget _patientStats(DoctorDetailsController controller) {
    final List<IconData> icons = [
      Icons.local_fire_department_outlined,
      Icons.timeline_rounded,
      Icons.people_alt_outlined,
    ];

    return GlassCard(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: List.generate(controller.patientStatus.length, (index) {
          final int value = index < controller.values.length
              ? controller.values[index]
              : 0;
          return Expanded(
            child: Container(
              margin: EdgeInsetsDirectional.only(
                end: index == controller.patientStatus.length - 1 ? 0 : 6,
              ),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFF1FAF5),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Icon(
                    icons[index % icons.length],
                    size: 18,
                    color: const Color(0xFF168A57),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '$value',
                    style: TextStyle(
                      fontFamily: ManagerFontFamily.fontFamily,
                      fontSize: 19,
                      fontWeight: FontWeight.w900,
                      color: const Color(0xFF154734),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    controller.patientStatus[index],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: ManagerFontFamily.fontFamily,
                      fontSize: 11,
                      color: const Color(0xFF6E7B76),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _servicesCard(List<String> services) {
    return GlassCard(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.medical_services_outlined,
                size: 19,
                color: Color(0xFF168A57),
              ),
              const SizedBox(width: 8),
              Text(
                ManagerStrings.services,
                style: TextStyle(
                  fontFamily: ManagerFontFamily.fontFamily,
                  fontSize: 17,
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF154734),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          if (services.isEmpty)
            Text(
              ManagerStrings.noContent,
              style: TextStyle(
                fontFamily: ManagerFontFamily.fontFamily,
                fontSize: 13,
                color: const Color(0xFF7E8A86),
              ),
            )
          else
            ...List.generate(services.length, (index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFDDF5E8),
                      ),
                      child: Center(
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(
                            fontFamily: ManagerFontFamily.fontFamily,
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF168A57),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        services[index],
                        style: TextStyle(
                          fontFamily: ManagerFontFamily.fontFamily,
                          fontSize: 13.5,
                          height: 1.35,
                          color: const Color(0xFF3D4B45),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
        ],
      ),
    );
  }
}
