import 'package:emendo/common/widgets/custom_app_bar.dart';
import 'package:emendo/features/home/presentations/widgets/workflow_title_show.dart';
import 'package:emendo/features/tasks/data/local/fake_workflow_db.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leadingWidget: IconButton(
          onPressed: () {},
          icon: Icon(Icons.search),
        ),
        title: WorkflowTitleShow(
          workflowName: FakeWorkflowDb.getWorkflows[0].name,
        ),
        actionButton: IconButton(
          onPressed: () {},
          icon: Icon(Icons.calendar_month),
        ),
      ),
    );
  }
}
