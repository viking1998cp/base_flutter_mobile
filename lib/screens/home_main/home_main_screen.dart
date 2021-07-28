import 'package:base_flutter_framework/components/widget/scaffold_padding.dart';
import 'package:base_flutter_framework/components/widget/text_regular.dart';
import 'package:base_flutter_framework/utils/dimens.dart';
import 'package:flutter/material.dart';

class HomeMainScreen extends StatefulWidget {
  const HomeMainScreen({Key? key}) : super(key: key);

  @override
  _HomeMainScreenState createState() => _HomeMainScreenState();
}

class _HomeMainScreenState extends State<HomeMainScreen> {
  @override
  Widget build(BuildContext context) {
    return scaffoldPadding(
        context: context,
        child: Center(
          child: textRegular(
              color: Colors.black,
              title: "Base",
              fontSize: DimensCommon.fontSizeMedium),
        ));
  }
}
