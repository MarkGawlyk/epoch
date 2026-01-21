import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import '../utils/photo_storage_service.dart';

/// Widget for capturing progress photos on daily task screen
class PhotoCaptureWidget extends StatefulWidget {
  final String? existingPhotoPath;
  final Function(String?) onPhotoChanged;

  const PhotoCaptureWidget({
    super.key,
    this.existingPhotoPath,
    required this.onPhotoChanged,
  });

  @override
  State<PhotoCaptureWidget> createState() => _PhotoCaptureWidgetState();
}

class _PhotoCaptureWidgetState extends State<PhotoCaptureWidget> {
  final PhotoStorageService _photoService = PhotoStorageService();
  String? _photoPath;

  @override
  void initState() {
    super.initState();
    _photoPath = widget.existingPhotoPath;
  }

  Future<void> _capturePhoto() async {
    final photoPath = await _showPhotoSourceDialog();
    if (photoPath != null) {
      setState(() {
        _photoPath = photoPath;
      });
      widget.onPhotoChanged(photoPath);
    }
  }

  Future<void> _removePhoto() async {
    if (_photoPath != null) {
      await _photoService.deletePhoto(_photoPath!);
      setState(() {
        _photoPath = null;
      });
      widget.onPhotoChanged(null);
    }
  }

  Future<String?> _showPhotoSourceDialog() async {
    return showDialog<String>(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.white.withOpacity(0.1),
                  width: 1,
                ),
              ),
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Add Progress Photo',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildSourceButton(
                    icon: Icons.camera_alt,
                    label: 'Take Photo',
                    onTap: () async {
                      final path = await _photoService.capturePhoto();
                      if (context.mounted) Navigator.of(context).pop(path);
                    },
                  ),
                  const SizedBox(height: 12),
                  _buildSourceButton(
                    icon: Icons.photo_library,
                    label: 'Choose from Gallery',
                    onTap: () async {
                      final path = await _photoService.pickFromGallery();
                      if (context.mounted) Navigator.of(context).pop(path);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSourceButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.white.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 24),
            const SizedBox(width: 16),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: _photoPath == null ? _buildAddPhotoButton() : _buildPhotoPreview(),
      ),
    );
  }

  Widget _buildAddPhotoButton() {
    return InkWell(
      onTap: _capturePhoto,
      child: Container(
        height: 200,
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_photo_alternate,
              size: 48,
              color: Colors.white.withOpacity(0.5),
            ),
            const SizedBox(height: 12),
            const Text(
              'Add Progress Photo',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Optional',
              style: TextStyle(
                color: Colors.white.withOpacity(0.5),
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhotoPreview() {
    return Stack(
      children: [
        SizedBox(
          height: 200,
          width: double.infinity,
          child: Image.file(
            File(_photoPath!),
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.white),
                      onPressed: _capturePhoto,
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.white),
                      onPressed: _removePhoto,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
