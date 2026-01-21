# 📱 UI Screenshots Guide

This document describes what the UI looks like for testing and demonstration purposes.

## Home Screen

```
╔═══════════════════════════════════════╗
║                                       ║
║                                       ║
║    Epoch                              ║
║    Structured habit challenge tracker ║
║                                       ║
║    ╔═══════════════════════════════╗ ║
║    ║  📷  Progress Photos          ║ ║
║    ║      Track your journey with  ║ ║
║    ║      visual progress       → ║ ║
║    ╚═══════════════════════════════╝ ║
║                                       ║
║    ╔═══════════════════════════════╗ ║
║    ║  ✓   Daily Tasks              ║ ║
║    ║      Complete your challenge  ║ ║
║    ║      one day at a time     → ║ ║
║    ╚═══════════════════════════════╝ ║
║                                       ║
║    ╔═══════════════════════════════╗ ║
║    ║  📈  Progress View            ║ ║
║    ║      Visualize your compliance║ ║
║    ║      and statistics        → ║ ║
║    ╚═══════════════════════════════╝ ║
║                                       ║
╚═══════════════════════════════════════╝

Dark gradient background with frosted glass cards
```

## Photo Gallery Screen (Empty State)

```
╔═══════════════════════════════════════╗
║ [Frosted Glass AppBar]            [+]║
║  Progress Photos                      ║
║───────────────────────────────────────║
║                                       ║
║                                       ║
║               📷                      ║
║                                       ║
║        No progress photos yet         ║
║                                       ║
║       Tap + to add your first photo   ║
║                                       ║
║                                       ║
║                                       ║
╚═══════════════════════════════════════╝

Black gradient background (#1a1a1a → #0a0a0a)
```

## Photo Gallery Screen (With Photos)

```
╔═══════════════════════════════════════╗
║ [Frosted Glass AppBar]            [+]║
║  Progress Photos                      ║
║───────────────────────────────────────║
║                                       ║
║   ┌─────┐ ┌─────┐ ┌─────┐           ║
║   │ IMG │ │ IMG │ │ IMG │           ║
║   │  1  │ │  2  │ │  3  │           ║
║   └─────┘ └─────┘ └─────┘           ║
║                                       ║
║   ┌─────┐ ┌─────┐ ┌─────┐           ║
║   │ IMG │ │ IMG │ │ IMG │           ║
║   │  4  │ │  5  │ │  6  │           ║
║   └─────┘ └─────┘ └─────┘           ║
║                                       ║
║   ┌─────┐ ┌─────┐ ┌─────┐           ║
║   │ IMG │ │ IMG │ │ IMG │           ║
║   │  7  │ │  8  │ │  9  │           ║
║   └─────┘ └─────┘ └─────┘           ║
║                                       ║
╚═══════════════════════════════════════╝

3-column grid with 8px spacing
Rounded corners with white borders
```

## Photo Source Dialog

```
        ╔═════════════════════╗
        ║ Add Progress Photo  ║
        ║                     ║
        ║  ┌───────────────┐  ║
        ║  │ 📷 Take Photo │  ║
        ║  └───────────────┘  ║
        ║                     ║
        ║  ┌───────────────┐  ║
        ║  │ 🖼 Choose from │  ║
        ║  │   Gallery     │  ║
        ║  └───────────────┘  ║
        ║                     ║
        ╚═════════════════════╝

Frosted glass with blur
Dark semi-transparent background
```

## Full-Screen Photo Viewer

```
╔═══════════════════════════════════════╗
║ [X]                         [Delete]  ║
║ [Gradient overlay - fades out]        ║
║                                       ║
║                                       ║
║                                       ║
║         [Large Photo]                 ║
║         Can zoom & pan                ║
║         Swipe left/right              ║
║                                       ║
║                                       ║
║                                       ║
║           ╔═════════╗                 ║
║           ║  3 / 9  ║                 ║
║           ╚═════════╝                 ║
╚═══════════════════════════════════════╝

Full black background
Tap to toggle controls
Pinch to zoom
```

## Delete Confirmation Dialog

```
        ╔═════════════════════╗
        ║  Delete Photo?      ║
        ║                     ║
        ║  This action cannot ║
        ║  be undone.         ║
        ║                     ║
        ║  ┌────┐   ┌──────┐ ║
        ║  │Cancel│  │Delete│ ║
        ║  └────┘   └──────┘ ║
        ╚═════════════════════╝

Delete button is red
Cancel button is subtle
```

## Photo Capture Widget (Empty)

```
╔═══════════════════════════════════════╗
║                                       ║
║              📷                       ║
║                                       ║
║       Add Progress Photo              ║
║                                       ║
║           (Optional)                  ║
║                                       ║
╚═══════════════════════════════════════╝

200px height
Rounded corners
Subtle border
```

## Photo Capture Widget (With Photo)

```
╔═══════════════════════════════════════╗
║                              [✏] [🗑] ║
║                                       ║
║         [Photo Preview]               ║
║                                       ║
║                                       ║
╚═══════════════════════════════════════╝

200px height
Edit and delete icons in frosted overlay
```

## Color Scheme

### Backgrounds
- **Primary**: `#0a0a0a` (Very dark gray)
- **Secondary**: `#1a1a1a` (Dark gray)
- **Gradient**: Linear gradient from #1a1a1a to #0a0a0a

### Frosted Glass
- **Color**: `rgba(0, 0, 0, 0.5)` to `rgba(0, 0, 0, 0.7)`
- **Blur**: `10px`
- **Border**: `rgba(255, 255, 255, 0.1)`

### Text
- **Primary**: `#FFFFFF` (White)
- **Secondary**: `rgba(255, 255, 255, 0.6)` (60% white)
- **Tertiary**: `rgba(255, 255, 255, 0.3)` (30% white)

### Borders
- **Subtle**: `rgba(255, 255, 255, 0.1)` (10% white)
- **Emphasis**: `rgba(255, 255, 255, 0.2)` (20% white)

## Animation Details

### Hero Animation
- Gallery thumbnail → Full-screen viewer
- Smooth scale and position transition
- 300ms duration

### Page Transitions
- Material route with slide animation
- Right-to-left swipe on iOS
- Bottom-to-top slide on Android

### Control Fade
- Fade in: 200ms
- Fade out: 200ms
- Toggle on tap

## Interaction Patterns

### Gallery Grid
- **Tap**: Open full-screen viewer
- **Long press**: (Future: Select mode)

### Full-Screen Viewer
- **Tap**: Toggle controls
- **Swipe left**: Next photo
- **Swipe right**: Previous photo
- **Pinch**: Zoom in/out
- **Drag (when zoomed)**: Pan around

### Buttons
- **Subtle scale**: 0.95 on press
- **Ripple effect**: Material ink splash
- **Feedback**: Haptic (if enabled)

## Responsive Behavior

### Phone (Portrait)
- 3-column grid
- Full-screen viewer
- AppBar height: 56px + safe area

### Tablet (Landscape)
- Could scale to 4-5 columns (future)
- Side-by-side comparison (future)

### Safe Areas
- Top: Status bar + AppBar
- Bottom: Home indicator (iPhone)
- Sides: Notches (if any)

## Performance Notes

- Grid uses `GridView.builder` for efficient rendering
- Images loaded on demand
- Thumbnails cached by Flutter
- Hero animations hardware-accelerated
- Blur effects use Metal/OpenGL

## Accessibility

- Large tap targets (48x48 minimum)
- High contrast text on dark backgrounds
- Clear visual hierarchy
- Semantic labels for screen readers

---

**Note**: Since this is a Flutter app, actual screenshots would need to be taken on a device or simulator. These ASCII representations show the layout and structure.
