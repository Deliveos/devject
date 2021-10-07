import 'package:flutter/material.dart';
import 'package:projetex/utils/size.dart';

class HeightSizedBox extends StatelessWidget {
  const HeightSizedBox(this.height, {Key? key}) : super(key: key);
  final double height;
  @override
  Widget build(BuildContext context) {
    return SizedBox(height: AppSize.height(context, height));
  }
}