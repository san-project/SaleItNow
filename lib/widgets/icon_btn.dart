import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget {
  const CustomBtn(
      {Key? key,
      required this.onPress,
      required this.iconData,
      required this.color})
      : super(key: key);
  final VoidCallback onPress;
  final IconData iconData;

  final Color color;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPress,
      icon: Icon(
        iconData,
        color: color,
      ),
    );
  }
}
