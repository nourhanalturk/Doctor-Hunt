import 'dart:io';

class UploadProfileImageRequest {
  final File image;
  final String currentImageUrl;

  UploadProfileImageRequest({
    required this.image,
    required this.currentImageUrl,
  });
}
