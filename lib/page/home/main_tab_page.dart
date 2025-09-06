import 'package:linecheck/common/button.dart';
import 'package:linecheck/common/my_tooltip.dart';
import 'package:linecheck/index.dart';
import 'package:linecheck/page/home/checked_task_view.dart';
import 'package:linecheck/page/home/today_check_task_view.dart';

class MainTabPage extends StatefulWidget {
  const MainTabPage({super.key});

  @override
  State<MainTabPage> createState() => _MainTabPageState();
}

class _MainTabPageState extends State<MainTabPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      backgroundColor: Color(0xFFF0F0F0),
      body: _buildCheckCountView(),
    );
  }

  _buildCheckCountView() {
    return Column(
      children: [
        Divider(height: 1, color: Color(0xFFF0F0F0), thickness: 1),
        Container(
          color: Colors.white,
          child: TabBar(
            controller: _tabController,
            indicator: BoxDecoration(
              color: Color(0xFFD1D1D1),
              borderRadius: BorderRadius.circular(0),
            ),
            unselectedLabelColor: Colors.black,
            labelColor: Colors.black,
            tabs: [
              Tab(text: '今日任务'),
              Tab(text: '已测任务'),
            ],
            labelStyle: TextStyle(fontSize: 16),
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: Colors.transparent,
            dividerHeight: 0,
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [TodayCheckTaskView(), CheckedTaskView()],
          ),
        ),
      ],
    );
  }

  _buildAppbar() {
    return AppBar(
      backgroundColor: Colors.white,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "检测线路",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          MyTooltip(
            tipsChild: _toolContent(),
            fromChild: Row(
              children: [
                const Image(
                  width: 30,
                  height: 30,
                  image: AssetImage(Assets.assetsIcUser), // 本地图片
                ),
                SizedBox(width: 4),
                Text(
                  "${UserInfoProvider.login.nickname}",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _toolContent() {
    return SizedBox(
      width: 140,
      height: 140,
      child: Column(
        children: [
          const Image(
            width: 60,
            height: 60,
            image: AssetImage(Assets.assetsIcUser), // 本地图片
          ),
          Text(
            "${UserInfoProvider.login.nickname}",
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
          ),
          Text(
            "${UserInfoProvider.login.nickname}",
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
          ),

          Button(text: '退出登录', width: 120, height: 36),
        ],
      ),
    );
  }
}
