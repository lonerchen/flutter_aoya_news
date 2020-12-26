import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aoya_news/app.dart';
import 'package:flutter_aoya_news/model/user.dart';
import 'package:flutter_aoya_news/page/account/login.dart';
import 'package:flutter_aoya_news/page/base/web.dart';
import 'package:flutter_aoya_news/page/column/my_column.dart';
import 'package:flutter_aoya_news/page/mine/about.dart';
import 'package:flutter_aoya_news/page/mine/favorites.dart';
import 'package:flutter_aoya_news/page/mine/follow.dart';
import 'package:flutter_aoya_news/page/mine/info.dart';
import 'package:flutter_aoya_news/value/style.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:oktoast/oktoast.dart';

class TabMinePage extends StatefulWidget {
  @override
  _TabMinePageState createState() => _TabMinePageState();
}

class _TabMinePageState extends State<TabMinePage> {

  RefreshController _refreshController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refreshController = new RefreshController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _refreshController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer<UserModel>(
          builder:(context,userModel,child) => SmartRefresher(
            controller: _refreshController,
            onRefresh: (){
              _refreshController.refreshCompleted();
            },
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    SizedBox(height: 44,),
                    SizedBox(height: 32,),
                    _buildUserInfo(userModel.userInfo),
                    SizedBox(height: 20,),
                    _buildToolBar(),
                    SizedBox(height: 21,),
                    _buildJoin(),
                    _buildFeatures(),
                  ],
                ),
              ),
            ),
          ),
        )
    );
  }

  Widget _buildUserInfo(UserInfo userInfo){
    return InkWell(
      onTap: (){
        //token是空的时候跳到登录页面
        showToast("暂未开放，敬请期待～");
//        if(App.accountToken == null) {
//          Navigator.push(context, MaterialPageRoute(builder: (context) {
//            return LoginPage();
//          }));
//        }else{
//          //如果已经登录的话，跳转到修改资料页面
//          Navigator.push(context, MaterialPageRoute(builder: (context) {
//            return EditInfoPage();
//          }));
//        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          children: [
            Container(
              width: 68,
              height: 68,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: userInfo.avatar == null ? AssetImage("images/def_avatar.png") : NetworkImage(userInfo.avatar),
                ),
                borderRadius: BorderRadius.circular(90),
              ),
            ),
            SizedBox(width: 12,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(userInfo.name ?? "请编辑昵称",style: MyTextStyle.TEXT_S16_C33_W6,),
                  SizedBox(height: 10,),
                  Text("编辑资料",style: MyTextStyle.TEXT_S14_C99,),
                ],
              ),
            ),
            Image.asset("images/arrow_right.png",width: 9,height: 15,),
          ],
        ),
      ),
    );
  }

  Widget _buildToolBar(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 19),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: (){

              showToast("暂未开放，敬请期待～");
//              Navigator.push(context, MaterialPageRoute(builder: (context) =>MyColumnPage()));
            },
            child: Column(
              children: [
                Image.asset("images/mine_column.png",width: 24,height: 24,),
                SizedBox(height: 3,),
                Text("我的专栏",style: MyTextStyle.TEXT_S14_C33,),
              ],
            ),
          ),
          InkWell(
            onTap: (){

//              showToast("暂未开放，敬请期待～");
              Navigator.push(context, MaterialPageRoute(builder: (context) => FollowPage()));
            },
            child: Column(

              children: [
                Image.asset("images/mine_follow.png",width: 24,height: 24,),
                SizedBox(height: 3,),
                Text("我的关注",style: MyTextStyle.TEXT_S14_C33,),
              ],
            ),
          ),
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => FavoritesPage()));

            },
            child: Column(
              children: [
                Image.asset("images/mine_favorites.png",width: 24,height: 24,),
                SizedBox(height: 3,),
                Text("我的收藏",style: MyTextStyle.TEXT_S14_C33,),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJoin(){
    return InkWell(
      onTap: (){
        showToast("暂未开放，敬请期待～");
//        Navigator.push(context, route)
      },
      child: Container(
        height: 86,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fitWidth,
                image: AssetImage(
                  "images/column_join.png",
                )
            )
        ),
      ),
    );
  }

  Widget _buildFeatures(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [
          InkWell(
            onTap: (){
              showToast("当前没有缓存数据～");
            },
            child: Container(
              height: 49,
              child: Row(
                children: [
                  Text("清除缓存",style: MyTextStyle.TEXT_S14_C33,),
                  Expanded(child: Container(height: 0,)),
                  Text("0.0MB",style: MyTextStyle.TEXT_S12_CCC,),
                  SizedBox(width: 13,),
                  Image.asset("images/arrow_right.png",width: 6,height: 11,),
                ],
              ),
            ),
          ),
          Divider(height: 1,),
          InkWell(
            onTap: (){
              showToast("当前没有新版本～");
            },
            child: Container(
              height: 49,
              child: Row(
                children: [
                  Text("检查更新",style: MyTextStyle.TEXT_S14_C33,),
                  Expanded(child: Container(height: 0,)),
                  Text("无新版本",style: MyTextStyle.TEXT_S12_CCC,),
                  SizedBox(width: 13,),
                  Image.asset("images/arrow_right.png",width: 6,height: 11,),
                ],
              ),
            ),
          ),
          Divider(height: 1,),
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => AboutPage()
              ));
            },
            child: Container(
              height: 49,
              child: Row(
                children: [
                  Text("关于我们",style: MyTextStyle.TEXT_S14_C33,),
                  Expanded(child: Container(height: 0,)),
                  Image.asset("images/arrow_right.png",width: 6,height: 11,),
                ],
              ),
            ),
          ),
//          Divider(height: 1,),
//          InkWell(
//            onTap: (){
//              Navigator.push(context, MaterialPageRoute(builder: (context) {
//                return GamePage();
//              }));
//            },
//            child: Container(
//              height: 49,
//              child: Row(
//                children: [
//                  Text("退出账号",style: MyTextStyle.TEXT_S14_C33,),
//                  Expanded(child: Container(height: 0,)),
//                  Image.asset("images/arrow_right.png",width: 6,height: 11,),
//                ],
//              ),
//            ),
//          ),
        ],
      ),
    );
  }



}

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {

  List<Bor> borList = [
  ];

  int fraction = 0;

  int refresh = 1000;//刷新毫秒数

  int difficulty = 1;//对应的难度

  int miss = 0;//遗漏

  Timer timer;

  int startFlag = 0;//0 默认，1 是游戏开始 ，2游戏结算画面

  int countDown = 60;

  @override
  void initState() {
    super.initState();
  }

  _start(){
    if(startFlag == 1){
      print("游戏已开始");
      return;
    }
    _reset();
    startFlag = 1;
    timer = Timer.periodic(Duration(milliseconds: refresh), (timer) {
      countDown --;
      if(countDown == 45 || countDown == 30 || countDown == 15){
        difficulty ++;
        print("难度增加");
      }
      if(countDown <= 0){
        _end();
        print("游戏结束");
      }
//      setState(() {
        _refreshBor();
//      });
    });
  }

  _end(){
    startFlag = 2;
    borList = new List();
    timer.cancel();
  }

  _reset(){
    setState(() {
      fraction = 0;
      refresh = 1000;
      difficulty = 1;
      countDown = 60;
      miss = 0;
      startFlag = 0;
    });

  }

  _refreshBor(){

    if(borList.length != 0){
      miss += borList.length;
    }
    Future.sync((){
      borList = new List();
      for(int i = 0;i < difficulty;i++){
        double sizeWidth = MediaQuery.of(context).size.width - 110;
        double x = Random().nextDouble() * sizeWidth;
        double sizeHeight = MediaQuery.of(context).size.height - 180;
        double y = Random().nextDouble() * sizeHeight;
        borList.add(
            Bor(i, true, x, y)
        );
      }
      setState(() {

      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer.cancel();
    timer = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("分数:$fraction 倒计时:$countDown miss:$miss",style: TextStyle(fontSize: 12),),
        actions: [
//          IconButton(icon: Icon(Icons.settings), onPressed: (){
//            _showSettingDialog();
//          }),
          IconButton(icon: Icon(Icons.timer), onPressed: (){
            _start();
          }),
          IconButton(icon: Icon(Icons.refresh), onPressed: (){
            _reset();
          }),
//          IconButton(icon: Icon(Icons.title), onPressed: (){
//            setState(() {
//              borList = [new Bor(0, true, 360, 500)];
//
//            });
//          }),
        ],
      ),
      body: Stack(
        children: List.generate(borList.length, (index){

          return _buildBor(borList[index].x,borList[index].y,index);
        }),
      ),
    );
  }

  Widget _buildBor(double x,double y,int index){
    return GestureDetector(
      onTap: (){
        setState(() {
          Future.sync((){
            borList.removeAt(index);
            fraction ++;
          });
        });
      },
      child: Visibility(
        visible: borList[index].isShow,
        child: Container(
          padding: EdgeInsets.all(30),
          child: Container(
            width: 30,
            height: 30,
            margin: EdgeInsets.only(left: x,top: y),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(90),
            ),
          ),
        ),
      ),
    );
  }

}

class Bor{
  int id = 0;
  bool isShow = true;
  double x = 0.0;
  double y = 0.0;

  Bor(this.id, this.isShow, this.x, this.y);

}
