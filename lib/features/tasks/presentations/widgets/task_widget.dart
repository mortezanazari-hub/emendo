import 'package:emendo/common/helper/is_dark_mode.dart';
import 'package:emendo/common/widgets/custom_check_box.dart';
import 'package:emendo/core/configs/app_colors.dart';
import 'package:emendo/core/configs/app_text_styles.dart';
import 'package:emendo/features/tasks/data/models/task_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TaskWidget extends StatefulWidget {
  final TaskModel task;

  const TaskWidget({
    super.key,
    required this.task,
  });

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  late bool totalCounter;

  @override
  void initState() {
    totalCounter = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color borderColor =
        context.isDarkMode ? DarkColors.activeBorder : LightColors.activeBorder;
    if (widget.task.isDone) {
      borderColor = context.isDarkMode
          ? DarkColors.disableBorder
          : LightColors.disableBorder;
    }
    Color primeColor =
        context.isDarkMode ? DarkColors.primeColor : LightColors.primeColor;
    if (widget.task.isDone) {
      primeColor = context.isDarkMode
          ? DarkColors.primeDisableColor
          : LightColors.primeDisableColor;
    }
    Color secondBgColor = context.isDarkMode
        ? DarkColors.secondBgColor
        : LightColors.secondBgColor;
    if (widget.task.isDone) {
      secondBgColor = context.isDarkMode
          ? DarkColors.secondBgDisableColor
          : LightColors.secondBgDisableColor;
    }
    Color titleColor =
        context.isDarkMode ? DarkColors.thirdText : LightColors.thirdText;
    if (widget.task.isDone) {
      titleColor =
          context.isDarkMode ? DarkColors.fourText : LightColors.fourText;
    }

    String taskCounter = totalCounter
        ? "${widget.task.getCompletedSubTaskCount()} / ${widget.task.getTotalSubTaskCount()}"
        : "${widget.task.getDirectCompletedSubTaskCount()} / ${widget.task.getDirectSubTaskCount()}";
    double presentCompleted = totalCounter
        ? (widget.task.getCompletedSubTaskCount() /
            widget.task.getTotalSubTaskCount())
        : (widget.task.getDirectCompletedSubTaskCount() /
            widget.task.getDirectSubTaskCount());

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 1, color: borderColor),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.task.workflow != null)
                  Text(
                    widget.task.workflow!.name,
                    style: AppTextStyles.base(
                      context: context,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                      color: titleColor,
                    ),
                  ),
                Text(
                  widget.task.taskName,
                  style: AppTextStyles.base(
                    context: context,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primeColor,
                  ),
                  maxLines: null, // تعداد خطوط نامحدود
                  overflow: TextOverflow.clip, // برای اینکه متن بریده نشود
                ),
                Wrap(
                  // استفاده از Wrap
                  spacing: 3, // فاصله بین ویجت ها
                  children: [
                    if (widget.task.hasDate == true)
                      Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: secondBgColor),
                        child: Text(
                          DateFormat('yyyy/MM/dd').format(widget.task.dueDate!),
                          style: AppTextStyles.base(
                            context: context,
                            fontSize: 8,
                            color: primeColor,
                          ),
                        ),
                      ),
                    if (widget.task.hasTime == true)
                      Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: secondBgColor),
                        child: Text(
                          DateFormat('HH:mm').format(widget.task.dueDate!),
                          style: AppTextStyles.base(
                            context: context,
                            fontSize: 8,
                            color: primeColor,
                          ),
                        ),
                      ),
                    if (widget.task.hasNotification == true &&
                        widget.task.hasTime == true)
                      Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: secondBgColor),
                        child: Icon(
                          Icons.notifications,
                          size: 12,
                          color: primeColor,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 15),
          if (widget.task.subTasks.isEmpty)
            CustomCheckBox(
              widget.task.isDone,
              onChanged: (value) {
                setState(() {
                  widget.task.toggleDone();
                });
              },
            ),
          if (widget.task.subTasks.isNotEmpty)
            InkWell(
              onTap: () {
                setState(() {
                  totalCounter = !totalCounter;
                });
              },
              child: Row(
                children: [
                  SizedBox(
                    width: 15,
                    height: 15,
                    child: CircularProgressIndicator(
                      backgroundColor: secondBgColor,
                      value: presentCompleted,
                      strokeWidth: 1,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(taskCounter),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
