import 'package:emendo/features/tasks/data/local/fake_workflow_db.dart';
import 'package:emendo/features/tasks/data/models/task_model.dart';

class FakeTasksDb {
  static List<TaskModel> getTasks = [
    TaskModel(
      "task1",
      hasDate: true,
      dueDate: DateTime.now(),
      hasTime: true,
      hasNotification: true,
      workflow: FakeWorkflowDb.getWorkflows[0],
    ),
    TaskModel(
      "task2 is a simple task with a long name",
    ),
    TaskModel(
      "task3 has date",
      hasDate: true,
      dueDate: DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
      ),
    ),
    TaskModel(
      "task4 has date and time",
      hasDate: true,
      dueDate: DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
      ),
      hasTime: true,
    ),
    TaskModel(
      "task5 has workflow",
      workflow: FakeWorkflowDb.getWorkflows[2],
    ),
    TaskModel(
      "task6 has workflow and date",
      workflow: FakeWorkflowDb.getWorkflows[1],
      hasDate: true,
      dueDate: DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
      ),
    ),
    TaskModel(
      "task7 has subtasks",
      subTasks: [
        TaskModel("subTask1", subTasks: [
          TaskModel("sub subtask1"),
          TaskModel("sub subtask2"),
          TaskModel("sub subtask3"),
        ]),
        TaskModel("sub Task2")
      ],
    ),
    TaskModel(
      "task8 has subtask and date",
      hasDate: true,
      dueDate: DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
      ),
      subTasks: [
        TaskModel("subTask1", subTasks: [
          TaskModel("sub subtask1", isDone: true, subTasks: [
            TaskModel("task1"),
            TaskModel("task1"),
            TaskModel("task1"),
            TaskModel("task1"),
            TaskModel("task1"),
          ]),
          TaskModel("sub subtask2"),
          TaskModel("sub subtask3"),
        ]),
        TaskModel("sub Task2")
      ],
    ),
    TaskModel(
      "task9 has subtask and date and workflow",
      workflow: FakeWorkflowDb.getWorkflows[1],
      hasDate: true,
      dueDate: DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
      ),
      subTasks: [
        TaskModel("subTask1", subTasks: [
          TaskModel("sub subtask1", isDone: true),
          TaskModel("sub subtask2", isDone: true),
          TaskModel("sub subtask3"),
        ]),
        TaskModel("sub Task2")
      ],
    ),
  ];
}
