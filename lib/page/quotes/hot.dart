
import 'package:flutter/material.dart';
import 'package:flutter_aoya_news/tab/tab_home.dart';
import 'package:flutter_aoya_news/utils/format.dart';
import 'package:flutter_aoya_news/value/colors.dart';
import 'package:flutter_aoya_news/value/style.dart';
import 'package:flutter_aoya_news/widget/base.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:provider/provider.dart';

import '../../model/coin.dart';

///
/// 价格排行
/// 
class QuotesHotPage extends StatefulWidget {
  @override
  _QuotesHotPageState createState() => _QuotesHotPageState();
}

class _QuotesHotPageState extends State<QuotesHotPage>  with AutomaticKeepAliveClientMixin{

  RefreshController _refreshController;

  @override
  void initState() {
    super.initState();
    _refreshController = new RefreshController();
    _refresh();
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
      body: Consumer<CoinModel>(
        builder: (context,coinModel,child) => Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              SizedBox(height: 15,),
              _buildTitle(),
              SizedBox(height: 15,),
              _buildList(coinModel),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildTitle(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text("总市值(¥)",style: MyTextStyle.TEXT_S12_C99,),
            Image.asset("images/up_down.png",width: 10,height: 10,),
          ],
        ),
        Row(
          children: [
            Text("价格(¥)",style: MyTextStyle.TEXT_S12_C99,),
            Image.asset("images/up_down.png",width: 10,height: 10,),
          ],
        ),
        Row(
          children: [
            Text("24H热度(¥)",style: MyTextStyle.TEXT_S12_C99,),
            Image.asset("images/up_down.png",width: 10,height: 10,),
          ],
        ),
      ],
    );
  }

  Widget _buildList(CoinModel coinModel){
    return Expanded(
      child: SmartRefresher(
        controller: _refreshController,
        onRefresh: (){
          _refreshController.refreshCompleted();
        },
        child: ListView(
          children: coinModel.coinList.length > 0 ? _buildItem(coinModel) : BaseWidget.getEmptyWidget(),
        ),
      ),
    );
  }

  List<Widget> _buildItem(CoinModel coinModel){
    return List.generate(coinModel.coinList.length, (index) => Container(
      height: 68,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(coinModel.coinList[index].symbol,style: MyTextStyle.TEXT_S14_C33_W6,),
                    SizedBox(height: 2,),
                    Text("${FormatUtils.formatNumW(coinModel.coinList[index].availableSupply)}",style: MyTextStyle.TEXT_S12_C99,),
                  ],
                ),
              ),
              Container(
                width: 100,
                margin: EdgeInsets.only(right: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text("${coinModel.coinList[index].priceUsd}",style: MyTextStyle.TEXT_S14_C33_W6,),
//                  SizedBox(height: 2,),
//                  Text("¥${coinModel.coinList[index].rmb}",style: MyTextStyle.TEXT_S12_C99,),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate((50 - index) ~/ 10, (index) => Image.asset("images/coin_hot.png",width: 16,height: 16,)),
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 15,),
          Divider(height: 1,),
        ],
      ),
    ));
  }

  _refresh()async{
    CoinModel coinModel = Provider.of<CoinModel>(context);
    await coinModel.getCoinList();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}
