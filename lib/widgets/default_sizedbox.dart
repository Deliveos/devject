import 'package:flutter/material.dart';
import 'package:projetex/utils/size.dart';

class DefaultSizedBox extends StatelessWidget {
  const DefaultSizedBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: AppSize.height(context, 20));
  }
}