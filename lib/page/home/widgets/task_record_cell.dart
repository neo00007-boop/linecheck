import 'package:flutter/material.dart';
import 'package:linecheck/model/task_model.dart';
import 'package:linecheck/page/detail_page.dart';

import '../../../entity/line_info_entity.dart';
import '../../../util/navigator_utils.dart';

///已测任务的cell
class TaskRecordCell extends StatelessWidget {
  const TaskRecordCell({super.key, required this.task});

  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    task.url,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.blue, fontSize: 14),
                  ),
                ),
                Text(
                  '检测时间:2023-08-19 15:23:11',
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
          _button(
            title: '查看结果',
            onTap: () {
              LineInfoEntity entity = LineInfoEntity();
              entity.id = 1000;
              entity.url = "https://www.baidu.com";
              entity.checkTime = "";
              entity.resultOk = false;
              NavigatorUtils.push(context, DetailPage(entity: entity), valueSetter: (value) {});
            },
            bg: Colors.orangeAccent,
          ),
        ],
      ),
    );
  }

  Widget _button({
    required String title,
    required Color bg,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 90,
        height: 38,
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(19),
        ),
        alignment: Alignment.center,
        child: Text(title, style: TextStyle(fontSize: 14, color: Colors.white)),
      ),
    );
  }
}
