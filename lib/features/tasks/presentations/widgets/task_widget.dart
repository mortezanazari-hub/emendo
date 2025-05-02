import 'package:emendo/common/helper/is_dark_mode.dart';
import 'package:emendo/core/configs/app_colors.dart';
import 'package:emendo/features/tasks/data/models/task_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TaskWidget extends StatelessWidget {
  final TaskModel task;

  const TaskWidget({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (task.workflow != null) Text(task.workflow!.name),
              Text(task.taskName),
              Row(
                children: [
                  if (task.hasDate == true)
                    Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: context.isDarkMode
                                ? DarkColors.secondBgColor
                                : LightColors.secondBgColor),
                        child: Text(
                            DateFormat('yyyy/MM/dd').format(task.dueDate!))),
                  if (task.hasTime == true) SizedBox(width: 5),
                  if (task.hasTime == true)
                    Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: context.isDarkMode
                                ? DarkColors.secondBgColor
                                : LightColors.secondBgColor),
                        child: Text(DateFormat('HH:mm').format(task.dueDate!))),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
