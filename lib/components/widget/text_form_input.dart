import 'package:base_flutter_framework/utils/color.dart';
import 'package:base_flutter_framework/utils/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

Widget textFormInput(
    {required TextEditingController controller,
    required String hintText,
    TextAlign? textAlign,
    int? maxLengthLimit,
    TextInputType? textInputType,
    bool? obscureText,
    Function()? submit,
    FocusNode? focus,
    double? fontHideSize,
    bool? isDense,
    Function(String value)? onChange,
    IconButton? suffixIcon,
    double? radiusBorder,
    EdgeInsets? contentPadding,
    Color? backgroundColor,
    BuildContext? context,
    int? minLine,
    TextInputAction? textInputAction,
    bool? expands,
    required EdgeInsets margin}) {
  return Container(
    child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(radiusBorder ?? 5)),
          color: backgroundColor ?? Colors.white),
      margin: margin,
      child: TextFormField(
        inputFormatters: [
          LengthLimitingTextInputFormatter(
              maxLengthLimit == null ? 100 : maxLengthLimit),
        ],
        style: TextStyle(
            fontSize: DimensCommon.fontSizeMedium, color: Colors.black),
        onChanged: onChange,
        focusNode: focus,
        expands: expands ?? false,
        maxLines: obscureText == true ? 1 : null,
        minLines: minLine ?? null,
        textAlignVertical: TextAlignVertical.center,
        onEditingComplete: () {},
        textInputAction: textInputAction ?? TextInputAction.done,
        controller: controller,
        obscureText: obscureText == null ? false : obscureText,
        keyboardType:
            textInputType == null ? TextInputType.emailAddress : textInputType,
        textAlign: textAlign == null ? TextAlign.start : textAlign,
        decoration: InputDecoration(
          fillColor: Colors.white,
          hintText: hintText,
          border: InputBorder.none,
          suffixIcon: suffixIcon ?? null,
          contentPadding:
              contentPadding ?? EdgeInsets.only(left: 8, top: 0, bottom: 12),
          hintStyle: TextStyle(
              fontSize: fontHideSize, color: ColorCommon.colorHintText),
        ),
      ),
    ),
  );
}
