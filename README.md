# EVA AI

Your personal women's health intelligence. A Flutter client for cycle, pregnancy, fertility, PCOS, menopause, and a context-aware health copilot.

EVA explains patterns. It does not diagnose.

```bash
flutter pub get
flutter test
flutter run -d chrome
```

The profile stays on the device. To sync with Supabase, apply `supabase/schema.sql`, enable anonymous sign-in, and run:

```bash
flutter run --dart-define=SUPABASE_URL=https://YOUR.supabase.co --dart-define=SUPABASE_ANON_KEY=YOUR_KEY
```
