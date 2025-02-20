import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/*
                controller: _valueController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => _submitForm(),
                decoration: const InputDecoration(
                  labelText: 'Valor',
                ),
*/

class AdaptativeTextField extends StatelessWidget {
  final String? label;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final Function(String)? onSubmitted;

  const AdaptativeTextField(
      {super.key,
      this.controller,
      this.keyboardType = TextInputType.text,
      this.onSubmitted,
      this.label});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? Padding(
            padding: EdgeInsets.only(
              bottom: 10,
            ),
            child: CupertinoTextField(
              controller: controller,
              keyboardType: keyboardType,
              onSubmitted: onSubmitted,
              placeholder: label,
              padding: EdgeInsets.symmetric(
                horizontal: 6,
                vertical: 12,
              ),
            ),
          )
        : TextField(
            controller: controller,
            keyboardType: keyboardType,
            onSubmitted: onSubmitted,
            decoration: InputDecoration(
              labelText: label,
            ),
          );
  }
}
