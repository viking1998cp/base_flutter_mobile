import 'package:base_flutter_framework/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';

//
Widget otpScreen(
    {required int maxLeight,
    required TextEditingController pinEditingController,
    required FocusNode focusNode}) {
  return Container(
    color: Colors.white,
    padding: EdgeInsets.only(bottom: 10, left: 5, right: 5),
    child: PinInputTextField(
      pinLength: maxLeight,
      decoration: UnderlineDecoration(
          hintText: '-' * maxLeight,
          colorBuilder:
              PinListenColorBuilder(Colors.black, ColorCommon.colorGreen)),
      controller: pinEditingController,
      autoFocus: true,
      textInputAction: TextInputAction.done,
    ),
  );
}
