class TaskModel {
  final String id;
  final String url;

  //0 等待 1 完成
  final int status;

  bool get isDone => status == 1;

  TaskModel(this.url, {required this.id, required this.status});
}
