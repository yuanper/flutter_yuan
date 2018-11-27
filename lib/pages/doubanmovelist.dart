import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_yuan/models/doubanmovemodel.dart';
import 'package:flutter_yuan/widgets/starRating.dart';
import 'dart:io';//http
import 'dart:convert';//json对象
import 'package:flutter_spinkit/flutter_spinkit.dart';
class DoubanMoveList extends StatefulWidget{
  const DoubanMoveList({Key key}) 
      : super(key: key);
  @override
  createState() => new _DoubanMoveListState();
}

class _DoubanMoveListState extends State<DoubanMoveList> {
  int start = 0;
  List<DoubanModel> doubanList = new List();
  @override
  //初始化DoubanMoveList对象，并且发起数据请求
  void initState() {
    super.initState();
    _getDoubanMoves(false);
  }
  @override
  Widget build(BuildContext context) {
    return new Container(
        child:  childWidget()
    );
  }
  Widget childWidget() {
    Widget childWidget;
    if(doubanList.length == 0) {
      childWidget = new Stack(
        children: <Widget>[
          new Padding(
            padding: new EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 35.0),
            child: new Center(
              child: SpinKitFadingCircle(
                color: Colors.blueAccent,
                size: 30.0,
              ),
            ),
          ),
          new Padding(
            padding: new EdgeInsets.fromLTRB(0.0, 35.0, 0.0, 0.0),
            child: new Center(
              child: new Text('正在加载中，莫着急哦~'),
            ),
          ),
        ],
      );
    }else {
      childWidget =  new ListView.builder(
        itemCount: doubanList.length,
        itemBuilder: (BuildContext context, int index) {
          if(index == doubanList.length - 1){
            _getDoubanMoves(true);
          }
          return buildItem(doubanList[index]);
        },
      );
      return childWidget;
    }
  }
  Widget buildItem(itemsInfo) {
    return new Card(
      child: new Column(
        children: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Container(
                margin: EdgeInsets.only(left:15.0),
                child: new Column(
                  children: <Widget>[
                    new Row(
                      children: <Widget>[
                        new Text.rich(
                          new  TextSpan(text: itemsInfo.title),
                          style: new TextStyle(fontSize: 18.0),
                        ),
                        new Padding(//创建一个组件让它里面放一些内容
                          padding: const EdgeInsets.only(left: 8.0),
                          child: buildRating(itemsInfo),//这个就是放置的内容，好评推荐
                        )
                      ],
                    ),
                    new Container(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: buildMoveTag(itemsInfo),
                    )
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
              ),
              new Container(
                margin: EdgeInsets.only(right: 15.0),
                child: new Text.rich(
                  new TextSpan(text: '${itemsInfo.rating.average}'),
                  style: new TextStyle(fontSize: 32.0,color: Colors.blue),
                ),
              ),
            ],
          ),
          new Padding(
            padding: const EdgeInsets.only(left: 8.0,right: 8.0),
            child: new Divider(
              height: 15.0,
              color: Colors.black26,
            ),
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Container(
                padding: const EdgeInsets.only(left: 15.0),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    new Text(
                      '导演',
                      style: new TextStyle(fontSize: 15.0),
                    ),
                    new Padding(
                      padding: const EdgeInsets.only(top: 8.0,left: 8.0,bottom: 8.0),
                      child: new Text(
                          itemsInfo.directors[0].name,
                          style: new TextStyle(
                            fontSize: 10.0,
                            fontWeight: FontWeight.bold,
                          )
                      ),
                    ),
                    new Text(
                        '领衔主演',
                        style: new TextStyle(
                            fontSize: 15.0
                        )
                    ),
                    new Container(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: new Row(
                        children: buildActors(itemsInfo.casts),
                      ),
                    )
                  ],
                ),
              ),
              new Container(
                margin: EdgeInsets.only(right: 15.0,bottom: 8.0),
                width: 80.0,
                height: 120.0,
                child: new GestureDetector(//手势
                  onTap: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => new Image(
                                image: new CachedNetworkImageProvider(itemsInfo.images["large"])//使用imageprovider获取缓存图片
                            )
                        )
                    );
                  },
                  child: new CachedNetworkImage(
                    imageUrl: itemsInfo.images['large'],
                    errorWidget: new Icon(Icons.error),
                    fadeInDuration: new Duration(seconds: 3),
                    fadeOutDuration: new Duration(seconds: 1),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
  //生成电影标签
  Row buildMoveTag(DoubanModel doubanItem) {
    List<Widget> list = new List();
    for(var value in doubanItem.genres) {
      list.add(new Container(
        margin: new EdgeInsets.only(right: 8.0),
        padding: new EdgeInsets.only(left: 3.0, right: 3.0, top: 1.0, bottom: 1.0),
        decoration: new BoxDecoration(
          borderRadius: new BorderRadius.all(new Radius.circular(3.0)),
          color: Colors.blue,
        ),
        child: new Text.rich(
          new TextSpan(text: value),
          style: new TextStyle(color: Colors.white,fontSize: 8.0),
        ),
      ));
    }
    return new Row(
      children: list,
    );
  }

  Widget buildRating(DoubanModel doubanItem){
    return Container(
      // child: new Text('next time'),
      child: new StarRating(
        rating: doubanItem.rating.average / doubanItem.rating.max * 5,
        size: 11.0
      ),
    );
  }

  List<Widget> buildActors(List<Avatar> items) {
    List<Widget> list = new List();
    for (var value in items) {
      //确保演员的图片存在
      if(value.avatars != null){
        list.add(
          new Column(
            children: <Widget>[
              new Container(
                width: 45.0,
                height: 45.0,
                child: new GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                          builder: (context) => 
                            new Scaffold(
                              appBar: new AppBar(
                                title: new Text('图片详情'),
                              ),
                              body: new Center(
                                child: new CachedNetworkImage(imageUrl: value.avatars['large']),
                              ),
                            ) 
                        )
                    );
                  },
                  child: new CachedNetworkImage(
                    errorWidget: new Icon(Icons.error),
                    imageUrl: value.avatars['large'],
                    fadeInDuration: new Duration(seconds: 3),
                    fadeOutDuration: new Duration(seconds: 1),
                  ),
                ),
              ),
              new Padding(
                padding: const EdgeInsets.only(top: 4.0,bottom: 5.0),
                child: new Text(
                    value.name,
                    style: new TextStyle(fontSize: 8.0,fontWeight: FontWeight.bold)
                ),
              )
            ],
          )
        );
      }
      
    }
    return list;
  }
  _getDoubanMoves(loadMore) async {
    var pageCount = 10;
    var url = 'https://api.douban.com/v2/movie/in_theaters?apikey=0b2bdeda43b5688921839c8ecb20399b&start=$start&count=$pageCount&client=&udid=';
    var httpClient = new HttpClient();
    try {
      var req = await httpClient.getUrl(Uri.parse(url));
      var res = await req.close();
      print(res);
      if(res.statusCode == HttpStatus.OK) {
        var jsonString = await res.transform(utf8.decoder).join();//将结果转换成字符串拼接
        var data = jsonDecode(jsonString);//格式化成对象
        List moves = data['subjects'];
        List<DoubanModel> items = new List();
        for (var value in moves) {
          items.add(new DoubanModel.fromJson(value));
        };
        setState(() {
          if(this.start == 0) {
            // Navigator.pop(context);
            this.doubanList = items;
          }else{
            this.doubanList.addAll(items);
          }
          this.start = this.doubanList.length;
        });
      }else{
        showNetWorkErr();
      }
    } catch (e) {
      showNetWorkErr();
    }
  }

  void showNetWorkErr() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => new Container(
          width: 100.0,
          height: 100.0,
          padding: const EdgeInsets.all(8.0),
          child: new Center(
            child: AlertDialog(
              content: Text('网路错误'),
            ),
          ),
        ));
  }
}
