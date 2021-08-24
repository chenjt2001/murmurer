import 'package:flutter/material.dart';
import '../dialogs/record_a_sentence.dart';
import 'write_a_diary.dart';
import '../common/widgets.dart';

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
              child: GradientButton(
                colors: [Color(0xFF36D1DC), Color(0xFF5B86E5)],
                splashColor: Color(0xFF5B86E5),
                onPressed: () { recordASentence(context); },
                child: Text("记一句话", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: GradientButton(
                colors: [Color(0xFFFF7E5F), Color(0xFFFFAD77)],
                splashColor: Color(0xFFFF7E5F),
                onPressed: () { writeADiary(context); },
                child: Text("写一篇日记", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                borderRadius: BorderRadius.circular(20.0),
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

