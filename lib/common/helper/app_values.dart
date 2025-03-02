import 'package:emendo/features/tasks/data/local/fake_workflow_db.dart';
import 'package:emendo/features/tasks/data/models/workflows_model.dart';

class AppValues {
  static WorkflowsModel currentWorkflow = FakeWorkflowDb.getWorkflows[0];
}
