import 'package:flutter/material.dart';

showOverlay(BuildContext context) async {
  OverlayState overlayState = Overlay.of(context);
  OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => const Positioned(
            top: 40.0,
            right: 10.0,
            child: CircleAvatar(
              radius: 10.0,
              backgroundColor: Colors.red,
              child: Text("1"),
            ),
          ));
  overlayState.insert(overlayEntry);
  overlayEntry.remove();
}
