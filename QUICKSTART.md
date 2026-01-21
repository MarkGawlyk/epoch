# Quick Start Guide - Progress Photo Integration

This guide will help you get the progress photo integration up and running quickly.

## Prerequisites

- Flutter SDK 3.0.0 or higher
- iOS device/simulator (iOS 11+) or Android device/emulator (API 21+)
- Xcode (for iOS development)
- Android Studio (for Android development)

## Installation

### 1. Install Dependencies

```bash
cd /path/to/epoch
flutter pub get
```

This will install:
- `image_picker` - Camera and gallery access
- `photo_view` - Photo zoom and pan functionality
- `path_provider` - Local file system access

### 2. iOS Setup

No additional setup required! The necessary permissions are already configured in `ios/Runner/Info.plist`:
- Camera access
- Photo library access
- Photo library add access

### 3. Android Setup

No additional setup required! The necessary permissions are already configured in `android/app/src/main/AndroidManifest.xml`:
- Camera permission
- Storage read/write permissions

## Running the App

### iOS
```bash
flutter run -d ios
```

### Android
```bash
flutter run -d android
```

### Web (Limited functionality)
```bash
flutter run -d chrome
# Note: Camera access may not work on web platform
```

## Testing the Feature

### 1. Launch the App
The app will open to the home screen with three feature cards.

### 2. Navigate to Progress Photos
Tap on the "Progress Photos" card to open the photo gallery.

### 3. Add Your First Photo
1. Tap the `+` button in the top-right corner
2. Choose "Take Photo" to use the camera OR "Choose from Gallery" to select an existing photo
3. The photo will be saved and displayed in the gallery

### 4. View Photos
1. Tap any photo thumbnail in the gallery
2. View the full-screen photo
3. Swipe left/right to navigate between photos
4. Pinch to zoom in/out
5. Tap to show/hide controls

### 5. Delete Photos
1. Open a photo in full-screen view
2. Tap the delete icon (trash can) in the top-right
3. Confirm deletion in the dialog

## Architecture Overview

```
User taps "Add Photo"
       ↓
PhotoStorageService.capturePhoto() or pickFromGallery()
       ↓
Image saved to app documents directory: /progress_photos/
       ↓
Path returned to caller
       ↓
Gallery refreshes with new photo
```

## Key Files

| File | Purpose |
|------|---------|
| `lib/main.dart` | App entry point and home screen |
| `lib/screens/photo_gallery_screen.dart` | Photo gallery with grid layout |
| `lib/screens/photo_viewer_screen.dart` | Full-screen photo viewer |
| `lib/widgets/photo_capture_widget.dart` | Reusable photo capture widget |
| `lib/utils/photo_storage_service.dart` | Photo management service |
| `lib/models/daily_entry.dart` | Daily entry model with photo path |
| `lib/models/program.dart` | Program and task models |

## Common Issues & Solutions

### Issue: "Camera permission denied"
**Solution**: On iOS, delete the app and reinstall. On Android, go to Settings → Apps → Epoch → Permissions and enable Camera.

### Issue: "Photos not appearing in gallery"
**Solution**: Make sure photos are being saved successfully. Check the app documents directory permissions.

### Issue: "App crashes when taking photo"
**Solution**: 
- iOS: Make sure you're running on a real device (simulator doesn't have camera)
- Android: Check that camera permissions are granted

### Issue: "Build error - package not found"
**Solution**: Run `flutter pub get` and restart your IDE

### Issue: "Frosted glass effect not showing"
**Solution**: This is a visual effect that works best on real devices. Simulators may not render it perfectly.

## Development Tips

### Customizing the Gallery Layout

Change the grid column count in `photo_gallery_screen.dart`:
```dart
gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  crossAxisCount: 3, // Change this to 2 or 4
  crossAxisSpacing: 8,
  mainAxisSpacing: 8,
  childAspectRatio: 1,
),
```

### Adjusting Image Quality

Modify the quality in `photo_storage_service.dart`:
```dart
final XFile? photo = await _picker.pickImage(
  source: ImageSource.camera,
  imageQuality: 85, // 0-100, lower = smaller file size
);
```

### Changing Colors

Update colors in `main.dart`:
```dart
theme: ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color(0xFF0a0a0a), // Background
  colorScheme: const ColorScheme.dark(
    primary: Colors.white, // Primary color
    secondary: Colors.white70, // Secondary color
  ),
),
```

### Adding Photo Metadata

Extend `DailyEntry` model to include metadata:
```dart
class DailyEntry {
  final String? photoPath;
  final DateTime? photoTimestamp; // Add this
  final String? photoNote; // Add this
  // ... rest of the model
}
```

## Next Steps

- [ ] Integrate photo capture widget into daily task screen
- [ ] Connect photos to daily entries
- [ ] Add photo timeline view
- [ ] Implement before/after comparison
- [ ] Add photo export functionality

## Need Help?

- Check the main README.md for project overview
- See PHOTO_INTEGRATION.md for detailed documentation
- See DESIGN_SHOWCASE.md for design specifications

## Testing

Currently, the app doesn't have automated tests. To test manually:

1. **Photo Capture**: Try both camera and gallery selection
2. **Gallery View**: Add multiple photos, verify grid layout
3. **Photo Viewer**: Test swipe, zoom, and delete functionality
4. **Memory**: Add 50+ photos and check performance
5. **Permissions**: Test denied permissions scenario

## Performance Notes

- Photos are stored as JPEG at 85% quality
- Gallery uses streaming to handle large photo collections
- GridView.builder for efficient list rendering
- Hero animations use Flutter's native optimization

## Privacy & Security

✅ All photos stored locally
✅ No network requests
✅ No analytics or tracking
✅ Photos in app sandbox only
✅ Deleted with app uninstall

---

**Ready to build?** Run `flutter run` and start capturing progress! 📸
