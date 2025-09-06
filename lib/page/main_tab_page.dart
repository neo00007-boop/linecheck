import 'package:linecheck/common/button.dart';
import 'package:linecheck/common/my_tooltip.dart';
import 'package:linecheck/index.dart';

class MainTabPage extends StatefulWidget {
  const MainTabPage({super.key});

  @override
  State<MainTabPage> createState() => _MainTabPageState();
}

class _MainTabPageState extends State<MainTabPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      backgroundColor: Color(0xFFF0F0F0),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [_buildCheckCountView()],
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
        Text(
          "今日待检测: 999",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
        ),
        SizedBox(width: 20),
        Text(
          "今日已检测: 888",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
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
