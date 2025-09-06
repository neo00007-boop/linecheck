import 'package:linecheck/entity/line_info_entity.dart';
import 'package:linecheck/index.dart';
import 'detail-page.dart';

class MainTabPage extends StatefulWidget {
  const MainTabPage({super.key});

  @override
  State<MainTabPage> createState() => _MainTabPageState();
}

class _MainTabPageState extends State<MainTabPage> {
  @override
  void initState() {
    super.initState();
    Future<void>.delayed(Duration(seconds: 2), () {
      LineInfoEntity entity = LineInfoEntity();
      entity.id = 1000;
      entity.url = "https://www.baidu.com";
      entity.checkTime = "";
      entity.resultOk = false;
      NavigatorUtils.push(context, DetailPage(entity: entity), valueSetter: (value) {});
    });
  }

  @override
  Widget build(BuildContext context) {
    // body: Text("我是主页", style: TextStyle(fontSize: 40, color: Colors.red)),
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [_buildAppbar(), _buildCheckCountView()],
        ),
      ),
    );
  }

  _buildCheckCountView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(width: 16),
        Text("今日待检测: 999", style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal)),
        SizedBox(width: 20),
        Text("今日已检测: 888", style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal)),
      ],
    );
  }

  _buildAppbar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("检测线路", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Row(
            children: [
              const Image(
                width: 48,
                height: 48,
                image: AssetImage(Assets.assetsIcUser), // 本地图片
              ),
              SizedBox(width: 8),
              Text("${UserInfoProvider.login.nickname}", style: Theme
                  .of(context)
                  .textTheme
                  .bodyMedium),
            ],
          ),
        ],
      ),
    );
  }
}
