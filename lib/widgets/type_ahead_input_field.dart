import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class TypeAheadInputField extends StatefulWidget {
  const TypeAheadInputField({
    Key? key, 
    this.width,
    required this.suggestionsCallback,
    required this.itemBuilder,
    required this.onSuggestionSelected
  }) : super(key: key);

  final double? width;
  final FutureOr<Iterable<dynamic>> Function(String) suggestionsCallback;
  final Widget Function(BuildContext, dynamic) itemBuilder;
  final void Function(dynamic) onSuggestionSelected;

  @override
  _TypeAheadInputFieldState createState() => _TypeAheadInputFieldState();
}

class _TypeAheadInputFieldState extends State<TypeAheadInputField> {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: widget.width,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        color: Theme.of(context).inputDecorationTheme.fillColor!.withOpacity(0.5)
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TypeAheadField(
            suggestionsCallback: widget.suggestionsCallback, 
            itemBuilder: widget.itemBuilder, 
            onSuggestionSelected: widget.onSuggestionSelected
          )
        ]
      )
    );
  }
}