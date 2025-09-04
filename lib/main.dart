import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_time_tracker/app.dart';
import 'package:flutter_time_tracker/core/DI/source_providers.dart';
import 'package:flutter_time_tracker/data/sources/local/database/database_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  // Ensure flutter is initialized before calling shared preferences
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPrefs = await SharedPreferences.getInstance();
  final database = await DatabaseService().getDatabase();

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPrefs),
        databaseProvider.overrideWithValue(database),
      ],
      child: App(),
    ),
  );
}
