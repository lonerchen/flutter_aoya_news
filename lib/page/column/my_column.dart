

import 'package:flutter/material.dart';
import 'package:flutter_aoya_news/model/column.dart';
import 'package:flutter_aoya_news/model/my_column.dart';
import 'package:flutter_aoya_news/model/user.dart';
import 'package:flutter_aoya_news/page/column/publish_column.dart';
import 'package:flutter_aoya_news/value/colors.dart';
import 'package:flutter_aoya_news/value/style.dart';
import 'package:flutter_aoya_news/widget/base.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

///
/// 我的专栏
///
class MyColumnPage extends StatefulWidget {
  @override
  _MyColumnPageState createState() => _MyColumnPageState();
}

class _MyColumnPageState extends State<MyColumnPage> with TickerProviderStateMixin{

  TabController _tabController;

  RefreshController _refreshController;

  //tab选择
  final List<Tab> tabList = <Tab>[
    new Tab(text: "已发布",),
    new Tab(text: "待审核",),
    new Tab(text: "草稿箱",),
  ];

  List<MyColumnBean> columnBeanList = [
    MyColumnBean(),
    MyColumnBean(),
    MyColumnBean(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = new TabController(length: tabList.length, vsync: this);
    _refreshController = new RefreshController();
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
      appBar: BaseWidget.getBaseAppBar("我的专栏",iconColor: Colors.white),
      body: Container(
        child: Column(
          children: [
            _buildUserInfo(),
            _buildTab(),
            SizedBox(height: 20,),
            _buildTabView(),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfo(){
    return Consumer<UserModel>(
      builder: (context,userModel,child) => Container(
        height: 210,
        color: Colors.white,
        child: Stack(
          children: [
            Container(
              height: 159,
              color: MyColors.THEME_COLORS,
              padding: EdgeInsets.only(left: 15),
              child: Padding(
                padding: const EdgeInsets.only(bottom:30.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 68,
                      height: 68,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: userModel.userInfo.avatar == null ? AssetImage("images/def_avatar.png") : NetworkImage(userModel.userInfo.avatar)
                        ),
                        borderRadius: BorderRadius.circular(90),
                      ),
                    ),
                    SizedBox(width: 14,),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("${userModel.userInfo.name ?? "未编辑"}",style: MyTextStyle.TEXT_S18_WHITE_W6,),
                        SizedBox(height: 10,),
                        Text("编辑资料",style: MyTextStyle.TEXT_S14_WHITE,),
                      ],
                    ),
                    Expanded(child: Container(height: 0,)),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => PublishColumnPage()));
                      },
                      child: Container(
                        height: 36,
                        width: 111,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(18),
                            bottomLeft: Radius.circular(18),
                          )
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: 14,),
                            Image.asset("images/theme_arrow_left.png",width: 6,height: 10,),
                            SizedBox(width: 6,),
                            Text("发布专栏",style: MyTextStyle.TEXT_S16_CTIT_W6,)
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              height: 102,
              margin: EdgeInsets.only(
                top: 108
              ),
              child: Card(
                margin: EdgeInsets.all(15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("158.6万",style: MyTextStyle.TEXT_S16_CTIT_W6,),
                          SizedBox(height: 7,),
                          Text("浏览量",style: MyTextStyle.TEXT_S12_CBB,)
                        ],
                      ),
                    ),
                    Container(height: 47,width: 0.5,color: MyColors.LINE_COLOR_F2,),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("26",style: MyTextStyle.TEXT_S16_C33_W6,),
                          SizedBox(height: 7,),
                          Text("文章",style: MyTextStyle.TEXT_S12_CBB,)
                        ],
                      ),
                    ),
                    Container(height: 47,width: 0.5,color: MyColors.LINE_COLOR_F2,),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("82",style: MyTextStyle.TEXT_S16_C33_W6,),
                          SizedBox(height: 7,),
                          Text("粉丝",style: MyTextStyle.TEXT_S12_CBB,)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
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
          return _buildList(index);
        case 1:
          return _buildList(index);
        case 2:
          return _buildList(index);
        default:
          return Container();
      }
    });
  }

  Widget _buildList(int pageIndex){
    return Container(
      child: SmartRefresher(
        controller: _refreshController,
        onRefresh: (){
          _refreshController.refreshCompleted();
        },
        child: ListView(
          children: columnBeanList.length > 0 ? _buildItem(pageIndex) : BaseWidget.getEmptyWidget(),
        ),
      ),
    );
  }

  List<Widget> _buildItem(int pageIndex){
    return List.generate(columnBeanList.length, (index) => Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      margin: EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Container(
            width: 130,
            height: 74,
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(columnBeanList[index].img),
                )
            ),
          ),
          SizedBox(width: 16,),
          Expanded(
            child: Column(
              children: [
                Text("${columnBeanList[index].title}",style: MyTextStyle.TEXT_S14_C33_W6,maxLines: 2,),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Text("${columnBeanList[index].createTime}",style: MyTextStyle.TEXT_S12_C99,),
                    Expanded(child: Container(height: 0,)),
                    Text( pageIndex == 0 ? "删除" : pageIndex == 1 ? "待审核" : "编辑",style: MyTextStyle.TEXT_S12_CTIT,),
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
