import 'package:flutter/material.dart';
import 'package:myapp/detail.dart';
import 'package:myapp/AnimaDemo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
      routes: {
        "detail" : (context) {
          return DetailPage();
        },
        "anima" : (context) {
          return AnimaDemoPage4();
        }
      },
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case "hehe":
            builder = (context) {
              return DetailPage();
            };
            break;
          default:
            throw Exception('Invalid route--: ${settings.name}--');
        }
        return MaterialPageRoute(builder: builder,settings: settings);
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {

    setState(() {
      _counter++;
    });
    // 跳转
    Navigator.pushNamed(
        context,
        "anima",
        arguments: <String,String> {
          "city": "BeiJing",
          "country": "China"
        }
    );
    // 跳转并替换
    // Navigator.pushReplacementNamed(
    //     context,
    //     "detail",
    //     arguments: {
    //       "city": "wuhan",
    //       "country": "China"
    //     }
    // );
    // 跳转并关闭给定路由之前的所有页面
    // Navigator.pushNamedAndRemoveUntil(
    //     context,
    //     "detail",
    //     ModalRoute.withName("/"),
    //     arguments: {
    //       "city": "changsha",
    //       "country": "China"
    //     }
    // );
    // 自定义push
    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //         builder: (context) {
    //           return DetailPage();
    //         },
    //         settings: RouteSettings(
    //             name: "haha",
    //             arguments: {
    //               "city": "guangzhou",
    //               "country": "China"
    //             }
    //         )
    //     )
    // ).then((res) {
    //   print(res["msg"]);
    // });
  }
  @override
  void didUpdateWidget(covariant MyHomePage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    print("lql---_MyHomePageState-didChangeDependencies-----");

  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print("lql---_MyHomePageState-didChangeDependencies-----");
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            DEMOWidget("哈哈哈"),
            DemoStateWidget("呵呵呵呵"),
            Container(
              margin: EdgeInsets.all(10.0),
              height: 120.0,
              width: 400.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                color: Colors.blue,
                border: Border.all(color: Colors.red,width: 0.5)
              ),
              child: Center(
                child: Text("${_counter}"),
              )
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _getBottomItem(Icons.star, "闪"),
                _getBottomItem(Icons.star_border, "闪"),
                _getBottomItem(Icons.star, "闪")
              ],
            ),

            Expanded(
                flex: 2,
                child: Container(
                  color: Colors.yellow,
                  child: Center(
                    child: Text("7777777"),
                  ),
                )
            ),
            Expanded(
                flex: 3,
                child: Align(
                    alignment: Alignment(0.75,0),
                    child: Container(
                      width: 100,
                      height: 100,
                      color: Colors.lightGreen,
                      child: Center(
                        child: Text("88888"),
                      ),
                    )
                ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  /// 返回一个居中带图标和文本的Item
  _getBottomItem(IconData icon, String text) {
    return Expanded(
      flex: 1,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 16.0,
              color: Colors.greenAccent,
            ),
            Padding(padding: EdgeInsets.only(left: 5.0)),
            Text(
              text,
              style: TextStyle(
                color: Colors.blue,
                fontSize: 14.0
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            )
          ],
        ),
      ),
    );
  }
}

class DEMOWidget extends StatelessWidget {
  final String text;

  DEMOWidget(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(text ?? "这就是无状态的DEMO"),
    );
  }
}

class DemoStateWidget extends StatefulWidget {
  final String text;
  DemoStateWidget(this.text);
  @override
  State<StatefulWidget> createState() {
    return _DemoSateWidgetState(text);
  }
}

class _DemoSateWidgetState extends State<StatefulWidget> {
  String text;
  _DemoSateWidgetState(this.text);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    new Future.delayed(const Duration(seconds: 3),(){
      setState(() {
        text = "这就是爱";
      });
    });
  }
  
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print("lql----didChangeDependencies-----");
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Text(text ?? "这就是有状态Demo"),
    );
  }
}
// 有问题
class SampleFutureBuilder extends StatelessWidget {

  getNetworkData() async {
    await Future.delayed(Duration(seconds: 7));
    return "result";
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getNetworkData(),
      initialData: "init",
      builder: (context,data) {
        return Container(
          child: Text(data ?? "loading"),
        );
      }
    );
  }
}

