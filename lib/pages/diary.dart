import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../pages/write_a_diary.dart';
import '../common/data.dart' as data;
import '../common/widgets.dart';

/// 浏览日记
class DiaryPage extends StatelessWidget {
  final Map<String, dynamic> _data;

  DiaryPage(this._data);

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: AppBar(
        title: const Text('日记浏览'),
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
            Expanded(child: SingleChildScrollView(
              child: Text(
                _data["content"],
                style: TextStyle(fontSize: 18,),
              ),
            )),

            SizedBox(height: 10),// 保留间距

            // 编辑按钮
            Padding(
              padding: EdgeInsets.fromLTRB(100, 5, 100, 0),
              child: GradientButton(
                colors: [Color(0xFFFF7E5F), Color(0xFFFFAD77)],
                splashColor: Color(0xFFFF7E5F),
                onPressed: () {
                  Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
                    return new WriteADiaryPage(
                      id: _data["id"],
                      content: _data["content"],
                      title: _data["title"],
                    );
                  })).then((value) => Navigator.pop(context, "refresh"));
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.edit, color: Colors.white,),
                    SizedBox(width: 10),// 保留间距
                    Text("编辑")
                  ],
                ),
                borderRadius: BorderRadius.circular(100),
              ),
            )
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
