import 'package:base_flutter_framework/components/home_main/button_title_mode.dart';
import 'package:base_flutter_framework/components/home_main/item_house.dart';
import 'package:base_flutter_framework/components/widget/button_icon_horizontal.dart';
import 'package:base_flutter_framework/components/widget/button_no_icon.dart';
import 'package:base_flutter_framework/components/widget/button_setting.dart';
import 'package:base_flutter_framework/components/widget/image.dart';
import 'package:base_flutter_framework/components/widget/refresh_widget.dart';
import 'package:base_flutter_framework/components/widget/text_regular.dart';
import 'package:base_flutter_framework/core/blocs/home_bloc/home_bloc.dart';
import 'package:base_flutter_framework/repository/home_repository.dart';
import 'package:base_flutter_framework/utils/color.dart';
import 'package:base_flutter_framework/utils/dimens.dart';
import 'package:base_flutter_framework/utils/hex_color.dart';
import 'package:base_flutter_framework/utils/string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeMainScreen extends StatefulWidget {
  const HomeMainScreen({Key? key}) : super(key: key);

  @override
  _HomeMainScreenState createState() => _HomeMainScreenState();
}

class _HomeMainScreenState extends State<HomeMainScreen> {
  HomeBloc _homeBlocSell = new HomeBloc(homeRepository: new HomeRepository());
  HomeBloc _homeBlocRent = new HomeBloc(homeRepository: new HomeRepository());
  HomeBloc _homeBlocTranfer =
      new HomeBloc(homeRepository: new HomeRepository());

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    _homeBlocSell.add(GetDataHouse());
    _homeBlocRent.add(GetDataHouse());
    _homeBlocTranfer.add(GetDataHouse());
  }

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  Widget header() {
    return Container(
      width: DimensCommon.sizeWidth(context: context),
      height: 200,
      decoration: BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.cover, image: AssetImage(StringCommon.pathBgHeaderApp)),
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(35), bottomRight: Radius.circular(35)),
        color: Colors.redAccent,
      ),
    );
  }

  Widget searchButton() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: TextButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.white),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12))))),
          onPressed: () {},
          child: Row(
            children: [
              Icon(Icons.search, size: 25, color: ColorCommon.colorTextGrey),
              Container(
                margin: EdgeInsets.only(left: 10),
                child: textRegular(
                    color: ColorCommon.colorTextGrey,
                    title: "Bạn tìm gì",
                    fontSize: DimensCommon.fontSizeMedium),
              )
            ],
          )),
    );
  }

  Widget modeHouse() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          buttonIconHorizontal(
            height: 40,
            function: () {},
            width: 40,
            title: "Mua bán",
            urlIcon: StringCommon.pathKeyIconSellHouse,
          ),
          buttonIconHorizontal(
              height: 40,
              function: () {},
              width: 40,
              title: 'Cho thuê',
              urlIcon: StringCommon.pathKeyIconRentHouse),
          buttonIconHorizontal(
              height: 40,
              function: () {},
              width: 40,
              title: "Sang nhượng",
              urlIcon: StringCommon.pathKeyIconTransferHouse),
        ],
      ),
    );
  }

  Widget buttnAddNews() {
    return Container(
      alignment: Alignment.centerRight,
      child: Container(
        width: 120,
        height: 40,
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: TextButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    ColorCommon.buttonColorMain.withOpacity(0.8)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12))))),
            onPressed: () {},
            child: Row(
              children: [
                Icon(Icons.playlist_add, size: 25, color: Colors.white),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: textRegular(
                      color: Colors.white,
                      title: "Đăng bài",
                      fontSize: DimensCommon.fontSizeMedium),
                )
              ],
            )),
      ),
    );
  }

  Widget listItemHouse(
      {required String title,
      required String urlIcon,
      required HomeBloc bloc}) {
    return Column(
      children: [
        buttonTitleMode(
            countNews: 3243543,
            function: () {},
            name: title,
            urlIcon: urlIcon,
            context: context),
        Container(
          height: 300,
          color: Colors.transparent,
          child: BlocBuilder<HomeBloc, HomeState>(
            bloc: bloc,
            builder: (context, state) {
              if (state is GetListHouseSuccessState) {
                return ListView.builder(
                    itemCount: state.houseData.length,
                    padding: EdgeInsets.all(0),
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return itemHouse(house: state.houseData[index]);
                    });
              }
              return SizedBox();
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: refreshCommon(
          refreshController: _refreshController,
          onRefresh: _onRefresh,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    header(),
                    Container(
                      margin: DimensCommon.paddingCommon(context: context),
                      padding: EdgeInsets.only(top: 15),
                      child: Column(
                        children: [
                          buttnAddNews(),
                          searchButton(),
                          modeHouse(),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            child: Column(
                              children: [
                                listItemHouse(
                                    title: StringCommon.sellBuy,
                                    urlIcon: StringCommon.pathKeyIconSellHouse,
                                    bloc: _homeBlocSell),
                                listItemHouse(
                                    title: StringCommon.rent,
                                    urlIcon: StringCommon.pathKeyIconRentHouse,
                                    bloc: _homeBlocRent),
                                listItemHouse(
                                    title: StringCommon.tranfer,
                                    urlIcon:
                                        StringCommon.pathKeyIconTransferHouse,
                                    bloc: _homeBlocTranfer),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: buttonSetting(count: "1"),
    );
  }
}
