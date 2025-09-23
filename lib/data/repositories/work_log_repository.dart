import 'package:flutter_time_tracker/core/constants/database.dart';
import 'package:flutter_time_tracker/core/constants/enums.dart';
import 'package:flutter_time_tracker/data/models/work_log_model.dart';
import 'package:flutter_time_tracker/domain/entities/work_log.dart';
import 'package:flutter_time_tracker/domain/failures/unknown_failure.dart';
import 'package:flutter_time_tracker/domain/failures/work_log/work_log_not_found_failure.dart';
import 'package:flutter_time_tracker/domain/repositories/i_work_log_repository.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

class WorkLogRepository implements IWorkLogRepository {
  final Database _database;

  WorkLogRepository(this._database);

  @override
  Future<WorkLogModel> getByID(int id) async {
    try {
      final workLogs = await _database.query(
        workLogsTable,
        where: 'id = ?',
        whereArgs: [id],
        limit: 1,
      );

      if (workLogs.isEmpty) {
        throw WorkLogNotFoundFailure();
      }

      return WorkLogModel.fromMap(workLogs.first);
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
  Future<int> create(WorkLog workLog) async {
    try {
      final WorkLogModel workLogModel = WorkLogModel(
        taskKey: workLog.taskKey,
        summary: workLog.summary,
        description: workLog.description,
        startTime: workLog.startTime,
        timeSpent: workLog.timeSpent,
        workLogState: workLog.workLogState,
        jiraWorkLogId: workLog.jiraWorkLogId,
      );

      return await _database.insert(workLogsTable, workLogModel.toMap());
    } catch (e, s) {
      throw UnknownFailure(
        exception: e is Exception ? e : Exception(e.toString()),
        stackTrace: s,
      );
    }
  }

  @override
  Future<void> delete(int id) async {
    try {
      await getByID(id);
      await _database.delete(workLogsTable, where: 'id = ?', whereArgs: [id]);
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
  Future<WorkLogModel> getCurrent() async {
    try {
      final currentWorkLogs = await _database.query(
        workLogsTable,
        where: 'work_log_state = ?',
        whereArgs: [WorkLogStateEnum.pending.name],
        limit: 1,
      );

      if (currentWorkLogs.isEmpty) {
        throw WorkLogNotFoundFailure();
      }

      WorkLogModel workLogModel = WorkLogModel.fromMap(currentWorkLogs.first);

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
  Future<WorkLogModel> getPausedWorkLog() async {
    try {
      final pausedWorkLogs = await _database.query(
        workLogsTable,
        where: 'work_log_state = ?',
        whereArgs: [WorkLogStateEnum.paused.name],
        limit: 1,
      );

      if (pausedWorkLogs.isEmpty) {
        throw WorkLogNotFoundFailure();
      }

      WorkLogModel workLogModel = WorkLogModel.fromMap(pausedWorkLogs.first);

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
  Future<void> update(WorkLog workLog) async {
    try {
      if (workLog.id == null) {
        throw WorkLogNotFoundFailure();
      }

      WorkLogModel workLogModel = WorkLogModel(
        id: workLog.id,
        taskKey: workLog.taskKey,
        summary: workLog.summary,
        description: workLog.description,
        startTime: workLog.startTime,
        timeSpent: workLog.timeSpent,
        workLogState: workLog.workLogState,
        jiraWorkLogId: workLog.jiraWorkLogId,
      );

      await _database.update(
        workLogsTable,
        workLogModel.toMap(),
        where: 'id = ?',
        whereArgs: [workLogModel.id],
      );
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
  Future<List<WorkLogModel>> getCompletedWorkLogs() async {
    try {
      List<Map<String, dynamic>> completedWorkLogs = await _database.query(
        workLogsTable,
        where: 'work_log_state = ?',
        whereArgs: [WorkLogStateEnum.completed.name],
      );

      if (completedWorkLogs.isEmpty) {
        return [];
      }

      List<WorkLogModel> workLogModels = completedWorkLogs
          .map((e) => WorkLogModel.fromMap(e))
          .toList();

      return workLogModels;
    } catch (e, s) {
      throw UnknownFailure(
        exception: e is Exception ? e : Exception(e.toString()),
        stackTrace: s,
      );
    }
  }

  @override
  Future<List<WorkLogModel>> getFilteredWorkLogs({
    List<WorkLogStateEnum>? states,
    String? taskKey,
    DateTime? startDate,
    String? groupBy,
  }) async {
    try {
      final whereClauses = <String>[];
      final whereArgs = <dynamic>[];

      if (states != null && states.isNotEmpty) {
        final placeholders = states.map((_) => '?').join(', ');

        whereClauses.add('work_log_state IN ($placeholders)');
        whereArgs.addAll(states.map((state) => state.name));
      }

      if (taskKey != null && taskKey != '') {
        whereClauses.add('task_key = ?');
        whereArgs.add(taskKey);
      }

      if (startDate != null) {
        whereClauses.add('date(start_time) = ?');
        whereArgs.add(DateFormat('yyyy-MM-dd').format(startDate));
      }

      final whereString = whereClauses.join(' AND ');
      final List<Map<String, dynamic>> filteredWorkLogs = await _database.query(
        workLogsTable,
        where: whereString.isEmpty ? null : whereString,
        whereArgs: whereArgs.isEmpty ? null : whereArgs,
        orderBy: 'start_time DESC',
      );

      return filteredWorkLogs.map((e) => WorkLogModel.fromMap(e)).toList();
    } catch (e, s) {
      throw UnknownFailure(
        exception: e is Exception ? e : Exception(e.toString()),
        stackTrace: s,
      );
    }
  }

  @override
  Future<void> bulkDeleteWorkLogs(List<int> ids) async {
    if (ids.isEmpty) return;

    try {
      final placeholders = List.filled(ids.length, '?').join(', ');

      await _database.delete(
        workLogsTable,
        where: 'id IN ($placeholders)',
        whereArgs: ids,
      );
    } catch (e, s) {
      throw UnknownFailure(
        exception: e is Exception ? e : Exception(e.toString()),
        stackTrace: s,
      );
    }
  }

  @override
  Future<List<WorkLog>> getByIDList(List<int> ids) async {
    try {
      if (ids.isEmpty) return [];

      final placeholders = List.filled(ids.length, '?').join(', ');
      final workLogs = await _database.query(
        workLogsTable,
        where: 'id IN ($placeholders)',
        whereArgs: ids,
      );
      final workLogModels = workLogs.map(
        (workLog) => WorkLogModel.fromMap(workLog),
      );

      return workLogModels
          .map((workLogModel) => workLogModel.toEntity())
          .toList();
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
  Future<List<WorkLogModel>> getTodayWorkLogs() async {
    try {
      final List<Map<String, dynamic>> workLogsModels = await _database.query(
        workLogsTable,
        where: 'date(start_time) = ? AND work_log_state IN (?, ?)',
        whereArgs: [
          DateFormat('yyyy-MM-dd').format(DateTime.now()),
          WorkLogStateEnum.synced.name,
          WorkLogStateEnum.completed.name,
        ],
        orderBy: 'start_time DESC',
      );

      return workLogsModels.map((e) => WorkLogModel.fromMap(e)).toList();
    } catch (e, s) {
      throw UnknownFailure(
        exception: e is Exception ? e : Exception(e.toString()),
        stackTrace: s,
      );
    }
  }

  @override
  Future<List<WorkLogModel>> getWorkLogsByDates(
    DateTime startDate,
    DateTime endDate,
  ) async {
    try {
      final List<Map<String, dynamic>> workLogsModels = await _database.query(
        workLogsTable,
        where: 'date(start_time) >= ? AND date(start_time) <= ? AND work_log_state IN (?, ?)',
        whereArgs: [
          DateFormat('yyyy-MM-dd').format(startDate),
          DateFormat('yyyy-MM-dd').format(endDate),
          WorkLogStateEnum.synced.name,
          WorkLogStateEnum.completed.name,
        ],
        orderBy: 'start_time DESC',
      );

      return workLogsModels.map((e) => WorkLogModel.fromMap(e)).toList();
    } catch (e, s) {
      throw UnknownFailure(
        exception: e is Exception ? e : Exception(e.toString()),
        stackTrace: s,
      );
    }
  }
}
