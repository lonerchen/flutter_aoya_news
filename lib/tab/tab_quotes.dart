

import 'package:flutter/material.dart';
import 'package:flutter_aoya_news/page/home/search.dart';
import 'package:flutter_aoya_news/page/quotes/hot.dart';
import 'package:flutter_aoya_news/page/quotes/price.dart';
import 'package:flutter_aoya_news/value/colors.dart';
import 'package:flutter_aoya_news/value/style.dart';

//行情页面
class TabQuotesPage extends StatefulWidget {
  @override
  _TabQuotesPageState createState() => _TabQuotesPageState();
}

class _TabQuotesPageState extends State<TabQuotesPage> with TickerProviderStateMixin{

  TabController _tabController;

  //tab选择
  final List<Tab> tabList = <Tab>[
    new Tab(text: "市值排行",),
    new Tab(text: "热搜榜",),
    new Tab(text: "涨幅榜",),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = new TabController(length: tabList.length, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController.dispose();
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
    return List.generate(tabList.length, (index) {
      switch(index){
        case 0:
          return QuotesPricePage(1);
        case 1:
          return QuotesHotPage();
        default:
          return QuotesPricePage(2);
      }
    });
  }

}
