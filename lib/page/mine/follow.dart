
import 'package:flutter/material.dart';
import 'package:flutter_aoya_news/model/follow.dart';
import 'package:flutter_aoya_news/value/colors.dart';
import 'package:flutter_aoya_news/value/style.dart';
import 'package:flutter_aoya_news/widget/base.dart';

///
/// 我的关注
///

class FollowPage extends StatefulWidget {
  @override
  _FollowPageState createState() => _FollowPageState();
}

class _FollowPageState extends State<FollowPage> {

  List<Follow> followList = [
//    Follow(),
//    Follow(),
//    Follow(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: BaseWidget.getBaseAppBar("我的关注",color: Colors.white,iconColor: MyColors.GRAY_TEXT_66,textColor: MyColors.BLACK_TEXT_33),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: ListView(
          children: followList.length > 0 ? _buildItem() : BaseWidget.getEmptyWidget(),
        ),
      ),
    );
  }

  List<Widget> _buildItem(){
    return List.generate(followList.length, (index) => Column(
      children: [
        Container(
          height: 84,
          child: Row(
            children: [
              Image.asset("${followList[index].avatar}",width: 42,height: 42,),
              SizedBox(width: 16,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("${followList[index].name}",style: MyTextStyle.TEXT_S16_CTIT_W6,),
                    Text("${followList[index].remark}",style: MyTextStyle.TEXT_S12_C99,),
                  ],
                ),
              ),
              Container(
                width: 52,
                height: 22,
                decoration: BoxDecoration(
                  border: Border.all(color: MyColors.THEME_COLORS,width: 1),
                  borderRadius: BorderRadius.circular(4)
                ),
                child: Center(child: Text("已关注",style: MyTextStyle.TEXT_S12_CTIT,)),
              )
            ],
          ),
        ),
        Divider(height: 1,),
      ],
    ));
  }

}
