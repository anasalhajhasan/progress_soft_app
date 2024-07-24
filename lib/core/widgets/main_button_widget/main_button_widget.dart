import 'package:flutter/material.dart';
import 'package:progress_soft_app/application_layer/resources/values_manager.dart';

class MainButton extends StatefulWidget {
  const MainButton({
    Key? key,
    required this.child,
    required this.size,
    this.onPressed,
    this.color,
    this.width,
    this.height,
    this.margin,
    this.elevation,
    this.radius,
  }) : super(key: key);
  final Widget child;
  final VoidCallback? onPressed;
  final String size;

  final Color? color;
  final double? width;
  final double? height;
  final EdgeInsets? margin;
  final double? elevation;
  final double? radius;
  @override
  MainButtonState createState() => MainButtonState();
}

class MainButtonState extends State<MainButton> {
  @override
  Widget build(BuildContext context) {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Container(
      margin: widget.margin ??
          const EdgeInsets.symmetric(
              vertical: AppMargin.m20, horizontal: AppMargin.m8),
      width: isLandscape
          ? MediaQuery.sizeOf(context).width / 2.5
          : getSize(widget.size),
      height: widget.height ?? 50,
      child: ElevatedButton(
        style: ButtonStyle(
          elevation: MaterialStateProperty.resolveWith(
            (Set<MaterialState> states) => widget.elevation,
          ),
          textStyle: MaterialStateProperty.resolveWith(
              (Set<MaterialState> states) =>
                  Theme.of(context).textTheme.bodyMedium),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return widget.color ?? Theme.of(context).primaryColor;
              } else if (states.contains(MaterialState.disabled)) {
                return widget.color ??
                    Theme.of(context).primaryColor.withOpacity(0.4);
              }
              return widget.color ?? Theme.of(context).primaryColor;
            },
          ),
          shape: MaterialStateProperty.resolveWith(
            (Set<MaterialState> states) => RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(widget.radius ?? 6),
            ),
          ),
        ),
        onPressed: widget.onPressed,
        child: widget.child,
      ),
    );
  }

  double getSize(String size) {
    double width = MediaQuery.sizeOf(context).width;
    if (size == 'verySmall') {
      return width * 0.15;
    } else if (size == 'Small') {
      return width * 0.2;
    } else if (size == 'Medium') {
      return width * 0.3;
    } else if (size == 'Large') {
      return width * 0.5;
    } else if (size == 'XL') {
      return width * 0.6;
    } else if (size == 'Normal') {
      return width;
    }

    return width;
  }
}
