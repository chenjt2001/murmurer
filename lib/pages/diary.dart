import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../common/data.dart' as data;

/// 浏览日记
class DiaryPage extends StatelessWidget {
  final Map<String, dynamic> _data;

  DiaryPage(this._data);

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: AppBar(
        title: const Text('日记浏览'),
        elevation: 0,
        actions: <Widget>[
          // 删除按钮
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              _delete(context);
            }),
        ],
      ),

      body: new Padding(
        padding: EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 标题
            Text(
              _data["title"],
              textAlign: TextAlign.center,
              style: Theme.of(context).primaryTextTheme.headline6,
            ),

            SizedBox(height: 10),// 保留间距

            // 日期
            Text(
              _data["created_time"],
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 10),// 保留间距

            // 内容
            Expanded(child: Text(
              _data["content"],
              style: TextStyle(fontSize: 18,),
            ),),
          ],
        )
      )
    );
  }

  /// 删除这篇日记
  void _delete(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('提示'),
          content: Text('你确定要删除吗？'),
          actions: <Widget>[
            TextButton(child: Text('取消'),onPressed: (){Navigator.pop(context);},),
            TextButton(child: Text('确认'),onPressed: (){
              Navigator.pop(context);
              data.deleteADiary(_data["id"]);
              Navigator.pop(context, "refresh");
            },),
          ],
        );
    });
  }
}
