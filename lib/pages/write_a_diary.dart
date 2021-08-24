import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../common/data.dart' as data;

/// 写一篇日记
class WriteADiaryPage extends StatelessWidget {

  int? id;
  String content;
  String title;

  WriteADiaryPage({
    this.id,
    this.content = "",
    this.title = "",
  }) : super();

  @override
  Widget build(BuildContext context) {
    // TextEditingController用于获取文本内容
    TextEditingController contentController = new TextEditingController(text: content);
    TextEditingController titleController = new TextEditingController(text: title);

    return new Scaffold(
      appBar: AppBar(
        title: const Text('写一篇日记'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.done),
            onPressed: () {
              if (id == null)
                data.addADiary(titleController.text, contentController.text);
              else
                data.updateADiary(id as int, titleController.text, contentController.text);

              Fluttertoast.showToast(
                msg: "记录成功",
                backgroundColor: Colors.black45,
                textColor: Colors.white,
              );
              Navigator.pop(context);
            }),
        ],
      ),

      body: new Padding(
        padding: EdgeInsets.all(20),

        child: Column(
          children: [
            // 标题文本框
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: "标题",
              ),
            ),

            SizedBox(height: 20),// 保留间距

            Expanded(
              child:
                // 内容文本框
               TextField(
                controller: contentController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "内容",
                ),
                textAlignVertical: TextAlignVertical.top,
                maxLines: null,
                minLines: null,
                expands: true,
              ),
            )
          ],
        )
      )
    );
  }
}
