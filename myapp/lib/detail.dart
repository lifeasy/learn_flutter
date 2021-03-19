import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Map map = ModalRoute.of(context).settings.arguments;
    String city = map["city"] ?? "没有城市";
    String country = map["country"] ?? "没有国家";
    void _onBack() {
      Navigator.of(context).pop({"msg":"${city}——收到"});
    }
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(city),
        backgroundColor: Colors.red,
        leading: new IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: _onBack,
        ),
      ),
      body: Center(
        child: Text(country),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onBack,
        tooltip: 'Increment',
        child: Icon(Icons.arrow_back),
      ),
    );
  }
}

