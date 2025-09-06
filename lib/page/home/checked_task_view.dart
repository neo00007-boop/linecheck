import 'package:flutter/cupertino.dart';

import 'dart:math';

import 'package:linecheck/model/task_model.dart';
import 'package:linecheck/page/home/widgets/task_record_cell.dart';

///已检测
class CheckedTaskView extends StatefulWidget {
  const CheckedTaskView({super.key});

  @override
  State<CheckedTaskView> createState() => _CheckedTaskViewState();
}

class _CheckedTaskViewState extends State<CheckedTaskView> with AutomaticKeepAliveClientMixin {
  List<TaskModel> list = [];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _initData();
  }

  void _initData() {
    List<TaskModel> tasks = [];
    Random random = Random();
    const baseUrl = 'https://example.com/test/';
    const randomWords = [
      'short',
      'medium-length-path',
      'thisIsAReallyLongPathWithLotsOfCharacters',
      'tiny',
      'longerPathThanUsual',
      'anotherShort',
      'uniquePath1234567890',
    ];

    for (int i = 0; i < 40; i++) {
      String id = 'task_$i';
      // 通过随机选择生成多样的 URL
      String url = baseUrl + randomWords[random.nextInt(randomWords.length)];

      int status = random.nextBool() ? 0 : 1; // 随机生成状态 0 或 1
      tasks.add(TaskModel(url, id: id, status: status));
    }

    setState(() {
      list = tasks;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _listView();
  }

  Widget _listView() {
    return ListView.builder(
      padding: EdgeInsets.only(bottom: 30, left: 12, right: 12, top: 12),
      itemCount: list.length,
      itemBuilder: (_, index) {
        final item = list[index];
        return TaskRecordCell(task: item);
      },
    );
  }
}
