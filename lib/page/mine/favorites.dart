
import 'package:flutter/material.dart';
import 'package:flutter_aoya_news/model/favorites.dart';
import 'package:flutter_aoya_news/value/colors.dart';
import 'package:flutter_aoya_news/value/style.dart';
import 'package:flutter_aoya_news/widget/base.dart';

class FavoritesPage extends StatefulWidget {
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {

  List<FavoritesBean> favoritesList = [
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseWidget.getBaseAppBar("我的收藏",color: Colors.white,iconColor: MyColors.GRAY_TEXT_66,textColor: MyColors.BLACK_TEXT_33),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: ListView(
          children: favoritesList.length > 0 ? _buildItem() : BaseWidget.getEmptyWidget(),
        ),
      ),
    );
  }

  List<Widget> _buildItem(){
    return List.generate(favoritesList.length, (index) => Column(
      children: [
        Container(
          height: 84,
          child: Row(
            children: [
              Image.asset("${favoritesList[index].img}",width: 100,height: 56,),
              SizedBox(width: 10,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("${favoritesList[index].title}",style: MyTextStyle.TEXT_S16_CTIT_W6,),
                    SizedBox(height: 19,),
                    Row(
                      children: [
                        Text("${favoritesList[index].author}",style: MyTextStyle.TEXT_S12_C99,),
                        Expanded(child: Container(height: 1,)),
                        Container(
                          width: 60,
                          height: 22,
                          decoration: BoxDecoration(
                              border: Border.all(color: MyColors.THEME_COLORS,width: 1),
                              borderRadius: BorderRadius.circular(4)
                          ),
                          child: Center(child: Text("取消收藏",style: MyTextStyle.TEXT_S12_CTIT,)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Divider(height: 1,),
      ],
    ));
  }

}
