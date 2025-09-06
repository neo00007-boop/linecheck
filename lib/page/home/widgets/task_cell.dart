import 'package:linecheck/entity/line_info_entity.dart';
import 'package:linecheck/index.dart';
import 'package:linecheck/model/task_model.dart';
import 'package:linecheck/page/detail_page.dart';

///今日任务的cell
class TaskCell extends StatelessWidget {
  const TaskCell({super.key, required this.task});

  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              task.url,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: task.isDone ? Colors.lightBlueAccent : Colors.orange,
                fontSize: 14,
              ),
            ),
          ),
          _button(
            onTap: () {
              if (!task.isDone) {
                //Future<void>.delayed(Duration(seconds: 2), () {
                  LineInfoEntity entity = LineInfoEntity();
                  entity.id = 1000;
                  entity.url = "https://www.baidu.com";
                  entity.checkTime = "";
                  entity.resultOk = false;
                  NavigatorUtils.push(context, DetailPage(entity: entity), valueSetter: (value) {});
                //});
                  NavigatorUtils.push(
                    context,
                    DetailPage(entity: entity),
                    valueSetter: (value) {},
                  );
                }
              },
            title: task.isDone ? '检测完成' : '开始检测',
            bg: task.isDone ? Colors.blue : Color(0xFFFD7200),
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
