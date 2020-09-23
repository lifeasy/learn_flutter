import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:convert';
import 'dart:async';

class ActivityView extends StatefulWidget {
  final String url;
  ActivityView({Key key, this.url}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _ActivityViewState();
  }
}

class _ActivityViewState extends State<ActivityView> {
  final Completer<WebViewController> _controller = Completer<WebViewController>();
  calc(int a, int b) {
    print('result= ${a+b}');
    return a+b;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(
        initialUrl: widget.url,
        javascriptMode: JavascriptMode.unrestricted,
        debuggingEnabled: true,
        onWebViewCreated: (WebViewController controller) {
          _controller.complete(controller);
        },
        navigationDelegate: (NavigationRequest request) {
          Uri uri = Uri.parse(request.url);
          print(uri.queryParameters['arg1']);
          if(uri.scheme == 'native') {
            if(uri.host == 'calc') {
              this.calc(int.parse(uri.queryParameters['arg1']), int.parse(uri.queryParameters['arg2']));
            }
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
        onPageFinished: (String url) {
          _controller.future.then((webController){
            webController.evaluateJavascript('function callNative(){window.location.href = "native://calc?arg1=3&arg2=4";};callNative();');
          }).catchError((err){
            print(err.toString());
          });
        },
        javascriptChannels: <JavascriptChannel>[
          JavascriptChannel(
            name: 'Calc',
            onMessageReceived: (JavascriptMessage message) {
              Map param = json.decode(message.message);
              this.calc(param['arg1'], param['arg2']);
            }
          )
        ].toSet(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _controller.future.then((webController){
            // webController
            // .evaluateJavascript('Calc.postMessage(JSON.stringify({arg1:2,arg2:6}))');
            webController
            .evaluateJavascript('function calc(a,b){console.log(a+b);return a+b;};calc(2,3);')
            .then((result){
              print('result= $result');
            });
          });
        },
        child: Text(
          'Press',
          style: TextStyle(color: Colors.red),
        ),
        foregroundColor: Colors.blue,
      ),
    );
  }
}
