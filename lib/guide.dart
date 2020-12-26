import 'package:flutter/material.dart';
import 'package:flutter_aoya_news/widget/base.dart';

///
/// 第一次进入app的页面
/// 或者版本更新的指导页面
///

class GuildPage extends StatefulWidget {
  @override
  _GuildPageState createState() => _GuildPageState();
}

class _GuildPageState extends State<GuildPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: WillPopScope(
        onWillPop: (){
          return Future.value(false);
        },
        child: PageView(
          children: [
            Image.asset("images/guild1.png",fit: BoxFit.fitHeight),
            Image.asset("images/guild2.png",fit: BoxFit.fitHeight),
            Container(
              padding: EdgeInsets.only(bottom: 15),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset("images/guild3.png",fit: BoxFit.fitHeight,),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: BaseWidget.getBaseButton(text: "进入主页",onPressed: (){
                        Navigator.pop(context);
                      }),
                    )
                  ],
                ),
            ),
          ],
        ),
      ),
    );
  }
}
