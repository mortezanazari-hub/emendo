import 'package:flutter/material.dart';

class WorkflowTitleShow extends StatelessWidget {
  final String workflowName;
  final void Function()? onTap;

  const WorkflowTitleShow({required this.workflowName, super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Ink(
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Icon(Icons.arrow_drop_down), Text(workflowName)],
        ),
      ),
    );
  }
}
