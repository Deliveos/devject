import 'dart:math';

import 'package:devject/utils/size.dart';
import 'package:flutter/material.dart';

class NoneProfileImage extends StatelessWidget {
  const NoneProfileImage({Key? key, required this.name, required this.size}) : super(key: key);

  final String name;
  final double size;
  

  @override
  Widget build(BuildContext context) {
    print(size);
    print(name[0].toUpperCase());
    final List<Color> colors = [
      Colors.black,
      Colors.blue,
      Colors.amber,
      Colors.cyan,
      Colors.green,
      Colors.deepPurple
    ];
    return Container(
      width: size,
      height: size,
      child: Center(
        child: Text(
          name[0].toUpperCase(), 
          style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: ScreenSize.width(context, size/0.8))
        ),
      ),
      decoration: BoxDecoration(
        color: colors[Random().nextInt(colors.length)],
        borderRadius: BorderRadius.circular(
          ScreenSize.width(context, 100)
        ),
      ),
    );
  }
}