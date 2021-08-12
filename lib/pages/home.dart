import 'package:flutter/material.dart';
import '../dialogs/record_a_sentence.dart';
import 'write_a_diary.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center, // 子组件在 Column 中居中对齐
        mainAxisAlignment: MainAxisAlignment.center, // 子组件居中排列
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: ElevatedButton(
                child: Text("记一句话"),
                onPressed: () {
                  recordASentence(context);
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.lightBlue,
                  minimumSize: Size(double.infinity, double.infinity),
                  // 使按钮尽可能大
                  textStyle:
                      TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0), // 圆角
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: ElevatedButton(
                child: Text("写一篇日记"),
                onPressed: () {
                  writeADiary(context);
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  minimumSize: Size(double.infinity, double.infinity),
                  textStyle:
                      TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 写一篇日记
  void writeADiary(BuildContext context) {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new WriteADiaryPage();
    }));
  }

  /// 说一句话
  void recordASentence(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return RecordASentenceDialog();
    });
  }
}

