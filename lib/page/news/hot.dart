

import 'package:flutter/material.dart';
import 'package:flutter_aoya_news/http/dio_utils.dart';
import 'package:flutter_aoya_news/http/url.dart';
import 'package:flutter_aoya_news/model/hot.dart';
import 'package:flutter_aoya_news/page/home/content_details.dart';
import 'package:flutter_aoya_news/utils/date.dart';
import 'package:flutter_aoya_news/value/style.dart';
import 'package:flutter_aoya_news/widget/base.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:intl/intl.dart';

class HotPage extends StatefulWidget {
  @override
  _HotPageState createState() => _HotPageState();
}

class _HotPageState extends State<HotPage>  with AutomaticKeepAliveClientMixin {

  List<HotBean> hotNewsList = [
  ];

  RefreshController _refreshController;

  @override
  void initState() {
    super.initState();
    _refreshController = new RefreshController();
    _refresh();
  }

  @override
  void dispose() {
    super.dispose();
    _refreshController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SmartRefresher(
          controller: _refreshController,
          onRefresh: (){
            _refresh();
            _refreshController.refreshCompleted();
          },
          child: ListView(
            children: hotNewsList.length >0 ? _buildItem() : BaseWidget.getEmptyWidget(),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildItem(){
    return List.generate(hotNewsList.length, (index) => InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return ContentDetailsPage(hotNewsList[index].id);
        }));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        height: 133,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(height: 15,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 120,
                  height: 78,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fitWidth,
                        image: NetworkImage(hotNewsList[index].thumbnail),
                    ),
                    borderRadius: BorderRadius.circular(6)
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "${hotNewsList[index].title}",
                        style: MyTextStyle.TEXT_S14_C33_W6,
                        maxLines: 2,
                      ),
                      SizedBox(height: 18,),
                      Text("${hotNewsList[index].summary}",style: MyTextStyle.TEXT_S12_C66,maxLines: 1,overflow: TextOverflow.ellipsis,softWrap: true,)
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 11,),
            Row(
              children: [
                Text("来自：${hotNewsList[index].author}  ${DateUtils.formatAgo(DateTime.parse(hotNewsList[index].createdAt))}",style: MyTextStyle.TEXT_S10_C99,),
                Expanded(child: Container(height: 0,)),
                Image.asset("images/news_look.png",width: 16,height: 16,),
                SizedBox(width: 6,),
                Text("${hotNewsList[index].watchCounts}",style: MyTextStyle.TEXT_S10_C99,),
              ],
            ),
            Expanded(child: Container(width: 0,)),
            Divider(height: 1,),
          ],
        ),
      ),
    ));
  }

  _refresh(){
    Future.delayed(Duration.zero,()async{
      var result = await DioUtils.getInstance().get(URL.hotNews,params:<String,dynamic>{
        "start":DateFormat("yyyy-MM-dd+HH:mm:ss").format(DateTime.now().subtract(Duration(days: 7))),
        "end":DateFormat("yyyy-MM-dd+HH:mm:ss").format(DateTime.now()),
      });
      hotNewsList = HotBean.formJsonList(result);
      setState(() {

      });
    });
  }

  @override
  bool get wantKeepAlive => true;

}
