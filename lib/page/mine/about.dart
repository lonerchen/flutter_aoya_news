

import 'package:flutter/material.dart';
import 'package:flutter_aoya_news/value/style.dart';
import 'package:flutter_aoya_news/widget/base.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseWidget.getBaseAppBar("关于我们",iconColor: Colors.white),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 100,),
            Image.asset("images/login_icon.png",width: 100,),
            SizedBox(height: 50,),
            Text("澳亚财经是依托于澳门特别行政区政府批给卫星电视运营准照 的持牌公司“澳亚卫视”投资的集投行孵化、咨询研究、技术服 务、量化操作、市值管理以及交易所、行业新闻等一站式区块 链产业新商业公司，依托主体媒体平台全面助力优质区块链项 目，全方位“经济模型市值管理-社群-交易所-媒体-市值管理” 全程服务、自助式、一站式为区块链创业者提供立体项目孵化",style: MyTextStyle.TEXT_S14_C33,),
          ],
        ),
      ),
    );
  }
}
