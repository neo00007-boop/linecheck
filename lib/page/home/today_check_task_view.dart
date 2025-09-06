import 'dart:math';
import 'package:flutter/material.dart';
import 'package:linecheck/generated/app_colors.dart';
import 'package:linecheck/model/task_model.dart';
import 'package:linecheck/page/home/widgets/task_cell.dart' hide Colors;

///今日检测
class TodayCheckTaskView extends StatefulWidget {
  const TodayCheckTaskView({super.key});

  @override
  State<TodayCheckTaskView> createState() => _TodayCheckTaskViewState();
}

class _TodayCheckTaskViewState extends State<TodayCheckTaskView>
    with AutomaticKeepAliveClientMixin {
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
      list = tasks; // 更新状态以反映新生成的任务列表
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      margin: EdgeInsets.fromLTRB(12, 12, 12, 0),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Column(
        children: [
          _titleText(),
          Expanded(child: _listView()),
        ],
      ),
    );
  }

  Widget _titleText() {
    return Container(
      color: Colors.grey.shade100,
      height: 44,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 12),
          Text(
            "今日待检测: ",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
          ),
          Text(
            "999",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.normal,
              color: Colors.orange,
            ),
          ),
          SizedBox(width: 20),
          Text(
            "今日已检测: ",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
          ),
          Text(
            "111",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.normal,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _listView() {
    return ListView.separated(
      separatorBuilder: (_,index){
        return Divider(
          color: Colors.grey.shade100,
          height: 1,
          thickness: 1,
        );
      },
      padding: EdgeInsets.only(bottom: 30, left: 12, right: 12),
      itemCount: list.length,
      itemBuilder: (_, index) {
        final item = list[index];
        return TaskCell(task: item);
      },
    );
  }
}
