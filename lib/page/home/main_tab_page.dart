import 'package:linecheck/common/my_tooltip.dart';
import 'package:linecheck/generated/app_colors.dart';
import 'package:linecheck/index.dart';
import 'package:linecheck/page/home/checked_task_view.dart';
import 'package:linecheck/page/home/today_check_task_view.dart';
import 'package:linecheck/page/home/widgets/menu_button.dart';
import 'package:linecheck/page/login_page.dart';
import 'package:super_tooltip/super_tooltip.dart';

class MainTabPage extends StatefulWidget {
  const MainTabPage({super.key});

  @override
  State<MainTabPage> createState() => _MainTabPageState();
}

class _MainTabPageState extends State<MainTabPage>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  int activeIndex = 0;
  late SuperTooltipController _controller;

  @override
  void initState() {
    _controller = SuperTooltipController();
    super.initState();
  }

  void dispose() {
    _controller.dispose();
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
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              Expanded(
                child: MenuButton(
                  title: '今日任务',
                  onTap: () {
                    setState(() {
                      activeIndex = 0;
                    });
                    _pageController.jumpToPage(0);
                  },
                  active: activeIndex == 0,
                ),
              ),

              SizedBox(width: 20),
              Expanded(
                child: MenuButton(
                  title: '已测任务',
                  onTap: () {
                    setState(() {
                      activeIndex = 1;
                    });
                    _pageController.jumpToPage(1);
                  },
                  active: activeIndex == 1,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: PageView(
            controller: _pageController,
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
            controller: _controller,
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
            onTap: () {
              // Navigator.maybePop(context);
              if (_controller.isVisible) {
                _controller.hideTooltip();
              }
              UserInfoProvider.logout();
              NavigatorUtils.pushAndRemoveUntil(context, LoginPage());
            },
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
    double? height,
    Color? textColor,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width ?? 60,
        height: height ?? 32,
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(radius ?? 16),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(fontSize: 14, color: textColor ?? Colors.white),
        ),
      ),
    );
  }
}
