import 'package:emendo/features/tasks/data/models/workflows_model.dart';

class TaskModel {
  final String taskName;
  late List<TaskModel> subTasks;
  final WorkflowsModel? workflow;
  final bool? hasDate;
  final DateTime? dueDate;
  final bool? hasTime;
  final bool? hasNotification;
  late bool isDone;

  TaskModel(
    this.taskName, {
    this.workflow,
    List<TaskModel>? subTasks,
    this.hasDate,
    this.dueDate,
    this.hasTime,
    this.hasNotification,
    this.isDone = false,
  }) : subTasks = subTasks ?? [];

  int getTotalSubTaskCount() {
    int count = 0;

    for (var subTask in subTasks) {
      count++;
      count += subTask.getTotalSubTaskCount();
    }

    return count;
  }

  int getDirectSubTaskCount() {
    return subTasks.length;
  }

  int getCompletedSubTaskCount() {
    int completedCount = 0;

    if (isDone == true) {
      completedCount++;
    }

    for (var subTask in subTasks) {
      completedCount += subTask.getCompletedSubTaskCount();
    }

    return completedCount;
  }

  int getDirectCompletedSubTaskCount() {
    int directCompletedCount = 0;
    for (var subTask in subTasks) {
      if (subTask.isDone == true) {
        directCompletedCount++;
      }
    }
    return directCompletedCount;
  }

  void markAsDone() {
    if (subTasks.isNotEmpty &&
        (getCompletedSubTaskCount() == getTotalSubTaskCount())) {
      isDone = true;
    }
  }

  void toggleDone() {
    isDone = !isDone;
    if (subTasks.isNotEmpty) {
      markAsDone();
    }
  }
}