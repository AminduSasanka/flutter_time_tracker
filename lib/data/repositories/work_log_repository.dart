import 'dart:convert';

import 'package:flutter_time_tracker/core/constants/shared_preferences_keys.dart';
import 'package:flutter_time_tracker/data/models/work_log_model.dart';
import 'package:flutter_time_tracker/domain/entities/work_log.dart';
import 'package:flutter_time_tracker/domain/failures/unknown_failure.dart';
import 'package:flutter_time_tracker/domain/failures/work_log/work_log_not_found_failure.dart';
import 'package:flutter_time_tracker/domain/repositories/i_work_log_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WorkLogRepository implements IWorkLogRepository {
  final SharedPreferences _sharedPreferences;

  WorkLogRepository(this._sharedPreferences);

  @override
  void create(WorkLog workLog) {
    try {
      final WorkLogModel workLogModel = WorkLogModel(
        taskKey: workLog.taskKey,
        summary: workLog.summary,
        description: workLog.description,
      );
      String jsonString = jsonEncode(workLogModel.toJson());

      _sharedPreferences.setString(
        SharedPreferencesKeys.currentWorkLogKey,
        jsonString,
      );
    } catch (e, s) {
      throw UnknownFailure(
        exception: e is Exception ? e : Exception(e.toString()),
        stackTrace: s,
      );
    }
  }

  @override
  void delete() {
    try {
      _sharedPreferences.remove(SharedPreferencesKeys.currentWorkLogKey);
    } catch (e, s) {
      throw UnknownFailure(
        exception: e is Exception ? e : Exception(e.toString()),
        stackTrace: s,
      );
    }
  }

  @override
  WorkLogModel getCurrent() {
    try {
      String? jsonString = _sharedPreferences.getString(
        SharedPreferencesKeys.currentWorkLogKey,
      );

      if (jsonString == null) {
        throw WorkLogNotFoundFailure();
      }

      WorkLogModel workLogModel = WorkLogModel.fromJson(jsonDecode(jsonString));

      return workLogModel;
    } on WorkLogNotFoundFailure {
      rethrow;
    } catch (e, s) {
      throw UnknownFailure(
        exception: e is Exception ? e : Exception(e.toString()),
        stackTrace: s,
      );
    }
  }

  @override
  void update(WorkLog workLog) {
    create(workLog);
  }
}
