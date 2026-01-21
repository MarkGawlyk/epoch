# Visual Design Showcase

## Progress Photo Integration - Design Features

### 🎨 Design System

#### Color Palette
- **Background Gradient**: `#1a1a1a` → `#0a0a0a`
- **Frosted Glass**: Black with 50-70% opacity + 10px blur
- **Borders**: White 10-20% opacity
- **Text Primary**: White 100%
- **Text Secondary**: White 60-70%
- **Accents**: White with subtle opacity

#### Typography
```
Title (App Name):     48px / Weight 700 / Letter Spacing -1
Section Headers:      20px / Weight 600
Feature Titles:       18px / Weight 600
Body Text:           16px / Weight 500
Secondary Text:      14px / Weight 400
```

### 📱 Screen Layouts

#### 1. Home Screen
```
┌─────────────────────────────────┐
│                                 │
│    Epoch                        │
│    Structured habit challenge   │
│                                 │
│  ┌───────────────────────────┐ │
│  │ 📷  Progress Photos       │ │
│  │     Track your journey    │ │
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │ ✓   Daily Tasks           │ │
│  │     Complete challenges   │ │
│  └───────────────────────────┘ │
│                                 │
│  ┌───────────────────────────┐ │
│  │ 📈  Progress View         │ │
│  │     Visualize stats       │ │
│  └───────────────────────────┘ │
│                                 │
└─────────────────────────────────┘
```

#### 2. Photo Gallery Screen
```
┌─────────────────────────────────┐
│ [Frosted Glass AppBar]      [+]│
│   Progress Photos               │
├─────────────────────────────────┤
│                                 │
│  ┌───┐ ┌───┐ ┌───┐            │
│  │ 1 │ │ 2 │ │ 3 │            │
│  └───┘ └───┘ └───┘            │
│                                 │
│  ┌───┐ ┌───┐ ┌───┐            │
│  │ 4 │ │ 5 │ │ 6 │            │
│  └───┘ └───┘ └───┘            │
│                                 │
│  ┌───┐ ┌───┐ ┌───┐            │
│  │ 7 │ │ 8 │ │ 9 │            │
│  └───┘ └───┘ └───┘            │
│                                 │
└─────────────────────────────────┘
  3-column grid with 8px spacing
```

#### 3. Full-Screen Photo Viewer
```
┌─────────────────────────────────┐
│ [X]                      [Delete]│
│ [Gradient fade overlay]         │
│                                 │
│                                 │
│         [Photo with             │
│          zoom & pan]            │
│                                 │
│                                 │
│                                 │
│           ┌─────────┐           │
│           │  3 / 9  │           │
│           └─────────┘           │
└─────────────────────────────────┘
  Swipe left/right to navigate
  Tap to toggle controls
```

#### 4. Photo Source Dialog
```
     ┌───────────────────┐
     │ Add Progress Photo│
     │                   │
     │ ┌───────────────┐ │
     │ │ 📷 Take Photo │ │
     │ └───────────────┘ │
     │                   │
     │ ┌───────────────┐ │
     │ │ 🖼 Gallery    │ │
     │ └───────────────┘ │
     └───────────────────┘
```

#### 5. Photo Capture Widget (for Daily Tasks)
```
┌─────────────────────────────────┐
│  Add Progress Photo             │
│                                 │
│         [Camera Icon]           │
│      Add Progress Photo         │
│         (Optional)              │
│                                 │
└─────────────────────────────────┘

  OR (with photo)

┌─────────────────────────────────┐
│                         [✏][🗑] │
│      [Photo Preview]            │
│                                 │
└─────────────────────────────────┘
```

### ✨ Animation & Interaction Details

#### Transitions
- **Hero Animations**: Gallery thumbnail → Full-screen viewer
- **Page Transitions**: Material route slide animation
- **Control Fade**: Smooth fade in/out on tap

#### Gestures
- **Tap**: Select photo (gallery), toggle controls (viewer)
- **Swipe**: Navigate between photos (viewer)
- **Pinch**: Zoom in/out (viewer)
- **Long Press**: Not implemented (future: bulk selection)

#### Visual Effects
- **Blur**: `ImageFilter.blur(sigmaX: 10, sigmaY: 10)`
- **Opacity**: Layered opacity for depth
- **Gradients**: Top-to-bottom fades for controls
- **Borders**: Subtle white borders for separation

### 🎯 Key UI Components

#### Frosted Glass AppBar
```dart
BackdropFilter(
  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
  child: Container(
    decoration: BoxDecoration(
      color: Colors.black.withOpacity(0.5),
      border: Border(bottom: ...),
    ),
  ),
)
```

#### Feature Card
```dart
Container(
  padding: EdgeInsets.all(20),
  decoration: BoxDecoration(
    color: Colors.white.withOpacity(0.05),
    borderRadius: BorderRadius.circular(16),
    border: Border.all(
      color: Colors.white.withOpacity(0.1),
    ),
  ),
)
```

#### Photo Counter Badge
```dart
BackdropFilter(
  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
  child: Container(
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    decoration: BoxDecoration(
      color: Colors.black.withOpacity(0.6),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Colors.white.withOpacity(0.1)),
    ),
    child: Text('3 / 9'),
  ),
)
```

### 📊 Performance Optimizations

1. **Memory Efficient**: Stream-based directory listing
2. **Dynamic Layout**: Responsive padding based on device
3. **Image Quality**: 85% JPEG compression
4. **Lazy Loading**: GridView.builder for efficient rendering
5. **Hero Animations**: Native Flutter optimization

### 🔒 Privacy Features

- ✅ Local storage only
- ✅ No network calls
- ✅ Photos in app sandbox
- ✅ User-controlled deletion
- ✅ No analytics or tracking

### 🚀 User Flow

```
Home Screen
    ↓
Tap "Progress Photos"
    ↓
Photo Gallery (Grid View)
    ↓ Tap +
Photo Source Dialog
    ↓ Select Camera or Gallery
Camera/Gallery
    ↓ Capture/Select
Photo Saved & Gallery Refreshed
    ↓ Tap Thumbnail
Full-Screen Photo Viewer
    ↓ Swipe/Zoom/Delete
Return to Gallery or Home
```

### 📝 Code Organization

```
lib/
├── main.dart                    # App entry & home screen
├── models/
│   ├── daily_entry.dart         # Data model with photo
│   └── program.dart             # Program & task models
├── screens/
│   ├── photo_gallery_screen.dart  # Grid gallery view
│   └── photo_viewer_screen.dart   # Full-screen viewer
├── widgets/
│   └── photo_capture_widget.dart  # Reusable capture widget
└── utils/
    └── photo_storage_service.dart # Photo management
```

### 🎨 Design Philosophy

**Editorial Minimalism**
- Monochrome palette
- Generous whitespace
- Clean typography hierarchy
- Subtle depth through opacity
- Motion with purpose

**Inspired By**
- Linear's dark mode
- Vercel's minimal aesthetic  
- iOS native design patterns
- ShadCN's frosted glass effects
