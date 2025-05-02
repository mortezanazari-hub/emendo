import 'package:emendo/features/tasks/data/models/workflows_model.dart';

class TaskModel {
  final String taskName;
  final List<TaskModel>? subTasks;
  final WorkflowsModel? workflow;
  final bool? hasDate;
  final DateTime? dueDate;
  final bool? hasTime;
  final bool? hasNotification;

  TaskModel(
    this.taskName, {
    this.workflow,
    this.subTasks,
    this.hasDate,
    this.dueDate,
    this.hasTime,
    this.hasNotification,
  });
}
