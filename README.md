# RoadBandhu™ (India's 24×7 Highway & Mountain Rescue Ecosystem)
[![Flutter](https://img.shields.io/badge/Flutter-3.50.1-blue.svg)](https://flutter.dev)
[![Platforms](https://img.shields.io/badge/Platforms-Android%20%7C%20iOS%20%7C%20Web%20%7C%20Windows%20%7C%20macOS%20%7C%20Linux-green.svg)](https://flutter.dev)
[![License](https://img.shields.io/badge/License-Proprietary-red.svg)]()

RoadBandhu™ is an enterprise-grade roadside emergency and mountain rescue ecosystem engineered specifically for India's rugged mountainous corridors (Uttarakhand, Himachal Pradesh, Jammu & Kashmir, Ladakh, North-East) and Pan-India highways.

---

## 🌟 Key Features

1. **48 Production-Grade Screen Flows**: Exactly matching all reference design specifications.
2. **Offline SOS Queue Engine (No-Network Resilience)**:
   - Queues emergency dispatches locally on device when trapped in zero-signal mountain valleys.
   - Automatically synchronizes when signal returns.
   - Built-in **Emergency SMS Fallback** sending encrypted GPS coordinates to 112/dispatch via standard cellular SMS.
3. **Unified Single-App Architecture**:
   - Both **Help Seekers (Customers)** and **Service Providers (Mechanics, Towing Drivers, Rescue Squads, Fleet Admins)** operate within one application with seamless role switching.
4. **Dynamic Bilingual Localization**:
   - Default Language: **English**.
   - Dynamic 1-tap switch to **Hindi (हिंदी)** across every single screen, title, button, and description.
5. **No Emojis as Icons**:
   - 100% professional vector iconography, custom Flutter Canvas painters (snow-capped mountain silhouette, emergency beacon glow, route polylines), and Material symbols.
6. **Adaptive Light & Dark Mode**:
   - Mountain Deep Navy (`#0D1B2A`), Alpine Slate (`#1E293B`), Emergency Crimson Red (`#E53935`), Snow White (`#FFFFFF`).
7. **Free-Tier Infrastructure Ready**:
   - Supabase / Firebase free tier for database & authentication.
   - OpenStreetMap / CartoDB via `flutter_map` for zero-cost map tile rendering.
   - Cloud CI/CD (GitHub Actions) for compiling iOS builds without owning a Mac hardware.

---

## 📱 Screen Breakdown (All 48 Screens)

### Flow 1: Onboarding, Language & Identity (Screens 1 to 8)
- `1. Splash Screen`: Mountain logo with glowing rescue beacon.
- `2. Welcome Screen`: Hero carousel of 6 primary roadside services.
- `3. Language Selection`: English (Default) vs Hindi (हिंदी) dynamic switcher.
- `4. Create Account`: Indian phone (+91), name, email, password checklist rules.
- `5. Login Screen`: Dual-tab Phone / Email login with social sign-ins.
- `6. 6-Digit OTP Verification`: Auto-focus PIN boxes with resend countdown timer.
- `7. Personal Details`: Avatar photo, Date of Birth, Gender, State & City selectors.
- `8. Vehicle Details`: Vehicle type, registration number (e.g. `UK07BX1234`), Make, Model, Fuel type.

### Flow 2: Emergency SOS & Rescue Request (Screens 9 to 16)
- `9. Home Dashboard`: Emergency hero SOS banner, mountain weather & landslide warning card, 6-service grid, bottom navigation.
- `10. All Services Directory`: Full directory of 10 roadside rescue utilities.
- `11. Emergency SOS Trigger`: 3-second interactive Press & Hold safety button with circular progress animation.
- `12. Accident & Medical Support`: Collision, rollover, injury checklist + voice note recording memo.
- `13. Mountain Rescue Portal`: High altitude, landslide, snowfall, cliff winch extraction.
- `14. Confirm GPS Location`: Map pinpoint with NH-7 Chamoli Badrinath reverse geocoding.
- `15. Nearby Help Selection`: Ranked list of verified mechanics, rescue squads, and 108 ambulance units.
- `16. Rescue Confirmation`: Unique Ticket ID (`RR-784532`), live ETA countdown, direct call/chat shortcuts.

### Flow 3: Live Rescue Tracking & Communication (Screens 17 to 24)
- `17. Live Rescue Tracking`: Moving rescuer map, polyline route, live ETA badge, quick call/chat bottom sheet.
- `18. Assigned Mechanic Profile`: Verified technician badge, 8+ years experience, service area and specializations.
- `19. In-App VoIP Voice Call`: Real-time calling UI with audio waveform bars, mute, speaker, keypad, timer (`00:12`).
- `20. In-App Video Diagnostic Call`: Live WebRTC video feed to point camera at smoking engine or terrain ditch.
- `21. In-App Real-time Chat`: Messaging interface with photo sharing (dashboard warning lights) and timestamps.
- `22. Full Route & Terrain Map`: Elevation profile, hairpin curve warnings, NH-7 corridor details.
- `23. Service Completion & Invoice`: ₹800 invoice breakdown, diagnostic verification checklist.
- `24. Rating & Review`: 5 interactive stars, quick tag pills (*"Quick Service"*, *"Mountain Expert"*), feedback box.

### Flow 4: Mountain Roadside Utilities & Safety (Screens 25 to 32)
- `25. Towing Service`: Flatbed, off-road winch, accident recovery, long distance towing.
- `26. Emergency Fuel Delivery`: Petrol, Diesel, Winter-grade Diesel, CNG canister delivery.
- `27. Battery Jump Start`: High-altitude cold start booster, health test, battery replacement.
- `28. Tyre Puncture Assistance`: Tubeless repair, spare wheel fitment, tyre replacement.
- `29. Nearby Hospital & Ambulance`: Chamoli District Hospital locator, direct 108 ambulance dialer.
- `30. Roadblock & Landslide Alerts`: Real-time crowdsourced & police road closure feed with High/Medium/Low severity.
- `31. Mountain Weather & Safety`: Real-time mountain temperatures (-2°C snow), avalanche advisories, travel tips.
- `32. Safe Route Navigation Planner`: Rishikesh → Badrinath safest route calculation avoiding landslides and blocked passes.

### Flow 5: Digital Garage, Wallet & Offline Lifeline (Screens 33 to 40)
- `33. My Vehicles`: Multi-vehicle garage (Hyundai Creta, Royal Enfield), maintenance reminders.
- `34. Service History`: Past rescue logs with downloadable PDF invoices.
- `35. Document Locker`: AES-256 encrypted storage for Driving License, RC, Insurance, PUC.
- `36. Road Rescue Wallet & UPI`: Balance card (₹1,250.00), Add/Send/Withdraw, UPI QR code.
- `37. Cards & Transactions`: Saved Visa cards, debit/credit transaction ledger.
- `38. Premium Membership`: Priority dispatch, free towing quotas, monthly (₹199) and yearly (₹1,499) tiers.
- `39. Emergency Contacts`: Family contact sync with automated SMS emergency notification.
- `40. Offline SOS Queue Engine`: Zero-network local storage buffer + native emergency SMS fallback.

### Flow 6: Profile, Settings, Partner Hub & Admin Fleet (Screens 41 to 48)
- `41. User Profile Hub`: Member since date, verified badge, quick navigation menu.
- `42. Notification Preferences`: Push, SMS, Email toggles for emergency vs promotional alerts.
- `43. Privacy & 2FA Security`: Two-Factor authentication, biometric unlock, login sessions.
- `44. Help Centre & FAQs`: Searchable knowledgebase, survival guides, support ticket.
- `45. 24×7 Emergency Helpline`: `1800-123-ROAD (7623)` direct dialer & live agent chat.
- `46. Partner Registration`: In-app onboarding for local mechanics, towing drivers, and rescue fleets.
- `47. Admin & Fleet Operations Dashboard`: Real-time dispatch controller (1,248 active requests, 486 partners, live map).
- `48. Emergency Incident History`: Complete lifecycle audit of past emergencies.

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.24+ recommended)
- Dart SDK
- Android Studio / VS Code with Flutter extension
- Connected Android/iOS device or emulator

### Installation & Running
```bash
# 1. Clone repository
git clone https://github.com/KaminiThayat/RoadBandhu.git
cd RoadBandhu

# 2. Install dependencies
flutter pub get

# 3. Run on connected device
flutter run
```

### Production Build
```bash
# Build Android Release APK
flutter build apk --release

# Build Android App Bundle (Play Store)
flutter build appbundle
```

---

## 🛠️ Verification
- Static Analysis: `flutter analyze` passed with **0 issues**.
- Unit & Widget Tests: `flutter test` passed (**100% passing**).
