import 'package:emendo/features/tasks/data/models/workflows_model.dart';

class FakeWorkflowDb {
  static List<WorkflowsModel> getWorkflows = [
    WorkflowsModel(name: "Default"),
    WorkflowsModel(name: "General"),
    WorkflowsModel(name: "University"),
    WorkflowsModel(name: "Project one"),
  ];
}
