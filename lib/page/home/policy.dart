

import 'package:flutter/material.dart';
import 'package:flutter_aoya_news/http/dio_utils.dart';
import 'package:flutter_aoya_news/http/url.dart';
import 'package:flutter_aoya_news/model/banner.dart';
import 'package:flutter_aoya_news/model/tab.dart';
import 'package:flutter_aoya_news/page/base/web.dart';
import 'package:flutter_aoya_news/page/home/content_details.dart';
import 'package:flutter_aoya_news/utils/date.dart';
import 'package:flutter_aoya_news/value/colors.dart';
import 'package:flutter_aoya_news/value/style.dart';
import 'package:flutter_aoya_news/widget/base.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../app.dart';

class PolicyPage extends StatefulWidget {

  final tabId;

  PolicyPage(this.tabId);

  @override
  _PolicyPageState createState() => _PolicyPageState();
}

class _PolicyPageState extends State<PolicyPage> with AutomaticKeepAliveClientMixin {

  RefreshController _refreshController;
  int page = 1;
  int size = 20;

  List<TabContent> tabContentList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refreshController = new RefreshController();
    Future.delayed(Duration.zero,(){
      _refresh();
    });
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
      backgroundColor: Colors.white,
      body: SmartRefresher(
        controller: _refreshController,
        enablePullUp:true,
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
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                SizedBox(height: 19,),
                _buildBanner(),
                _buildList(),
//                _buildHot(),
//                _buildHot(),
//                Container(height: 10,color: MyColors.GRAY_TEXT_F6,),
//                _buildHot(),
//                Divider(height: 1,),
//                _buildFast(),
//                Container(height: 10,color: MyColors.GRAY_TEXT_F6,),
//                _buildTopic(),
//                Divider(height: 1,),
//                _buildHot(),
//                Container(height: 10,color: MyColors.GRAY_TEXT_F6,),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildBanner(){
    return Consumer<BannerModel>(
      builder: (context,bannerModel,child) => Container(
        height: 150,
        child: bannerModel.bannerInfo.length > 0 ? Swiper(
          itemCount:bannerModel.bannerInfo.length,
          autoplay: true,
          onTap: (index){
            Navigator.push(context,MaterialPageRoute(builder: (context) => WebViewPage(bannerModel.bannerInfo[index].link)));
          },
          onIndexChanged:(index){

          },
          autoplayDisableOnInteraction:true,
          itemBuilder: (context,index){
            return Container(
              height: 150,
              margin: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(bannerModel.bannerInfo[index].images),
                ),
              ),
            );
          },
        ) : Container(height: 0,),
      ),
    );
  }

  Widget _buildList(){
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: tabContentList.length > 0 ? _buildItem() : BaseWidget.getEmptyWidget(),
    );
  }

  List<Widget> _buildItem(){
    return List.generate(tabContentList.length, (index) => _buildHot(tabContentList[index]));
  }

  ///
  /// 热门
  /// 
  Widget _buildHot(TabContent tabContent){
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return ContentDetailsPage(tabContent.id);
        }));
      },
      child: Container(
        height: 110,
        margin: EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15,),
                  Expanded(child: Text(tabContent.title,style: MyTextStyle.TEXT_S14_C33,maxLines: 3,softWrap: true,overflow: TextOverflow.ellipsis,)),
                  Row(
                    children: [
                      Image.asset("images/hot_flag.png",width: 31,height: 14,),
                      Expanded(child: Text("${tabContent.resource} ${DateUtils.formatAgo(DateTime.parse(tabContent.createdAt))}",style: MyTextStyle.TEXT_S10_C99,overflow: TextOverflow.ellipsis,softWrap: true,maxLines: 1,)),
                    ],
                  ),
                  SizedBox(height: 15,),
                ],
              ),
            ),
            SizedBox(width: 10,),
            Image.network(tabContent.thumbnail,width: 140,height: 80,),
          ],
        ),
      ),
    );
  }

  ///
  /// 快讯
  ///
  Widget _buildFast(){
    return Container(
      height: 86,
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 15,),
          Text("YFI继续上扬，日内最高涨至15028。96美元，24小时",style: MyTextStyle.TEXT_S14_C33,),
          Expanded(child: Container(width: 1,)),
          Row(
            children: [
              Image.asset("images/fast_flag.png",width: 31,height: 14,),
              Text("1小时前",style: MyTextStyle.TEXT_S10_C99,),
            ],
          ),
          SizedBox(height: 15,),
        ],
      ),
    );
  }
  
  ///
  /// 专题
  /// 
  Widget _buildTopic(){
    return Container(
      height: 161,
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          SizedBox(height: 15,),
          Container(
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("images/def_topic_banner.png"),
              ),
            ),
          ),
          Expanded(child: Container(width: 1,)),
          Row(
            children: [
              Image.asset("images/topic_flag.png",width: 31,height: 14,),
              Text("1小时前",style: MyTextStyle.TEXT_S10_C99,),
            ],
          ),
          SizedBox(height: 15,),

        ],
      ),
    );
  }

  _refresh()async{
    if(App.context != null) {
      BannerModel bannerModel = Provider.of<BannerModel>(App.context);
      bannerModel.getBanner();
    }

    var result = await DioUtils.getInstance().get(URL.homeTabContent,params: <String,dynamic>{
      "page":page,
      "size":size,
      "column_id":widget.tabId
    });
    tabContentList = TabContent.formJsonList(result["data"]);
    print(result);
    if(mounted)
    setState(() {

    });

  }

  _load()async{
    List<TabContent> tabResultList;
    var result = await DioUtils.getInstance().get(URL.homeTabContent,params: <String,dynamic>{
      "page":page,
      "size":size,
      "column_id":widget.tabId
    });
    tabResultList = TabContent.formJsonList(result["data"]);
    tabContentList.addAll(tabResultList);
    setState(() {

    });
  }

  @override
  bool get wantKeepAlive => true;

}
