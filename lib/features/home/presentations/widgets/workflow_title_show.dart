import 'package:flutter/material.dart';

class WorkflowTitleShow extends StatelessWidget {
  final String workflowName;

  const WorkflowTitleShow({required this.workflowName, super.key});

  @override
  Widget build(BuildContext context) {
    return Ink(
      child: InkWell(
        onTap: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Icon(Icons.arrow_drop_down), Text(workflowName)],
        ),
      ),
    );
  }
}
