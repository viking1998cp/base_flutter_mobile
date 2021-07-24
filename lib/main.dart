// import 'package:base_flutter_framework/services/deep_link.dart';
import 'package:base_flutter_framework/components/menu/menu_main/menu_page.dart';
import 'package:base_flutter_framework/utils/dimens.dart';
import 'package:base_flutter_framework/utils/shared.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// import 'screens/menu/menu_main/menu_page.dart';
// import 'screens/login_register/register/register_page.dart';
import 'screens/home_main/home_main_page.dart';
import 'screens/login/login_page.dart';
import 'services/onesignal/onesignal_config.dart';
import 'translations/app_translations_delegate.dart';
import 'translations/application.dart';
import 'utils/string.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AppTranslationsDelegate? _newLocaleDelegate;

  @override
  void initState() {
    super.initState();
    setUpMain();
  }

  void setUpMain() async {
    try {
      // await Firebase.initializeApp();
      // await Shared.getInstance().getUser();
      // if (Shared.getInstance().userModel.displayName != "" &&
      //     Shared.getInstance().userModel.active == true &&
      //     Shared.getInstance().userModel.displayName != null) {
      //   DeppLink.getInstance().setUpUniLinksString();
      //   Shared.getInstance().deleteCarsId();
      //   _isLogin = true;
      // } else {
      //   Shared.getInstance().deleteUser();
      // }
      _newLocaleDelegate =
          AppTranslationsDelegate(newLocale: new Locale('vi', ''));
    } catch (_e) {}

    await OnesignalConfig.getInstance()!.initPlatformState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      localizationsDelegates: [
        _newLocaleDelegate!,
        //provides localised strings
        GlobalMaterialLocalizations.delegate,
        //provides RTL support
        GlobalWidgetsLocalizations.delegate,
        DefaultMaterialLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
      home: MaterialApp(
          title: 'Mygarage',
          // theme: ThemeData(fontFamily: StringCommon.fontHelveticarRegular),
          localizationsDelegates: [
            _newLocaleDelegate!,
            //provides localised strings
            GlobalMaterialLocalizations.delegate,
            //provides RTL support
            GlobalWidgetsLocalizations.delegate,
            DefaultMaterialLocalizations.delegate,
            DefaultCupertinoLocalizations.delegate,
            DefaultWidgetsLocalizations.delegate,
          ],
          supportedLocales: application.supportedLocales(),
          home: FutureBuilder(
            // Replace the 3 second delay with your initialization code:
            future: Future.delayed(Duration(seconds: 4)),
            builder: (context, AsyncSnapshot snapshot) {
              // Show splash screen while waiting for app resources to load:
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Splash();
              } else {
                // Loading is done, return the app:
                return MenuHome(
                  index: 0,
                );
              }
            },
          )),
    );
  }
}

class Splash extends StatelessWidget {
  Widget background(BuildContext context) {
    return Container(
      child: Center(
        child: Image.asset(
          StringCommon.pathBgLogoFlash,
          height: DimensCommon.sizeHeight(context: context),
          width: DimensCommon.sizeWidth(context: context),
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: background(context),
      ),
    );
  }
}
