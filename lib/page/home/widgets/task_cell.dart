import 'package:flutter/material.dart';
import 'package:linecheck/common/button.dart';
import 'package:linecheck/model/task_model.dart';

///今日任务的cell
class TaskCell extends StatelessWidget {
  const TaskCell({super.key, required this.task});

  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              task.url,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.blue, fontSize: 12),
            ),
          ),
          Button(
            text: task.isDone ? '检测完成' : '开始检测',
            disabled: task.isDone,
            height: 30,
            width: 90,
          ),
        ],
      ),
    );
  }
}
