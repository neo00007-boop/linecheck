import 'package:linecheck/common/my_tooltip.dart';
import 'package:linecheck/generated/app_colors.dart';
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
      backgroundColor: AppColors.primary,
      body: _buildCheckCountView(),
    );
  }

  _buildCheckCountView() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 10),
          color: AppColors.primary,
          child: TabBar(
            controller: _tabController,
            indicator: BoxDecoration(
              color: Color(0xFFD1D1D1),
              borderRadius: BorderRadius.circular(0),
            ),
            unselectedLabelColor: AppColors.primary.withOpacity(0.2),
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
      backgroundColor: AppColors.primary,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "检测线路",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
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
                  style: TextStyle(fontSize: 14, color: Colors.white),
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
            style: TextStyle(
              fontSize: 15,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            "广州",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
              fontWeight: FontWeight.w400,
            ),
          ),

          _button(
            title: '退出登录',
            bg: AppColors.primary,
            radius: 5,
            width: 120,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _button({
    required String title,
    required Color bg,
    required VoidCallback onTap,
    double? radius,
    double? width,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width ?? 60,
        height: 32,
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(radius ?? 16),
        ),
        alignment: Alignment.center,
        child: Text(title, style: TextStyle(fontSize: 14, color: Colors.white)),
      ),
    );
  }
}
