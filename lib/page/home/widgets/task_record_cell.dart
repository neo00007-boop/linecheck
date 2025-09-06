import 'package:flutter/material.dart';
import 'package:linecheck/common/button.dart';
import 'package:linecheck/model/task_model.dart';

import '../../../entity/line_info_entity.dart';
import '../../../util/navigator_utils.dart';
import '../../detail-page.dart';

///已测任务的cell
class TaskRecordCell extends StatelessWidget {
  const TaskRecordCell({super.key, required this.task});

  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Text(
                    task.url,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.blue, fontSize: 12),
                  ),
                ),
                Text(
                  '检测时间:2023-08-19 15:23:11',
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
          Button(text: '查看结果', disabled: false, height: 30, width: 90,onPressed: (){
            //Future<void>.delayed(Duration(seconds: 2), () {
              LineInfoEntity entity = LineInfoEntity();
              entity.id = 1000;
              entity.url = "https://www.baidu.com";
              entity.checkTime = "";
              entity.resultOk = false;
              NavigatorUtils.push(context, DetailPage(entity: entity), valueSetter: (value) {});
            //});
          },),
        ],
      ),
    );
  }
}
