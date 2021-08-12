import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../common/data.dart' as data;

/// 说一句话的对话框
class RecordASentenceDialog extends Dialog {
  RecordASentenceDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.all(12.0),
      child: new Material(
        type: MaterialType.transparency,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Container(
              decoration: ShapeDecoration(
                color: Color(0xFFFFFFFF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
              ))),

              margin: const EdgeInsets.all(12.0),
              child: new Column(
                children: <Widget>[
                  new Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 40.0, 10.0, 28.0),
                    child: Center(
                      child: new Text('记一句话',
                        style: new TextStyle(
                          fontSize: 20.0,
                  )))),

                  new Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 28.0),
                    child: Center(
                      child: new TextField(
                        decoration: InputDecoration(hintText: "你想记的话"),

                        // 提交内容
                        onSubmitted: (text) {
                          Navigator.pop(context);
                          data.addASentence(text);
                          Fluttertoast.showToast(
                              msg: "记录成功",
                              backgroundColor: Colors.black45,
                              textColor: Colors.white,
                          );
                        },
                      )
                  )),
            ]))
    ])));
  }
}
