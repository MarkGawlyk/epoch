# Progress Photo Integration

This document describes the progress photo integration feature implemented in the Epoch app.

## Overview

The progress photo integration allows users to:
- Capture progress photos using their device camera
- Select photos from their device gallery
- View photos in a sleek, grid-based gallery
- View full-screen photos with swipe navigation and zoom
- Delete unwanted photos

## Features

### 1. Photo Gallery Screen
- **Grid Layout**: Photos displayed in a 3-column grid
- **Frosted Glass Design**: Transparent AppBar with blur effect
- **Dark Theme**: Monochrome design with gradient background
- **Empty State**: User-friendly message when no photos exist
- **Add Button**: Quick access to add new photos

### 2. Full-Screen Photo Viewer
- **Swipe Navigation**: Swipe left/right between photos
- **Pinch to Zoom**: Zoom in/out on photos
- **Hero Animations**: Smooth transitions from gallery to viewer
- **Photo Counter**: Shows current photo position (e.g., "1 / 5")
- **Delete Option**: Remove photos from viewer
- **Toggle Controls**: Tap to show/hide UI controls

### 3. Photo Capture Widget
- **Camera Integration**: Take photos directly with device camera
- **Gallery Access**: Select existing photos from gallery
- **Preview**: See selected photo before saving
- **Edit/Delete**: Change or remove captured photos
- **Optional**: Photos are optional for daily entries

## Architecture

### Data Models

**DailyEntry** (`lib/models/daily_entry.dart`)
- Stores daily progress with optional photo path
- Links photos to specific days and programs

**Program** (`lib/models/program.dart`)
- Defines habit challenge structure
- Contains tasks and configuration

### Services

**PhotoStorageService** (`lib/utils/photo_storage_service.dart`)
- Manages photo capture and storage
- Handles camera and gallery access
- Stores photos in app documents directory
- Provides photo retrieval and deletion

### UI Components

**PhotoGalleryScreen** (`lib/screens/photo_gallery_screen.dart`)
- Main gallery view with grid layout
- Photo source selection dialog
- Navigation to full-screen viewer

**PhotoViewerScreen** (`lib/screens/photo_viewer_screen.dart`)
- Full-screen photo display
- Swipe and zoom capabilities
- Photo deletion functionality

**PhotoCaptureWidget** (`lib/widgets/photo_capture_widget.dart`)
- Reusable widget for daily task screen
- Add/edit/remove photo functionality
- Preview display

## Usage

### Opening the Gallery

```dart
Navigator.of(context).push(
  MaterialPageRoute(
    builder: (context) => const PhotoGalleryScreen(),
  ),
);
```

### Using Photo Capture Widget

```dart
PhotoCaptureWidget(
  existingPhotoPath: dailyEntry.photoPath,
  onPhotoChanged: (newPath) {
    // Handle photo change
    setState(() {
      dailyEntry.photoPath = newPath;
    });
  },
)
```

### Capturing Photos Programmatically

```dart
final photoService = PhotoStorageService();

// Capture from camera
final photoPath = await photoService.capturePhoto();

// Pick from gallery
final photoPath = await photoService.pickFromGallery();

// Get all photos
final allPhotos = await photoService.getAllPhotos();

// Delete a photo
await photoService.deletePhoto(photoPath);
```

## Dependencies

- **image_picker** (^1.0.7): Camera and gallery access
- **photo_view** (^0.14.0): Zoom and pan functionality
- **path_provider** (^2.1.2): Local storage directory access

## Permissions

### iOS (Info.plist)
```xml
<key>NSCameraUsageDescription</key>
<string>Epoch needs access to your camera to capture progress photos.</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>Epoch needs access to your photo library to select progress photos.</string>
<key>NSPhotoLibraryAddUsageDescription</key>
<string>Epoch needs access to save progress photos to your library.</string>
```

### Android (AndroidManifest.xml)
```xml
<uses-permission android:name="android.permission.CAMERA"/>
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" android:maxSdkVersion="28"/>
<uses-feature android:name="android.hardware.camera" android:required="false"/>
```

## Design System

### Colors
- Background: Dark gradient (`#1a1a1a` to `#0a0a0a`)
- Text: White with varying opacity
- Accents: White borders with 10-20% opacity
- Blur: Frosted glass effect using `BackdropFilter`

### Typography
- Title: 48px, weight 700
- Headers: 20px, weight 600
- Body: 16px, weight 500
- Secondary: 14px with reduced opacity

### Animations
- Hero animations for photo transitions
- Smooth page transitions
- Fade in/out for controls

## Storage

Photos are stored in the app's documents directory:
- Path: `{app_documents_directory}/progress_photos/`
- Format: JPEG (85% quality)
- Naming: `progress_{timestamp}.jpg`
- Sorting: Most recent first

## Privacy

All photos are stored locally:
- No cloud upload
- No external sharing
- Stored in app sandbox
- Deleted with app uninstall

## Future Enhancements

Potential improvements for future versions:
- Photo annotations and notes
- Before/after comparison view
- Photo filters and editing
- Export photos as collection
- Timeline view with photos
- Multiple photos per day
