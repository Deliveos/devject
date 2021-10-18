import 'package:flutter/material.dart';
import 'package:projetex/constants/colors.dart';
import 'package:projetex/widgets/input_text_editing_controller.dart';

/// Custom TextFormField with dynamic validator


class InputField extends StatefulWidget {
  const InputField({
    Key? key, 
    this.controller, 
    this.keyboardType, 
    this.hintText, 
    this.validator, 
    this.onChanged, 
    this.obscureText = false,
    this.suffixIcon
  }) : assert(controller == null || validator != null, "Validator can not be used without controller"),
  super(key: key);
  
  final InputTextEditingController? controller;
  final TextInputType? keyboardType;
  final String? hintText;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final bool obscureText;
  final Widget? suffixIcon;

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  String? errorText;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        color: kInputFieldColor.withOpacity(0.5)
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          errorText != null 
          ? Text(
            errorText!, 
            style: const TextStyle(
              fontSize: 12, 
              color: kErrorTextColor
            )
          )
          : Container(),
          TextFormField(
            key: widget.key,
            obscureText: widget.obscureText,
            onChanged: (String value) {
              if (widget.onChanged != null) {
                widget.onChanged!(value);
              }
              if (widget.validator != null) {
                setState(() {
                  errorText = widget.validator!(value);
                  widget.controller!.isValid = errorText == null;
                });
              }
            },
            controller: widget.controller,
            style: Theme.of(context).textTheme.bodyText1,
            keyboardType: widget.keyboardType,
            cursorColor: kPrimaryLightColor,
            cursorHeight: 18,
            decoration: InputDecoration(
              errorBorder: InputBorder.none,
              errorStyle: const TextStyle(
                fontSize: 12,
                color: kErrorTextColor
              ),
              border: InputBorder.none,
              hintText: widget.hintText,
              hintStyle: Theme.of(context).textTheme.bodyText1,
              suffixIcon: widget.suffixIcon
            ),
          ),
        ],
      ),
    );
  }
}