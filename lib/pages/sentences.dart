import 'package:flutter/material.dart';
import '../common/data.dart' as data;

/// 显示句子页面
class SentencesPage extends StatefulWidget {
  @override
  _SentencesPageState createState() => _SentencesPageState();
}

class _SentencesPageState extends State<SentencesPage> {
  late Future<void> _future;
  late List<Map<String, dynamic>> _sentences;

  @override
  void initState() {
    _future = _getSentences();
    //_future = new Future(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {

        switch (snapshot.connectionState) {
          case ConnectionState.done: // 执行完成
            if (_sentences.length == 0)
              return Center(child: Text("暂无"));
            else
              return ListView.builder(
                itemCount: _sentences.length,
                itemBuilder: (BuildContext context, int index) {
                  // 列表的每一项
                  return ListTile(
                    title: Text(_sentences[index]["content"]),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {_delete(context, _sentences[index]["id"]);},
                    ),
                    //selected: true,
                  );
              },);

          default: // 未执行完成等情况
            return Center(child: CircularProgressIndicator(),);
        }
      }
    );
  }

  // 获取句子
  _getSentences() {
    return Future.delayed(Duration(seconds: 1),() async {
      _sentences = await data.getSentences();
    });
  }

  /// 删除一个句子
  void _delete(BuildContext context, int id) {
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
              data.deleteASentence(id);
              setState(() {_future = _getSentences();});// 刷新页面数据
            },),
          ],
        );
    });
  }
}
