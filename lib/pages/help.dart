import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:package_info/package_info.dart';
import '../common/data.dart' as data;

/// 帮助页面
class HelpPage extends StatefulWidget {
  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  late final Future<void> _future;
  late final PackageInfo _packageInfo;

  @override
  void initState() {
    _future = Future(() async {_packageInfo = await PackageInfo.fromPlatform();});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: _future,
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done: // 执行完成
            return new Column(
              children: [
                new RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '介绍\n',
                        style: Theme.of(context).primaryTextTheme.headline6,
                      ),
                      TextSpan(
                        text: '《Murmurer》是一款用来记录生活的软件。\n\n',
                        style: TextStyle(color: Colors.black),
                      ),
                      TextSpan(
                        text: '关于\n',
                        style: Theme.of(context).primaryTextTheme.headline6,
                      ),
                      TextSpan(
                        text: '作者：',
                        style: TextStyle(color: Colors.black),
                      ),
                      TextSpan(
                        text: '珒陶（陈锦涛）\n',
                        style: TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                        ..onTap = () {
                        launch('http://www.chenjt.com/');
                        },
                      ),
                      TextSpan(
                        text: '版本：${_packageInfo.version}\n',
                        style: TextStyle(color: Colors.black),
                      ),
                      TextSpan(
                        text: '数据库文件路径：${data.dbFilePath}\n',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  )
                ),

                Divider(),

                ListTile(
                  title: Text("Licenses"),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: (){showLicensePage (
                    context: context,
                  );},
                ),
              ],
            );
          default: // 未执行完成等情况
            return Container();
        }
      }
    );
  }
}
