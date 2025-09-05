import 'package:flutter/material.dart';

class MainTabPage extends StatefulWidget {
  const MainTabPage({super.key});

  @override
  State<MainTabPage> createState() => _MainTabPageState();
}

class _MainTabPageState extends State<MainTabPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("我是主页", style: TextStyle(fontSize: 40, color: Colors.red)),
    );
  }
}
