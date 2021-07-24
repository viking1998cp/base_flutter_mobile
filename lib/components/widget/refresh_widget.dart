import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

Widget refreshCommon(
    {required RefreshController refreshController,
    required Widget child,
    required Function onRefresh}) {
  return SmartRefresher(
    controller: refreshController,
    // enablePullUp: true,
    enablePullDown: true,
    header: WaterDropHeader(),
    physics: BouncingScrollPhysics(),
    footer: ClassicFooter(
      loadStyle: LoadStyle.ShowWhenLoading,
      completeDuration: Duration(milliseconds: 500),
    ),
    child: child,
    onRefresh: () {
      onRefresh();
    },
  );
}
