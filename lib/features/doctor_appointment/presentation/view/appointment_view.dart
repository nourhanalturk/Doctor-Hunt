import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tender/core/resources/manager_fonts.dart';
import 'package:tender/core/resources/manager_strings.dart';
import 'package:tender/core/widgets/glass_card.dart';
import 'package:tender/core/widgets/main_background.dart';
import 'package:tender/core/widgets/modern_action_button.dart';
import 'package:tender/core/widgets/modern_choice_chip.dart';
import 'package:tender/core/widgets/modern_doctor_card.dart';
import 'package:tender/core/widgets/modern_sub_page_header.dart';
import 'package:tender/core/widgets/modern_text_field.dart';
import 'package:tender/core/widgets/shimmer/shimmer_time_circle.dart';
import 'package:tender/features/doctor_appointment/presentation/controller/doctor_appointment_controller.dart';

class DoctorAppointmentView extends StatelessWidget {
  const DoctorAppointmentView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DoctorAppointmentController>(builder: (controller) {
      return AppScaffold(
        body: Column(
          children: [
            ModernSubPageHeader(
              title: ManagerStrings.appointment,
              subtitle: ManagerStrings.dateAndTime,
              onBack: () => Get.back(),
            ),
            _stepIndicator(),
            Expanded(
              child: PageView(
                controller: controller.pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _patientStep(controller),
                  _scheduleStep(controller),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _stepIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
      child: Row(
        children: [
          _stepDot(index: 0, label: ManagerStrings.yourDetails),
          Expanded(
            child: Container(
              height: 2,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              color: const Color(0xFFBFE4D0),
            ),
          ),
          _stepDot(index: 1, label: ManagerStrings.dateAndTime),
        ],
      ),
    );
  }

  Widget _stepDot({required int index, required String label}) {
    return GetBuilder<DoctorAppointmentController>(builder: (controller) {
      final bool active = controller.pageController.hasClients
          ? (controller.pageController.page?.round() ?? 0) == index
          : index == 0;
      final Color color = active
          ? const Color(0xFF168A57)
          : const Color(0xFF9EACA6);

      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: active ? color : const Color(0xFFE6F0EA),
              border: Border.all(color: color, width: 1.5),
            ),
            child: Center(
              child: Text(
                '${index + 1}',
                style: TextStyle(
                  fontFamily: ManagerFontFamily.fontFamily,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: active ? Colors.white : color,
                ),
              ),
            ),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontFamily: ManagerFontFamily.fontFamily,
              fontSize: 11.5,
              fontWeight: active ? FontWeight.w800 : FontWeight.w600,
              color: color,
            ),
          ),
        ],
      );
    });
  }

  Widget _patientStep(DoctorAppointmentController controller) {
    return ListView(
      padding: const EdgeInsets.only(bottom: 24),
      children: [
        ModernDoctorCard(
          doctorId: controller.doctorId,
          name: controller.doctorName,
          specialty: controller.doctorSpeciality,
          imageUrl: controller.doctorImage,
          rating: controller.doctorRating,
          priceLabel:
              '${ManagerStrings.dollarSign}${controller.doctorCoastPerHour.toStringAsFixed(0)}${ManagerStrings.byHour}',
          compact: true,
        ),
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 22, top: 16, bottom: 12),
          child: Text(
            ManagerStrings.appointmentFor,
            style: TextStyle(
              fontFamily: ManagerFontFamily.fontFamily,
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: const Color(0xFF154734),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              ModernTextField(
                controller: controller.patientName,
                label: ManagerStrings.patientName,
                icon: Icons.person_outline_rounded,
              ),
              const SizedBox(height: 12),
              ModernTextField(
                controller: controller.contactNumber,
                label: ManagerStrings.contactNumber,
                icon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 18),
              GlassCard(
                margin: EdgeInsets.zero,
                padding: const EdgeInsets.all(14),
                child: InkWell(
                  onTap: controller.pickImage,
                  borderRadius: BorderRadius.circular(16),
                  child: Row(
                    children: [
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE3F5EB),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: controller.selectedImage == null
                            ? controller.isUploadingImage
                                ? const Center(
                                    child: SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Color(0xFF168A57),
                                      ),
                                    ),
                                  )
                                : const Icon(
                                    Icons.add_a_photo_outlined,
                                    color: Color(0xFF168A57),
                                  )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.file(
                                  File(controller.selectedImage!.path),
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.isUploadingImage
                                  ? ManagerStrings.uploadingImage
                                  : ManagerStrings.patientPhoto,
                              style: TextStyle(
                                fontFamily: ManagerFontFamily.fontFamily,
                                fontSize: 13.5,
                                fontWeight: FontWeight.w800,
                                color: const Color(0xFF154734),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              controller.imageUrl == null
                                  ? ManagerStrings.add
                                  : ManagerStrings.done,
                              style: TextStyle(
                                fontFamily: ManagerFontFamily.fontFamily,
                                fontSize: 12,
                                color: const Color(0xFF6E7B76),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.camera_alt_outlined,
                        size: 19,
                        color: Color(0xFF168A57),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 22),
              ModernActionButton(
                label: ManagerStrings.next,
                icon: Icons.arrow_forward_rounded,
                onPressed: controller.onNextPressed,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _scheduleStep(DoctorAppointmentController controller) {
    final DateTime now = DateTime.now();
    final DateTime startOfToday = DateTime(now.year, now.month, now.day);

    return Column(
      children: [
        GlassCard(
          margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
          padding: const EdgeInsets.all(6),
          borderRadius: 22,
          child: TableCalendar(
            firstDay: startOfToday,
            lastDay: startOfToday.add(const Duration(days: 365)),
            focusedDay: controller.focusedDay,
            calendarFormat: CalendarFormat.week,
            availableCalendarFormats: const {
              CalendarFormat.week: 'Week',
            },
            selectedDayPredicate: (day) => isSameDay(controller.selectedDay, day),
            enabledDayPredicate: (day) => !day.isBefore(startOfToday),
            onDaySelected: (selectedDay, focusedDay) {
              controller.onFocusDayChanged(selectedDay, focusedDay);
            },
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              titleTextStyle: TextStyle(
                fontFamily: ManagerFontFamily.fontFamily,
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF154734),
              ),
              leftChevronIcon: const Icon(
                Icons.chevron_left_rounded,
                color: Color(0xFF168A57),
              ),
              rightChevronIcon: const Icon(
                Icons.chevron_right_rounded,
                color: Color(0xFF168A57),
              ),
            ),
            daysOfWeekStyle: DaysOfWeekStyle(
              weekdayStyle: TextStyle(
                fontFamily: ManagerFontFamily.fontFamily,
                fontSize: 11,
                color: const Color(0xFF6E7B76),
              ),
              weekendStyle: TextStyle(
                fontFamily: ManagerFontFamily.fontFamily,
                fontSize: 11,
                color: const Color(0xFF168A57),
              ),
            ),
            calendarStyle: CalendarStyle(
              selectedDecoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF168A57),
              ),
              todayDecoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0x66168A57),
              ),
              selectedTextStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
              ),
              defaultTextStyle: TextStyle(
                fontFamily: ManagerFontFamily.fontFamily,
                fontSize: 12,
                color: const Color(0xFF3D4B45),
              ),
              disabledTextStyle: const TextStyle(color: Color(0xFFC6D0CB)),
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 20),
            child: GlassCard(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _sectionLabel(Icons.access_time_rounded, ManagerStrings.chooseTime),
                  const SizedBox(height: 12),
                  if (controller.isAvailableTimesLoading)
                    SizedBox(
                      height: 54,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: 4,
                        separatorBuilder: (_, __) => const SizedBox(width: 10),
                        itemBuilder: (_, __) => const ShimmerTimeCircle(),
                      ),
                    )
                  else if (controller.availableTimes.isEmpty)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF4F8F6),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Text(
                        ManagerStrings.noAvailableTimeForTheDoctorToday,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: ManagerFontFamily.fontFamily,
                          fontSize: 12,
                          color: const Color(0xFF7E8A86),
                        ),
                      ),
                    )
                  else
                    SizedBox(
                      height: 54,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.availableTimes.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 10),
                        itemBuilder: (context, index) {
                          return ModernChoiceChip(
                            label: controller.availableTimes[index],
                            selected:
                                controller.appointmentTimeSelectedIndex == index,
                            icon: Icons.schedule_rounded,
                            onTap: () => controller.onSelectTime(index),
                          );
                        },
                      ),
                    ),
                  const SizedBox(height: 18),
                  _sectionLabel(
                    Icons.notifications_none_rounded,
                    ManagerStrings.reminderMeBefore,
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 52,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.reminderTimes.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 10),
                      itemBuilder: (context, index) {
                        return ModernChoiceChip(
                          label:
                              '${controller.reminderTimes[index]}\n${ManagerStrings.minit}',
                          selected: controller.reminderTimeIndex == index,
                          width: 74,
                          onTap: () => controller.onReminderTimesPressed(index),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 18),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEAF7F0),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.event_available_rounded,
                          size: 17,
                          color: Color(0xFF168A57),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            '${DateFormat.yMd().format(controller.selectedDay)}  •  ${controller.timeSelected ?? ManagerStrings.chooseTime}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: ManagerFontFamily.fontFamily,
                              fontSize: 12.5,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF227350),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  ModernActionButton(
                    label: ManagerStrings.confirm,
                    icon: Icons.check_rounded,
                    enabled: controller.timeSelected != null &&
                        !controller.isSubmitting,
                    onPressed: controller.addAppointment,
                  ),
                  const SizedBox(height: 6),
                  Align(
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: controller.onPreviousPressed,
                      child: Text(
                        ManagerStrings.editYourAppointment,
                        style: TextStyle(
                          fontFamily: ManagerFontFamily.fontFamily,
                          fontSize: 12.5,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF168A57),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _sectionLabel(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, size: 17, color: const Color(0xFF168A57)),
        const SizedBox(width: 7),
        Text(
          label,
          style: TextStyle(
            fontFamily: ManagerFontFamily.fontFamily,
            fontSize: 14.5,
            fontWeight: FontWeight.w900,
            color: const Color(0xFF154734),
          ),
        ),
      ],
    );
  }
}
