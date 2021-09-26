import 'package:flutter/material.dart';
import 'package:projetex/constants/colors.dart';

class InputField extends StatelessWidget {
  const InputField({Key? key, this.controller, this.keyboardType, this.hintText}) : super(key: key);
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? hintText;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        color: kInputFieldColor.withOpacity(0.5)
      ),
      child: TextFormField(
        key: key,
        controller: controller,
        style: Theme.of(context).textTheme.bodyText1,
        keyboardType: keyboardType,
        cursorColor: kPrimaryLightColor,
        cursorHeight: 18,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: Theme.of(context).textTheme.bodyText1
        ),
      ),
    );
  }
}