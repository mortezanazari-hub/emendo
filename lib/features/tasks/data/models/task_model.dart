import 'package:emendo/features/tasks/data/models/workflows_model.dart';
import 'package:flutter/cupertino.dart';

class TaskModel {
  final String taskName;
  final List<TaskModel>? subTasks;
  final WorkflowsModel? workflow;
  final bool? hasDate;
  final DateTime? dueDate;
  final bool? hasTime;
  final DateTime? dueTime;
  final bool? hasNotification;

  TaskModel(
    this.taskName, {
    this.workflow,
    this.subTasks,
    this.hasDate,
    this.dueDate,
    this.hasTime,
    this.dueTime,
    this.hasNotification,
  });
}
