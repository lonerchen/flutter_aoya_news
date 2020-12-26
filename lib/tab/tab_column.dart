

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_aoya_news/model/column.dart';
import 'package:flutter_aoya_news/page/home/search.dart';
import 'package:flutter_aoya_news/value/colors.dart';
import 'package:flutter_aoya_news/value/style.dart';
import 'package:flutter_aoya_news/widget/base.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:oktoast/oktoast.dart';

///
/// 专栏
///
class TabColumnPage extends StatefulWidget {
  @override
  _TabColumnPageState createState() => _TabColumnPageState();
}

class _TabColumnPageState extends State<TabColumnPage> {

  int filterIndex = 0;
  List<String> filterList = [
    "最热",
    "最新",
  ];
  List<ColumnBean> columnList = [
//    ColumnBean(),
//    ColumnBean(),
//    ColumnBean(),
  ];

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
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 44,),
            _buildTitle(),
            SizedBox(height: 27,),
            _buildJoin(),
            SizedBox(height: 20,),
            _buildFilter(),
            SizedBox(height: 24,),
            _buildList(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(){
    return Container(
      height: 33,
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          Image.asset("images/title_icon.png",width: 104,height: 25,),
          SizedBox(width: 47,),
          Expanded(
            child: InkWell(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => SearchPage()));
              },
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                  color: MyColors.GRAY_TEXT_EE,
                  borderRadius: BorderRadius.circular(30),

                ),

                child: Row(
                  children: [
                    SizedBox(width: 15,),
                    Text("交易大师",style: MyTextStyle.TEXT_S12_C99,),
                    Expanded(child: Container(height: 1,)),
                    Icon(Icons.search,color: MyColors.GRAY_TEXT_99,),
                    SizedBox(width: 15,),
                  ],
                ),
              ),
            ),
          )
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

  Widget _buildFilter(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          Text("专栏",style: MyTextStyle.TEXT_S16_C33_W6,),
          Expanded(child: Container(
            height: 1,
          )),
          Row(
            children: List.generate(filterList.length, (index) => InkWell(
              onTap: (){
                setState(() {
                  filterIndex = index;
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 11,vertical: 4),
                margin: EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: index == filterIndex ? MyColors.THEME_COLORS : MyColors.GRAY_TEXT_C7),
                    borderRadius: BorderRadius.circular(25)
                ),
                child: Text(
                  filterList[index],
                  style: index == filterIndex ? MyTextStyle.TEXT_S12_CTIT : MyTextStyle.TEXT_S12_C99,
                ),
              ),
            )),
          ),
        ],
      ),
    );
  }
  
  Widget _buildList(){
    return Expanded(
      child: SmartRefresher(
        controller: _refreshController,
        onRefresh: (){
          _refreshController.refreshCompleted();
        },
        child: ListView(
          children: columnList.length > 0 ? _buildItem() : BaseWidget.getEmptyWidget(),
        ),
      ),
    );
  }

  List<Widget> _buildItem(){
    return List.generate(columnList.length, (index) => Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      margin: EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Container(
            width: 130,
            height: 74,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(columnList[index].img),
              )
            ),
          ),
          SizedBox(width: 16,),
          Expanded(
            child: Column(
              children: [
                Text("${columnList[index].title}",style: MyTextStyle.TEXT_S14_C33_W6,maxLines: 2,),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(columnList[index].avatar),
                        ),
                        borderRadius: BorderRadius.circular(90),
                      ),
                    ),
                    SizedBox(width: 8,),
                    Text("${columnList[index].author}",style: MyTextStyle.TEXT_S12_CTIT,),
                    Expanded(child: Container(height: 0,)),
                    Image.asset("images/news_look.png",width: 12,height: 8,),
                    SizedBox(width: 2,),
                    Text("${columnList[index].look}",style: MyTextStyle.TEXT_S12_C99,),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    ));
  }

}
