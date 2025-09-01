import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tender/core/resources/manager_images.dart';
import 'package:tender/core/resources/manager_strings.dart';
import 'package:tender/core/widgets/empty_state.dart';
import 'package:tender/core/widgets/main_background.dart';
import 'package:tender/features/medical_records/presentation/controller/medical_records_controller.dart';
import 'package:tender/features/medical_records/presentation/view/widgets/records_options.dart';

class MedicalRecordsView extends StatelessWidget {
  const MedicalRecordsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MedicalRecordsController>(
      builder: (controller) {
        return controller.medicalRecords.isEmpty
            ? EmptyStateWidget(
                appBarTitle: ManagerStrings.medicalRecords,
                title: ManagerStrings.addAMedicalRecord,
                subtitle: ManagerStrings.aDetailedHealthHistory,
                buttonText: ManagerStrings.addARecord,
                onPressed: () {
                  showModalBottomSheet(
                    useSafeArea: true,
                    backgroundColor: Colors.white,
                    context: context,
                    builder: (context) => SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: recordOptions(
                        onTakeAPhotoPressed: () =>
                            controller.onTakePhotoPressed(0),
                        onUploadFromGalleryPressed: () =>
                            controller.onUploadFromGalleryPressed(),
                        onUploadFilePressed: () =>
                            controller.onUploadFilePressed(),
                      ),
                    ),
                  );
                },
                svgAssetPath: ManagerImages.emptyMedicalRecords,
              )
            : const AppScaffold();
      },
    );
  }
}
