import 'package:flutter/material.dart';
import 'package:flutter_yuan/models/duanzimodel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:transparent_image/transparent_image.dart';
import 'dart:io';
import 'dart:convert';

class DuanZiList extends StatefulWidget{
  DuanZiList({Key key}):super(key: key);
  @override
  createState() => new _DuanZiListState();
}

class _DuanZiListState extends State<DuanZiList> {
  int page = 1;
  List<DuanZiModel> duanZiList = new List();
  @override
  void initState() {
    super.initState();
    _getDuanZiList();
  }
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new ListView.builder(
        itemCount: duanZiList.length,
        itemBuilder: (BuildContext context,int index) {
          if(index == duanZiList.length - 1) {
            _getDuanZiList();
          }
          return _buildItem(duanZiList[index]);
        },
      ),
    );
  }

  Widget _buildItem(itemInfo) {
    return new Column(
      children: <Widget>[
        new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Container(
              margin: EdgeInsets.only(left: 8.0,top: 10.0),
              child: new Row(
                children: <Widget>[
                  new CachedNetworkImage(
                    errorWidget: new Icon(Icons.error),
                    imageUrl: itemInfo.header,
                    fadeInDuration: new Duration(seconds: 3),
                    fadeOutDuration: new Duration(seconds: 1),
                    width: 45.0,
                    height: 45.0,
                  ),
                  new Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: new Text(
                      itemInfo.username,
                      overflow: TextOverflow.ellipsis,
                      style: new TextStyle(fontSize: 12.0),
                    ),
                  )
                ],
              ),
            ),
            new Container(
              margin: new EdgeInsets.only(right: 10.0),
              child: new Text(
                itemInfo.passtime,
                style: new TextStyle(fontSize: 10.0,color: Colors.black12)
              ),
            )
          ],
        ),
        new Container(
          padding:new  EdgeInsets.only(left: 8.0,right: 10.0),
          margin: new EdgeInsets.only(top: 10.0,bottom: 10.0),
          child: new GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (context) =>new Image(
                    image: new CachedNetworkImageProvider(itemInfo.thumbnail),
                  )
                )
              );
            },
            child: new CachedNetworkImage(
              imageUrl: itemInfo.thumbnail,
              errorWidget: new Icon(Icons.error),
              fadeInDuration: new Duration(milliseconds: 500),
              fadeOutDuration: new Duration(milliseconds: 200),
            ),
          ),
        ),
        new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Container(
              padding: new EdgeInsets.only(left: 8.0),
              child: new Row(
                children: <Widget>[
                  new Row(
                    children: <Widget>[
                      new Icon(Icons.sentiment_satisfied,color: Colors.blueAccent,),
                      new Text(
                        '${itemInfo.up}',
                      ),
                    ],
                  ),
                  new Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                  ),
                  new Row(
                    children: <Widget>[
                      new Icon(Icons.sentiment_dissatisfied,color: Colors.redAccent,),
                      new Text(
                        '${itemInfo.down}'
                      ),
                    ],
                  )
                ],
              ),
            ),
            new Container(
              padding: new EdgeInsets.only(right: 10.0),
              child: new Row(
                children: <Widget>[
                  new Icon(Icons.comment,color: Colors.black12,),
                  new Text(
                   '${ itemInfo.comment}'
                  )
                ],
              ),
            )
          ],
        ),
        new Padding(
          padding: new EdgeInsets.only(left: 8.0,right: 10.0),
          child: new Divider(
            height: 20.0,
            color: Colors.black26,
          ),
        )
      ],
    );
  }

  _getDuanZiList() async {
    String url = 'https://www.apiopen.top/satinGodApi?type=1&page=$page';
    var httpClient = new HttpClient();
    try {
      var req = await httpClient.getUrl(Uri.parse(url));
      var res = await req.close();
      if(res.statusCode == 200) {
        var JsonString = await res.transform(utf8.decoder).join();
        var data = jsonDecode(JsonString);
        List DuanZi = data['data'];
        List<DuanZiModel> items = new List();
        for (var value in DuanZi) {
          items.add(new DuanZiModel.fromJson(value));
        }
        setState(() {
          this.duanZiList.addAll(items);
          this.page ++;      
        });
      }
    } catch (e) {
      AssertionError(e);
    }
  }
}