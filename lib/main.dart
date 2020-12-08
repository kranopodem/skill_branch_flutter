import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'app.dart';

void main() {
  runApp(MyApp());
}

class ConnectivityOverlay {
  static final ConnectivityOverlay _singleton = ConnectivityOverlay._internal();

  factory ConnectivityOverlay() {
    return _singleton;
  }

  ConnectivityOverlay._internal();

  static OverlayEntry overlayEntry;

  void showOverlay(BuildContext context, Widget child) {
    Overlay.of(context).insert(overlayEntry = OverlayEntry(
      builder: (context) {
        final size = MediaQuery.of(context).size;
        return Positioned(
          width: 300,
          height: 56,
          top: 72,
          left: 50,
          child: Material(
            color: Colors.transparent,
            child: GestureDetector(
              onTap: () => removeOverlay(context),
              child: Container(
                alignment: Alignment.center,
                child: Text('No internet connection'),
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle, color: Colors.grey),
              ),
            ),
          ),
        );
      },
    ));
  }

  void removeOverlay(BuildContext context) {
    overlayEntry.remove();
  }
}
