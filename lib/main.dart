import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_aoya_news/guide.dart';
import 'package:flutter_aoya_news/model/user.dart';
import 'package:flutter_aoya_news/utils/locale_util.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'center.dart';
import 'model/banner.dart';
import 'model/coin.dart';
import 'model/tab.dart';

import 'package:oktoast/oktoast.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

// 官方的国际化插件
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {

  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<UserModel>(create: (_) => UserModel()),
          ChangeNotifierProvider<BannerModel>(create: (_) => BannerModel()),
          ChangeNotifierProvider<TabModel>(create: (_) => TabModel()),
          ChangeNotifierProvider<CoinModel>(create: (_) => CoinModel()),
        ],
        child: MyApp(),
      ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: MaterialApp(
        title: '澳亚财经',
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
//          const TranslationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          RefreshLocalizations.delegate,
        ],
        supportedLocales: localeUtil.supportedLocales(),
        // const Locale(languageCode,countryCode)
        // Locale类是用来标识用户的语言环境的，它包括语言和国家两个标志,languageCode和countryCode：
//        supportedLocales: [
//          const Locale('en', 'US'), // 美国英语
//          const Locale('zh', 'CN'), // 中文简体
//          //其它Locales
//        ],
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),

        home: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark,
            child: MyHomePage(title: 'Flutter Demo Home Page'),
        ),
        builder: (BuildContext context,Widget child){
          return FlutterEasyLoading(child:child);
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero,()async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool isFirst = prefs.getBool("first_start");
      if(isFirst == null || isFirst == false){
        Navigator.push(context, MaterialPageRoute(builder: (context) => GuildPage()));
        prefs.setBool("first_start", true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CenterPage(),
    );
  }
}
