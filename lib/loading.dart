import 'package:flutter/material.dart';

class Loading {
  static OverlayEntry _overlayEntry; // Loading 框靠它加到屏幕上
  static String _msg; // 提示内容
  static bool _showing = false; // Loading 框是否正在showing
  static show(
    BuildContext context, {
    String msg = '加载中...',
  }) async {
    _msg = msg;
    OverlayState overlayState = Overlay.of(context);
    var size = MediaQuery.of(context).size;
    _showing = true;
    if (_overlayEntry == null) {
      _overlayEntry = OverlayEntry(
        builder: (BuildContext context) => Container(
          width: size.width,
          height: size.height,
          color: Colors.transparent,
          child: AnimatedOpacity(
            opacity: _showing ? 1.0 : 0.0, //目标透明度
            duration: _showing
                ? Duration(milliseconds: 100)
                : Duration(milliseconds: 400),
            child: Center(
              child: Card(
                elevation: 20.0,
                color: Colors.black87,
                child: Container(
                  width: 100,
                  height: 100,
                  alignment: Alignment.center,
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 40,
                        height: 40,
                        margin: EdgeInsets.only(top: 20, bottom: 10),
                        child: CircularProgressIndicator(),
                      ),
                      Text(
                        _msg,
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
      overlayState.insert(_overlayEntry);
    } else {
      _overlayEntry.markNeedsBuild();
    }
  }

  static hide() {
    if (_overlayEntry != null) {
      _showing = false;
      _overlayEntry.remove();
      _overlayEntry = null;
    }
  }
}
