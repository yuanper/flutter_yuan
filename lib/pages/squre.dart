import 'package:flutter/material.dart';
import 'doubanmovelist.dart';
import 'duanzi.dart';
class SqurePage extends StatefulWidget {
  @override
  createState() => new _SqurePageState();
}

class _SqurePageState extends State<SqurePage> {
  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: 2,
      child: new Scaffold(
        appBar: new AppBar(
          title: new TabBar(
            tabs: <Widget>[
              new Text('豆瓣电影'),
              new Text('热门段子')
            ],
            indicatorSize: TabBarIndicatorSize.label,
            indicatorWeight: 1.0,
          ),
        ),
        body: new TabBarView(
          children: <Widget>[
            new DoubanMoveList(),
            // new DuanZiList()
            // new Text('nihao'),
            new DuanZiList()
          ],
        ),
      ),
    );
  }
}