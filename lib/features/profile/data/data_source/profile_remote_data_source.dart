import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tender/config/constants/supabase_fields_constants.dart';
import 'package:tender/config/constants/supabase_tables_constants.dart';
import 'package:tender/features/profile/data/request/profile_request.dart';
import 'package:tender/features/profile/data/request/update_patient_request.dart';
import 'package:tender/features/profile/data/request/upload_profile_image_request.dart';
import 'package:tender/features/profile/data/response/uploaded_image_response.dart';

const String _profileImageBucket = 'profile-image';

abstract class ProfileRemoteDataSource {
  Future<void> profile(ProfileRequest request);

  Future<void> updatePatient(UpdatePatientRequest request);

  Future<UploadedImageResponse> uploadProfileImage(
    UploadProfileImageRequest request,
  );
}

class ProfileRemoteDataSourceImplementation implements ProfileRemoteDataSource {
  final SupabaseClient client;

  ProfileRemoteDataSourceImplementation(this.client);

  @override
  Future<void> profile(ProfileRequest request) async {
    final response = await client
        .from(SupabaseTableConstants.profile)
        .select(SupabaseFieldsConstants.userId)
        .eq(SupabaseFieldsConstants.userId, request.userId)
        .maybeSingle();

    if (response != null) {
      await client
          .from(SupabaseTableConstants.profile)
          .update(request.toJson())
          .eq(SupabaseFieldsConstants.userId, request.userId);
    } else {
      await client
          .from(SupabaseTableConstants.profile)
          .insert(request.toJson());
    }
  }

  @override
  Future<void> updatePatient(UpdatePatientRequest request) async {
    await client
        .from(SupabaseTableConstants.patients)
        .update(request.toJson())
        .eq(SupabaseFieldsConstants.patientId, request.patientId);
  }

  @override
  Future<UploadedImageResponse> uploadProfileImage(
    UploadProfileImageRequest request,
  ) async {
    final currentImageUrl = request.currentImageUrl;
    if (currentImageUrl.isNotEmpty) {
      try {
        final uri = Uri.parse(currentImageUrl);
        final fullPath = uri.pathSegments
            .skipWhile((s) => s != _profileImageBucket)
            .skip(1)
            .join('/');

        if (fullPath.isNotEmpty) {
          await client.storage
              .from(_profileImageBucket)
              .remove([fullPath]);
        }
      } catch (_) {
        // Removing the previous image is best effort.
      }
    }

    final userId = client.auth.currentUser!.id;
    final fileName = DateTime.now().microsecondsSinceEpoch.toString();
    final path = '$userId/$fileName';

    await client.storage.from(_profileImageBucket).upload(path, request.image);
    final url = client.storage.from(_profileImageBucket).getPublicUrl(path);

    return UploadedImageResponse(url: url, path: path);
  }
}
