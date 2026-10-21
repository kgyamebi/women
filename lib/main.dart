import 'package:eva_ai/app/eva_app.dart';
import 'package:eva_ai/data/health_repository.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HealthRepository repository = LocalHealthRepository();
  if (EvaBackend.enabled) {
    await Supabase.initialize(url: EvaBackend.url, publishableKey: EvaBackend.anonKey);
    repository = SupabaseHealthRepository(Supabase.instance.client);
  }
  runApp(EvaApp(repository: repository));
}
