import 'package:flutter/services.dart';
import 'package:linecheck/entity/line_info_entity.dart';
import 'package:linecheck/index.dart';

class DetailPage extends StatefulWidget {
  late LineInfoEntity entity;

  DetailPage({super.key, required this.entity});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool step2Normal = false;

  // 图片选择器
  List<ImageProvider> images = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('检测域名')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 第一步
            const Text('检测流程', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            const Text('第一步：点击打开跳转默认浏览器，或复制域名前往指定浏览器打开当前检测域名'),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () {
                // 打开链接逻辑
              },
              child: Text(
                widget.entity.url ?? "",
                style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                SizedBox(
                  height: 35,
                  child: ElevatedButton(
                    onPressed: () {
                      // 打开浏览器逻辑
                    },
                    child: const Text('打开'),
                  ),
                ),
                const SizedBox(width: 16),
                SizedBox(
                  height: 35,
                  child: ElevatedButton(
                    onPressed: () {
                      // 复制逻辑
                      Clipboard.setData(const ClipboardData(text: 'https://example.com'));
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('已复制链接')));
                    },
                    child: const Text('复制'),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            /// 第二步
            const Text('第二步：根据域名在浏览器打开情况，选择域名健康状态'),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text('正常打开'),
                    Checkbox(
                      value: step2Normal,
                      onChanged: (v) {
                        setState(() {
                          step2Normal = true;
                        });
                      },
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text('无法打开'),
                    Checkbox(
                      value: !step2Normal,
                      onChanged: (v) {
                        setState(() {
                          step2Normal = false;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 24),

            /// 第三步
            const Text('第三步：上传检测结果截图，需要在多个不同浏览器检测时，需一次上传各浏览器的检测截图'),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                // 已选择图片
                ...images.map(
                  (img) => Stack(
                    children: [
                      Image(image: img, width: 80, height: 80, fit: BoxFit.cover),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              images.remove(img);
                            });
                          },
                          child: const Icon(Icons.close, color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ),
                // 加号按钮
                if (images.length < 9)
                  GestureDetector(
                    onTap: () async {
                      // 模拟选择图片，这里用占位
                      setState(() {
                        images.add(const AssetImage('assets/placeholder.png'));
                      });
                    },
                    child: Container(width: 80, height: 80, color: Colors.grey[200], child: const Icon(Icons.add)),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // 上传逻辑
                },
                child: const Text('上传'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
