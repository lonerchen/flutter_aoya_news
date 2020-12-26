

import 'package:flutter/material.dart';
import 'package:flutter_aoya_news/model/banner.dart';
import 'package:flutter_aoya_news/model/tab.dart';
import 'package:flutter_aoya_news/page/home/policy.dart';
import 'package:flutter_aoya_news/page/home/search.dart';
import 'package:flutter_aoya_news/page/home/topic.dart';
import 'package:flutter_aoya_news/model/coin.dart';
import 'package:flutter_aoya_news/value/colors.dart';
import 'package:flutter_aoya_news/value/style.dart';
import 'package:flutter_aoya_news/widget/base.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:provider/provider.dart';

class TabHomePage extends StatefulWidget {
  @override
  _TabHomePageState createState() => _TabHomePageState();
}

class _TabHomePageState extends State<TabHomePage> with TickerProviderStateMixin{

  List<Coin> coin = [
    Coin(), Coin(), Coin(),
  ];

  List<Tab> tabList = <Tab>[
//    new Tab(text: "头条",),
//    new Tab(text: "政策",),
    new Tab(text: "专题",),
//    new Tab(text: "DeFi",),
//    new Tab(text: "矿业",),
//    new Tab(text: "以太坊2.0",),
  ];

  TabController _tabController;

  RefreshController _refreshController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = new TabController(length: tabList.length, vsync: this);
    _refreshController = new RefreshController();

    Future.delayed(Duration.zero,(){
      _refresh();
    });

  }



  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController.dispose();
    _refreshController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        body: Container(
          child: Column(
            children: [
              SizedBox(height: 44,),
              _buildTitle(),
              SizedBox(height: 27,),
              _buildCoinList(),
              SizedBox(height: 20,),
              Container(height: 10,color: MyColors.GRAY_TEXT_F6,),
              SizedBox(height: 20,),
              _buildTab(),
              Divider(height: 1,),
              _buildTabView(),
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
          SizedBox(width: 13,),
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

  Widget _buildCoinList(){
    return Consumer<CoinModel>(
      builder: (context,coinModel,child) =>Container(
        height: 34,
        margin: EdgeInsets.only(left: 15),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: coinModel.coinList.length > 0 ? _buildItem(coinModel) : BaseWidget.getEmptyWidget(),
        ),
      ),
    );
  }

  List<Widget> _buildItem(CoinModel coinModel){
    return List.generate(coinModel.coinList.length, (index){
      return Container(
        child: Row(
          children: [
//            Image.network("${coinModel.coinList[index].logo}",width: 34,height: 34,),
            SizedBox(width: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("${coinModel.coinList[index].symbol}",style: MyTextStyle.TEXT_S12_C33,),
                Text("${coinModel.coinList[index].percentChange24h}%",style: coinModel.coinList[index].percentChange24h >= 0 ? MyTextStyle.TEXT_S12_G7A : MyTextStyle.TEXT_S12_RE2,),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              width: 1,
              height: 34,
              color: MyColors.GRAY_TEXT_D8,
            ),

          ],
        ),
      );
    });
  }

  Widget _buildTab(){
    return Container(
      child: TabBar(
        controller: _tabController,
        tabs: tabList,
        labelColor: MyColors.THEME_COLORS,
        unselectedLabelColor: MyColors.BLACK_TEXT_22,
        labelStyle: TextStyle(fontSize: 16),
        unselectedLabelStyle: TextStyle(fontSize: 14),
        indicatorColor: MyColors.THEME_COLORS,
        indicatorSize: TabBarIndicatorSize.label,
        isScrollable: true,
      ),
    );
  }

  Widget _buildTabView(){
    return Expanded(
      child: Container(
        child: TabBarView(
            controller: _tabController,
            children: _buildTabViewList(),
        ),
      ),
    );
  }

  List<Widget> _buildTabViewList(){
    TabModel tabModel = Provider.of<TabModel>(context);
    return List.generate(tabList.length, (index) {
      //专题跳不同页面
      if(tabList[index].text == "专题"){
        return TopicPage();
      }else{
        //其它的统一跳到一个页面用id区分内容
        return PolicyPage(tabModel.tabInfo[index].id);
      }
    });
  }

  ///
  /// 刷新数据
  ///
  _refresh()async{
    //banner图
    BannerModel bannerModel = Provider.of<BannerModel>(context);
    bannerModel.getBanner();

    //请求tab标题栏
    TabModel tabModel = Provider.of<TabModel>(context);
    await tabModel.getTab();
    tabList = new List();
    //将网络请求下来的Tab转化成Widget的Tab
    tabModel.tabInfo.forEach((element) {
      tabList.add(Tab(text: element.title,));
    });
    //加入专栏，额外的标题，专题，专题跳到不一样的页面
    tabList.add(Tab(text: "专题",),);
    _tabController = new TabController(length: tabList.length, vsync: this);
    setState(() {});

    //币种刷新
    CoinModel coinModel = Provider.of<CoinModel>(context);
    coinModel.getCoinList();

  }

}
