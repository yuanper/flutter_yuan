import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutter_yuan/models/picmodel.dart';
import 'package:cached_network_image/cached_network_image.dart';

class FindPage extends StatefulWidget{
  FindPage({Key key}):super(key:key);
  @override
  createState() => new _FindPageState();
}

class _FindPageState extends State<FindPage> {
  List<PicModel> picList = new List();
  int page = 1;
  @override
  void initState() {
    super.initState();
    _getPicList();
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('美图'),
        centerTitle: true,
      ),
      body: new GridView.builder(
        padding: const EdgeInsets.all(10.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
        ),
        itemCount: picList.length,
        itemBuilder: (BuildContext context, int index) {
          if(index == picList.length - 1 ){
            _getPicList();
          }
          return buildItem(picList[index]);
        },
      ),
    );
  }
  _getPicList() async{
    String url = 'https://www.apiopen.top/meituApi?page=$page';
    var httpClient = new HttpClient();
    try {
      var req = await httpClient.getUrl(Uri.parse(url));
      var res = await req.close();
      // print(res);
      if(res.statusCode == HttpStatus.OK) {
        var jsonString = await res.transform(utf8.decoder).join();//将结果转换成字符串拼接
        // print(jsonString);
        Map data = jsonDecode(jsonString);//格式化成Map对象
        print(data);
        List pics = data['data'];
        List<PicModel> items = new List();
        for (var value in pics) {
          items.add(new PicModel.fromJson(value));
        };
        setState(() {
         
          this.picList.addAll(items);
          
          this.page ++;
        });
      }
    } catch (e) {
      
    }
  }

  buildItem(item) {
    return new GestureDetector(
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
                child: new Container(
                  width: 300.0,
                  child: new CachedNetworkImage(
                    imageUrl: item.url,
                    fit: BoxFit.fitWidth,
                  ),
                )
              ),
            )
          )
        );
      },
      child: new CachedNetworkImage(
        errorWidget: new Icon(Icons.error),
        imageUrl: item.url,
        fadeInDuration: new Duration(seconds: 3),
        fadeOutDuration: new Duration(seconds: 1),
      ),
    );
  }
}