# EVA

Educational guidance for cycle notes. A Flutter client for cycle, pregnancy, fertility, PCOS, and menopause.

EVA explains patterns from what you type. It does not diagnose, and it is not a medical device.

The public web build is at https://kgyamebi.github.io/women/

```bash
flutter pub get
flutter test
flutter run -d chrome
```

The profile stays on the device. To sync with Supabase, apply `supabase/schema.sql`, enable anonymous sign-in, and run:

```bash
flutter run --dart-define=SUPABASE_URL=https://YOUR.supabase.co --dart-define=SUPABASE_ANON_KEY=YOUR_KEY
```
