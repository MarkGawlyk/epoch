import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';

/// Service for managing progress photos locally
class PhotoStorageService {
  final ImagePicker _picker = ImagePicker();

  /// Get the directory for storing progress photos
  Future<Directory> getPhotosDirectory() async {
    final appDir = await getApplicationDocumentsDirectory();
    final photosDir = Directory('${appDir.path}/progress_photos');
    if (!await photosDir.exists()) {
      await photosDir.create(recursive: true);
    }
    return photosDir;
  }

  /// Capture a photo from camera
  Future<String?> capturePhoto() async {
    final XFile? photo = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 85,
    );

    if (photo == null) return null;

    return await savePhoto(photo.path);
  }

  /// Pick a photo from gallery
  Future<String?> pickFromGallery() async {
    final XFile? photo = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );

    if (photo == null) return null;

    return await savePhoto(photo.path);
  }

  /// Save photo to app directory
  Future<String> savePhoto(String sourcePath) async {
    final photosDir = await getPhotosDirectory();
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final fileName = 'progress_$timestamp.jpg';
    final targetPath = '${photosDir.path}/$fileName';

    final sourceFile = File(sourcePath);
    await sourceFile.copy(targetPath);

    return targetPath;
  }

  /// Delete a photo
  Future<void> deletePhoto(String path) async {
    final file = File(path);
    if (await file.exists()) {
      await file.delete();
    }
  }

  /// Get all progress photos
  Future<List<String>> getAllPhotos() async {
    final photosDir = await getPhotosDirectory();
    final photosList = <String>[];
    
    await for (final entity in photosDir.list()) {
      if (entity is File && entity.path.endsWith('.jpg')) {
        photosList.add(entity.path);
      }
    }
    
    photosList.sort((a, b) => b.compareTo(a)); // Most recent first
    return photosList;
  }
}
