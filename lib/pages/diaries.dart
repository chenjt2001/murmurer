import 'package:flutter/material.dart';
import 'diary.dart';
import '../common/data.dart' as data;

/// 显示句子页面
class DiariesPage extends StatefulWidget {
  @override
  _DiariesPagePageState createState() => _DiariesPagePageState();
}

class _DiariesPagePageState extends State<DiariesPage> {
  late Future<void> _future;
  late List<Map<String, dynamic>> _diaries;

  @override
  void initState() {
    _future = _getDiaries();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _future,
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {

          switch (snapshot.connectionState) {
            case ConnectionState.done: // 执行完成
              if (_diaries.length == 0)
                return Center(child: Text("暂无"));
              else
                return ListView.builder(
                  itemCount: _diaries.length,
                  itemBuilder: (BuildContext context, int index) {
                    // 列表的每一项
                    return ListTile(
                      title: Text(_diaries[index]["title"]),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      onTap: () {
                        Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
                          return new DiaryPage(_diaries[index]);
                        })).then((value) {
                          // 获取返回信息
                          if (value == "refresh")
                            setState(() {_future = _getDiaries();});
                        });
                      },
                    );
                },);

            default: // 未执行完成等情况
              return Center(child: CircularProgressIndicator(),);
          }
        }
    );
  }

  // 获取日记
  _getDiaries() {
    return Future.delayed(Duration(seconds: 1),() async {
      _diaries = await data.getDiaries();
    });
  }
}
