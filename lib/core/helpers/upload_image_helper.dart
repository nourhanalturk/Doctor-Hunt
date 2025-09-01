import 'dart:io';
import 'package:flutter_state_render_dialog/flutter_state_render_dialog.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tender/core/resources/manager_strings.dart';
import 'package:tender/core/error_handler/error_handler.dart';

Future<String?> uploadImage(String bucketName ,File image) async {
  final supabase = Supabase.instance.client;
  final context = Get.context!;
  final userId = supabase.auth.currentUser?.id;

  if (userId == null) {
    dialogRender(
      context: context,
      stateRenderType: StateRenderType.popUpErrorState,
      message: ManagerStrings.unAuthorized,
      title: '',
    );
    return null;
  }

  dialogRender(
    context: context,
    stateRenderType: StateRenderType.popUpLoadingState,
    message: ManagerStrings.uploadingImage,
    title: '',
  );

  try {
    final fileName = DateTime.now().microsecondsSinceEpoch.toString();
    final path = '$userId/$fileName';

    await supabase.storage.from(bucketName).upload(path, image);

    final url = supabase.storage.from(bucketName).getPublicUrl(path);

    Get.back();
    return url;
  } catch (error) {
    Get.back();

    final failure = ErrorHandler.handle(error).failure;
    dialogRender(
      context: context,
      stateRenderType: StateRenderType.popUpErrorState,
      message: failure.message,
      title: '',
    );
    return null;
  }
}
