import 'package:dvmane/UI/report_screen.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Home",
            style: TextStyle(
              fontSize: 18.0
            ),
          ),
          bottom: const TabBar(
              indicatorWeight: 4.0,
              isScrollable:false,
              labelPadding: EdgeInsets.symmetric(horizontal: 2.0),
              tabs: [
                Tab(
                  text: "Pending",
                ),
                Tab(
                  text: "Accepted",
                ),
                Tab(
                  text: "Rejected",
                ),
              ]
          ),
        ),
        body: const TabBarView(
          children: [
            ReportScreen(state:"Pending"),
            ReportScreen(state:"Approved"),
            ReportScreen(state:"Rejected"),
          ],
        ),
      ),
    );
  }
}

class DecoratedTabBar extends StatelessWidget implements PreferredSizeWidget {
  DecoratedTabBar({required this.tabBar, required this.decoration});

  final TabBar tabBar;
  final BoxDecoration decoration;

  @override
  Size get preferredSize => tabBar.preferredSize;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: Container(decoration: decoration)),
        tabBar,
      ],
    );
  }
}
