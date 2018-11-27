import 'package:flutter/material.dart';
import 'package:flutter_yuan/pages/squre.dart';
import 'package:flutter_yuan/pages/find.dart';
void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
          primarySwatch: Colors.blue
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>{
  int myCurrentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      bottomNavigationBar: new BottomNavigationBar(
        items: [
          new BottomNavigationBarItem(
              icon: new Icon(Icons.home),
              title: new Text('主场')
          ),
          new BottomNavigationBarItem(
              icon: new Icon(Icons.find_replace),
              title: new Text('尝鲜')
          )
        ],
        currentIndex: myCurrentIndex,
        onTap: (index){
          setState(() {
            myCurrentIndex = index;
          });
        },
      ),
      body: _setUpCurrentPage(myCurrentIndex),
    );
  }

  Widget _setUpCurrentPage(int myCurrentIndex){
    switch (myCurrentIndex) {
      case 0:
        return new SqurePage();
      case 1:
        return new FindPage();
      default:
        return new SqurePage();
    }
  }
}