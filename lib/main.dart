import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'pages/home.dart';
import 'pages/help.dart';
import 'pages/sentences.dart';
import 'pages/diaries.dart';
import 'common/data.dart' as data;
import 'package:flutter/services.dart';

class AppWidget extends StatefulWidget {
  @override
  _AppWidgetState createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  late final Future<void> _future;

  @override
  void initState() {
    _future = data.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done: // 执行完成
            return Murmurer();
          default: // 未执行完成等情况
            return Container();
        }
      }
    );
  }
}

class Murmurer extends StatefulWidget {
  @override
  _MurmurerState createState() => _MurmurerState();
}

class _MurmurerState extends State<Murmurer> {

  Widget _currentPage = HomePage(); // 当前显示的页面

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      body: _currentPage,

      appBar: AppBar(
        title: const Text('Murmurer'),
        centerTitle: true,
      ),
      // 侧栏
      drawer: Drawer(
        elevation: 0,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            // 侧栏标题部分
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                '菜单',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),

            ListTile(
              leading: Icon(Icons.add),
              title: Text('新增'),
              onTap: () {
                // 单击
                Navigator.pop(context); // 隐藏侧边栏
                setState(() {
                  _currentPage = HomePage();
                });
              },
            ),

            ExpansionTile(
              leading: Icon(Icons.menu_book),
              title: Text('记录'),
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.format_underline),
                  title: Text('一句话'),
                  onTap: () {
                    // 单击
                    Navigator.pop(context); // 隐藏侧边栏
                    setState(() {
                      _currentPage = SentencesPage();
                    });
                  },
                ),
                ListTile(
                  leading: Icon(Icons.calendar_today),
                  title: Text('日记'),
                  onTap: () {
                    // 单击
                    Navigator.pop(context); // 隐藏侧边栏
                    setState(() {
                      _currentPage = DiariesPage();
                    });
                  },
                ),
              ],
            ),

            /*ListTile(
              leading: Icon(Icons.settings),
              title: Text('设置'),
            ),*/

            Divider(),

            ListTile(
              leading: Icon(Icons.help),
              title: Text('帮助'),
              onTap: () {
                // 单击
                Navigator.pop(context); // 隐藏侧边栏
                setState(() {
                  _currentPage = HelpPage();
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MyApp extends MaterialApp {
  MyApp() : super(
    title: 'Murmurer',
    theme: new ThemeData(
      primaryColor: Colors.white,
      backgroundColor: Colors.white,
      scaffoldBackgroundColor: Colors.white,
      dialogBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(elevation: 0),// 取消阴影
    ),
    home: new AppWidget(),
    localizationsDelegates: [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: [
      const Locale('zh', 'CN'),
    ],
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,   // 竖屏 Portrait 模式
      // DeviceOrientation.portraitDown,
      // DeviceOrientation.landscapeLeft, // 横屏 Landscape 模式
      // DeviceOrientation.landscapeRight,
    ],
  );
  runApp(MyApp());
}