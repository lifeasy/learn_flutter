import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AnimaDemoPage4 extends StatefulWidget {
  @override
  _AnimaDemoPage4State createState() => _AnimaDemoPage4State();
}

class _AnimaDemoPage4State extends State<AnimaDemoPage4> {
  IconData iconData = Icons.clear;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AnimaDemoPage4'),
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        // onPressed: () {
        //   setState(() {
        //     if(iconData == Icons.clear) {
        //       iconData = Icons.add;
        //     } else {
        //       iconData = Icons.clear;
        //     }
        //   });
        // },
        child: AnimatedSwitcher(
          transitionBuilder: (child,anim) {
            return ScaleTransition(child: child,scale: anim);
          },
          duration: Duration(milliseconds: 300),
          child: IconButton(
            key: ValueKey(iconData),
            icon: Icon(iconData),
            onPressed: () {
              print(MediaQueryData.fromWindow(WidgetsBinding.instance.window).padding.bottom);
              setState(() {
                if(iconData == Icons.clear) {
                  iconData = Icons.add;
                } else {
                  iconData = Icons.clear;
                }
              });
            },
          ),
        ),
      ),
    );
  }
}