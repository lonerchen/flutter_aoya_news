import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aoya_news/http/dio_utils.dart';
import 'package:flutter_aoya_news/http/url.dart';
import 'package:flutter_aoya_news/model/news.dart';
import 'package:flutter_aoya_news/page/base/share_dialog.dart';
import 'package:flutter_aoya_news/page/base/web.dart';
import 'package:flutter_aoya_news/value/colors.dart';
import 'package:flutter_aoya_news/value/string.dart';
import 'package:flutter_aoya_news/value/style.dart';
import 'package:flutter_aoya_news/widget/base.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:intl/intl.dart';

import 'news_details.dart';

///
/// 快讯
///

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage>  with AutomaticKeepAliveClientMixin {

  RefreshController _refreshController = new RefreshController();

  List<NewsBean> newsList = [
  ];

  int size = 10;
  int page = 1;

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  @override
  void dispose() {
    super.dispose();
    _refreshController.dispose();
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
          child: Stack(
            children: [
              Container(
                width: 1,
                margin: EdgeInsets.only(left: 20),
                height :1000,color: MyColors.GRAY_TEXT_D5,
              ),
              SmartRefresher(
                controller: _refreshController,
                enablePullDown: true,
                enablePullUp: true,
                onRefresh: (){
                  page = 1;
                  _refresh();
                  _refreshController.refreshCompleted();
                },
                onLoading: (){
                  page ++;
                  _load();
                  _refreshController.loadComplete();
                },
                child: ListView(
                padding: EdgeInsets.zero,
                  children: newsList.length > 0 ? _buildItem() : BaseWidget.getEmptyWidget(),
                ),
              ),
            ],
          ),
      ),
    );
  }

  List<Widget> _buildItem(){
    return List.generate(newsList.length, (index) => InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>NewsDetailsPage(newsList[index].id)));
      },
      child: Container(
        child: Column(
          children: [
            //todo 该日期如果时间相同的情况下，不重复显示
            Align(
              alignment: Alignment.centerLeft,
              child: Visibility(
                visible: index == 0,
                  child:Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 15),
                      child: Text("今天 ${DateFormat("MM月dd").format(DateTime.now())} 星期${StringFormat.numberToCn(DateTime.now().weekday)}",style: MyTextStyle.TEXT_S12_C99,),
                  ),
              ),
            ),
            Container(height: 15,color: Colors.white,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 15,
                      width: 40,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("images/news_index.png"),
                          fit: BoxFit.fill,
                        )
                      ),
                      child: Container(
                        padding: EdgeInsets.only(right: 4),
                          child: Center(child: Text(DateFormat("HH:mm").format(DateTime.parse(newsList[index].createdAt)),style: MyTextStyle.TEXT_S10_WHITE,))
                      ),
                    ),
                    Container(height: 15,width:40,color: Colors.white,),
                  ],
                ),
                SizedBox(width: 3,),
                Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${newsList[index].title}",style: MyTextStyle.TEXT_S14_C33,),
                        SizedBox(height: 15,),
                        Text("${newsList[index].content}",style: MyTextStyle.TEXT_S12_C99,),

                        SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [

                            InkWell(
                              onTap: (){
                                showDialog(context: context,builder: (context){
                                  return ShareSaveDialog("https://www.aoya.news/special/detail/news?id=${newsList[index].id}", newsList[index].title);
                                });
                              },
                              child: Container(
                                child: Row(
                                  children: [
                                    Image.asset("images/news_share.png",width: 14,height: 14,),
                                    SizedBox(width: 4,),
                                    Text("分享",style: MyTextStyle.TEXT_S12_CTIT,),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 30,),
                            InkWell(
                              onTap: (){
                                _bear(1,newsList[index].id);
                              },
                              child: Container(
                                child: Row(
                                  children: [
                                    Image.asset("images/news_up.png",width: 14,height: 14,),
                                    SizedBox(width: 4,),
                                    Text("利好${newsList[index].upCounts}",style: MyTextStyle.TEXT_S12_CC7,),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 30,),
                            InkWell(
                              onTap: (){
                                _bear(2, newsList[index].id);
                              },
                              child: Container(
                                child: Row(
                                  children: [
                                    Image.asset("images/news_down.png",width: 14,height: 14,),
                                    SizedBox(width: 4,),
                                    Text("利空${newsList[index].downCounts}",style: MyTextStyle.TEXT_S12_CC7,),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 30,),
                            Visibility(
                              visible: newsList[index].link != null && newsList[index].link != "",
                              child: InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context){
                                    return WebViewPage(newsList[index].link);
                                  }));
                                },
                                child: Container(
                                  child: Row(
                                    children: [
                                      Image.asset("images/news_link.png",width: 14,height: 14,),
                                      SizedBox(width: 4,),
                                      Text("原文链接",style: MyTextStyle.TEXT_S12_CTIT,),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 30,),
                          ],
                        ),

                        SizedBox(height: 30,),
                      ],
                    )
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }

  _refresh(){
    Future.delayed(Duration.zero,()async{
      var result = await DioUtils.getInstance().get(URL.news24H,params: <String,dynamic>{
        "day":DateFormat("yyyy-MM-dd").format(DateTime.now()),
        "size":size,
        "page":page,
      });
      newsList = NewsBean.formJsonList(result["data"]);
      setState(() {

      });
    });
  }

  _load(){
    Future.delayed(Duration.zero,()async{
      var result = await DioUtils.getInstance().get(URL.news24H,params: <String,dynamic>{
        "day":DateFormat("yyyy-MM-dd").format(DateTime.now()),
        "size":size,
        "page":page,
      });
      newsList.addAll(NewsBean.formJsonList(result["data"]));
      setState(() {

      });
    });
  }

  ///
  /// type 1 利好 2 利空
  /// id 新闻id
  ///
  _bear(int type,int id)async{
    var result = await DioUtils.getInstance().post(URL.newsBear,body: <String,dynamic>{
      "id":id,
      "type":type
    });
    NewsBean bean = NewsBean.fromJson(result);
    for(int i = 0; i < newsList.length;i++){
      if(newsList[i].id == bean.id){
        newsList[i] = bean;
        setState(() {

        });
        return;
      }
    }
  }

  @override
  bool get wantKeepAlive => true;

}
