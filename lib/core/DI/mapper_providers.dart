import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_time_tracker/data/mappers/work_log_mapper.dart';
import 'package:flutter_time_tracker/domain/mappers/i_work_log_mapper.dart';

final jiraWorkLogMapper = Provider<IWorkLogMapper>((ref) {
  return WorkLogMapper();
});