import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Browser extends StatefulWidget {
  Browser({Key key, this.url}) : super(key: key);
  final String url;
  @override
  State<StatefulWidget> createState() {
    return _BrowserState();
  }
}

class _BrowserState extends State<Browser> {
  String title = 'WebView';
  WebViewController _controller;
  CookieManager cookieManager = CookieManager();
  JavascriptChannel _javascriptChannel(BuildContext context) {
    return JavascriptChannel(
      name: 'Toast',
      onMessageReceived: (JavascriptMessage message) {
        print(message.message);
      }
    );
  }
  someDemoAPI() {
    //加载链接
    _controller.getTitle();
    _controller.loadUrl('https://www.baidu.com');
  }
  pressed() {
    _controller?.evaluateJavascript('callJS("新的title")')?.then((data){
      print(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
      ),
      body: WebView(
        initialUrl: widget.url,
        javascriptMode: JavascriptMode.unrestricted,
        javascriptChannels: [_javascriptChannel(context)].toSet(),
        navigationDelegate: (NavigationRequest request) {
          if(request.url.startsWith('js://webview')){
            print('prevent ${request.url}');
            return NavigationDecision.prevent;
          }
          print('navigate ${request.url}');
          return NavigationDecision.navigate;
        },
        onWebViewCreated: (WebViewController controller) {
          _controller = controller;
        },
        onPageFinished: (String url) {
          setState(() {
            title = url;
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: pressed,
        child: Text(
          'Press',
          style: TextStyle(color: Colors.red),
        ),
        foregroundColor: Colors.blue,
      ),
    );
  }
}
