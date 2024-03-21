import 'package:flutter/material.dart';
import '../utils/utils.dart';

class CorneredButton extends StatelessWidget {
  final String title;
  final VoidCallback onPress;
  final Color? color;
  final Color? textcolor;
  final double? height;
  final double? width;
  final BoxBorder? buttonBorder;

  const CorneredButton(
      {Key? key,
      required this.title,
      this.color,
      this.height,
      this.width,
      this.textcolor,
      required this.onPress,
      this.buttonBorder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: color,
          border: buttonBorder,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
            child: Text(title,
                style: AppTheme.lightTheme.textTheme.headlineSmall
                    ?.copyWith(color: textcolor,fontSize: 20))),
      ),
    );
  }
}
