import 'package:flutter/material.dart';
import 'package:projetex/constants/colors.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    this.enabled = true,
    Key? key,
    this.text,
    this.icon,
    this.onTap,
    this.color,
    this.textColor,
    this.iconLeft = false,
    this.iconImage,
    this.padding, 
    this.fontSize, 
    this.width,
    required this.child
  }) : super(key: key);

  final double? width;
  final bool enabled;
  final Widget child;
  final String? text;
  final IconData? icon;
  final void Function()? onTap;
  final Color? color;
  final Color? textColor;
  final bool? iconLeft;
  final Image? iconImage;
  final EdgeInsets? padding;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
        side: BorderSide.none,
      ),
      color: enabled 
        ? color ?? Colors.transparent
        : Colors.grey,
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: enabled ? onTap : () {},
        child: Container(
          height: 50,
          padding: padding,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            gradient: LinearGradient(colors: [kPrimaryLightColor, kPrimaryDarkColor])
            ),
          child: Center(child: child),
        )
      ),
    );
  }
}
