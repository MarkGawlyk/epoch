# Epoch

Epoch is a free, no-login, privacy-preserving habit challenge app inspired by Hard 75 style protocols. The user selects or creates a structured daily program and completes tasks across a fixed timeline. The product emphasizes strong visual polish, minimal friction, and high perceived quality.

## Core Principles

- **Zero onboarding friction**: Start using immediately without sign-up
- **Zero analytics or network calls**: No tracking, no external connections
- **Local data only**: All tasks, progress, and photos stored locally
- **Program-driven structure**: Predefined or custom challenge frameworks
- **Consistent UI rhythm and motion**: Smooth, intentional animations
- **Premium minimal dark/light themes**: Completely monochrome with frosted glass effects

## User Flow

1. Open app
2. Choose preset or create custom program
3. Begin day one
4. Complete tasks with optional progress photo
5. End-of-day locks progress
6. Failures restart or continue depending on mode
7. Program completion shows summary

## Program Types

### Hard 75 (Strict)
- Restart on fail: Missing any task resets to day 1
- Prior entries are cleared on restart
- Full commitment required

### Soft 75 (Permissive)
- No restart on fail
- Compliance percentage tracks misses
- Progress continues regardless

### Custom
- User selects tasks
- User defines duration
- User chooses restart rules (strict or permissive)

## Data Model

**Program**
- `id`: Unique identifier
- `name`: Program name
- `durationDays`: Total days in program
- `tasks`: List of Task objects
- `restartOnFail`: Boolean for restart behavior
- `startDate`: Program start date
- `endDate`: Calculated end date

**Task**
- `id`: Unique identifier
- `label`: Task description
- Binary per-day completion (no numeric inputs in v1)

**DailyEntry**
- `programId`: Reference to program
- `dayIndex`: Current day number
- `completedTasks`: List of completed task IDs
- `photoUri`: Optional progress photo path
- `failed`: Boolean flag for day failure

## Storage

- **Fully local**: No network calls or external services
- **Database**: Isar for structured data (programs and entries)
- **Settings**: Lightweight local store for user preferences
- **Photos**: Stored in app sandbox/container
- **Privacy**: All data remains on device

## UI Structure

### Start Screen
- Display preset programs (Hard 75, Soft 75)
- Custom program creation flow
- Clean, minimal layout

### Program Dashboard
- Current day display
- Compliance percentage
- Quick access to daily tasks

### Daily Screen
- Task checklist (binary completion)
- Progress photo capture
- Day completion confirmation

### Progress View
- Timeline visualization
- Photo gallery of progress shots
- Compliance statistics

### Completion Summary
- Final statistics
- Program completion celebration
- Option to start new program

## Visual Language

**Editorial Minimalism**
- Dense typography hierarchy
- Low-chroma monochrome palette
- Uniform spacing system
- Motion only where it improves affordance
- Frosted glass headers and navigation bars
- Nice fades using blurs

**Design References**
- ShadCN
- Vercel
- Linear
- Native iOS design patterns

## Technical Approach

### Platform
- **Flutter** for iOS first
- Cross-platform capable for future expansion

### Key Dependencies
- **Routing**: go_router
- **State Management**: Riverpod
- **Database**: Isar
- **Local Images**: photo_manager (for progress photo capture and gallery access)
- **Internationalization**: intl
- **Animations**: animations package
- **Hooks**: flutter_hooks

### Architecture
- No external services
- No API calls
- Pure local-first application

## Restart Logic

### Hard 75
- Any task failure triggers full reset to day 1
- Prior entries cleared from storage
- Fresh start enforced

### Soft 75
- No reset on failure
- Compliance percentage reflects all misses
- Historical data preserved

### Custom
- User configurable: choose restart or permissive behavior
- Consistent with selected mode throughout program

## Metrics (Local Only)

- **Current Day**: Active day in program
- **Compliance Percentage**: Task completion ratio
- **Task Completion Ratio**: Overall completion statistics
- **No syncing**: Everything stays local
- **No remote storage**: Complete privacy

## Privacy Stance

- **Local only**: All data on device
- **No accounts**: Zero authentication required
- **No analytics**: No usage tracking
- **No crash reporting**: No external crash services
- **No third-party SDKs**: Minimal dependencies
- **Photos in app container**: Isolated from system gallery

## Not Included in MVP

- Widgets
- Health integrations
- Export functionality
- Multiple photos per day
- Multiple concurrent programs
- Wearables integration
- Cloud backup
- Push notifications

## Planned Release Sequence

1. **MVP Experience**: Core functionality (this version)
2. **Widgets & Notifications**: Home screen widgets, daily reminders
3. **Exports & Share Cards**: Share progress, export data
4. **Health & Wearables**: Fitness app integration
5. **Multi-Program & Cloud**: Run multiple programs, optional backup

## Initial Development Tasks

The following tasks represent the core development work for the MVP:

- [ ] Implement routing with go_router
- [ ] Implement database schema and adapters with Isar
- [ ] Build start flow (preset selection and custom creation)
- [ ] Build daily tasks screen with binary completion
- [ ] Build photo capture functionality
- [ ] Build program dashboard
- [ ] Implement monochrome design system and theme
- [ ] Implement frosted glass UI elements
- [ ] Add animations and transitions

## Useful Packages

Consider these packages for implementation:
- `go_router`: Declarative routing
- `isar`: High-performance local database
- `riverpod`: Reactive state management
- `photo_manager`: Photo gallery access
- `intl`: Internationalization
- `animations`: Built-in Flutter animations
- `flutter_hooks`: Composable widget logic

## App Store Positioning

**Name**: Epoch

**Positioning**: Structured challenge protocol for habit discipline

**Pricing**: Free with no upsells in MVP

**Target Audience**:
- Fitness enthusiasts
- Self-improvement seekers
- Behavior design practitioners
- Productivity-focused individuals

**Category**: Health & Fitness / Productivity

## Getting Started

To run this Flutter app:

1. Install Flutter SDK: https://docs.flutter.dev/get-started/install
2. Clone the repository
3. Install dependencies: `flutter pub get`
4. Run the app: `flutter run`
5. Run tests: `flutter test`

## License

To be determined. Please contact the repository owner for licensing information.