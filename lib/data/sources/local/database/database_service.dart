import 'package:flutter_time_tracker/core/constants/database.dart';
import 'package:flutter_time_tracker/data/sources/local/database/i_database_service.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService implements IDatabaseService {
  static Database? _database;

  DatabaseService();

  @override
  Future<Database> getDatabase() async {
    if (_database != null) {
      return _database!;
    }

    try {
      _database = await _initDatabase();

      return _database!;
    } catch (e) {
      rethrow;
    }
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), databaseName);

    return await openDatabase(
      path,
      version: databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE work_logs (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        task_key TEXT NOT NULL,
        summary TEXT NOT NULL,
        description TEXT,
        time_spent TEXT,
        start_time TEXT,
        work_log_state TEXT NOT NULL,
        jira_work_log_id TEXT
      )
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    print('Upgrading database from version $oldVersion to $newVersion');

    for (int version = oldVersion + 1; version <= newVersion; version++) {
      await _runMigration(db, version);
    }
  }

  Future<void> close() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }

  Future<void> deleteDatabase() async {
    String path = join(await getDatabasesPath(), databaseName);
    await databaseFactory.deleteDatabase(path);
    _database = null;
  }

  Future<void> _runMigration(Database db, int version) async {
    switch (version) {
      case 1:
        break;

      case 2:
        await _migrateToVersion2(db);
        break;

      default:
        print('No migration defined for version $version');
    }
  }

  Future<void> _migrateToVersion2(Database db) async {
    await db.execute('''
      ALTER TABLE work_logs
      ADD COLUMN jira_work_log_id TEXT
    ''');
  }
}
