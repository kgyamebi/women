import 'dart:convert';

import 'package:eva_ai/domain/health_models.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class HealthRepository {
  Future<HealthProfile?> load();
  Future<void> save(HealthProfile profile);
  Future<void> clear();
}

class LocalHealthRepository implements HealthRepository {
  static const storageKey = 'eva.profile.v1';

  @override
  Future<HealthProfile?> load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(storageKey);
    if (raw == null || raw.isEmpty) return null;
    final decoded = jsonDecode(raw);
    if (decoded is! Map) return null;
    return HealthProfile.fromJson(decoded.map((key, value) => MapEntry(key.toString(), value)));
  }

  @override
  Future<void> save(HealthProfile profile) async {
    final prefs = await SharedPreferences.getInstance();
    final current = await load();
    if (saveWouldOverwriteNewer(current, profile)) {
      throw StateError('A newer profile is already stored on this device.');
    }
    await prefs.setString(storageKey, jsonEncode(profile.compacted().toJson()));
  }

  @override
  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(storageKey);
  }
}

class SupabaseHealthRepository implements HealthRepository {
  SupabaseHealthRepository(this.client);

  final SupabaseClient client;

  Future<String> _userId() async {
    final current = client.auth.currentUser;
    if (current != null) return current.id;
    final response = await client.auth.signInAnonymously();
    final id = response.user?.id;
    if (id == null) {
      throw StateError('Supabase anonymous sign-in is unavailable.');
    }
    return id;
  }

  @override
  Future<HealthProfile?> load() async {
    final userId = await _userId();
    final row = await client.from('profiles').select('payload').eq('id', userId).maybeSingle();
    final payload = row?['payload'];
    if (payload is Map<String, dynamic>) return HealthProfile.fromJson(payload);
    if (payload is Map) {
      return HealthProfile.fromJson(payload.map((key, value) => MapEntry(key.toString(), value)));
    }
    return null;
  }

  @override
  Future<void> save(HealthProfile profile) async {
    final userId = await _userId();
    final current = await load();
    if (saveWouldOverwriteNewer(current, profile)) {
      throw StateError('A newer profile is already stored.');
    }
    await client.from('profiles').upsert({
      'id': userId,
      'payload': profile.compacted().toJson(),
      'updated_at': DateTime.now().toUtc().toIso8601String(),
    });
  }

  @override
  Future<void> clear() async {
    final userId = await _userId();
    await client.from('profiles').delete().eq('id', userId);
    await client.auth.signOut();
  }
}

class EvaBackend {
  const EvaBackend._();

  static const url = String.fromEnvironment('SUPABASE_URL');
  static const anonKey = String.fromEnvironment('SUPABASE_ANON_KEY');
  static bool get enabled => url.isNotEmpty && anonKey.isNotEmpty;
}
