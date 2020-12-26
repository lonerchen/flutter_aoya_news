
import 'package:flutter/material.dart';
import 'package:flutter_aoya_news/app.dart';
import 'package:flutter_aoya_news/tab/tab_home.dart';
import 'package:flutter_aoya_news/utils/format.dart';
import 'package:flutter_aoya_news/value/colors.dart';
import 'package:flutter_aoya_news/value/style.dart';
import 'package:flutter_aoya_news/widget/base.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../model/coin.dart';

///
/// 价格排行
/// 
class QuotesPricePage extends StatefulWidget {

  final int type;

  QuotesPricePage(this.type);

  @override
  _QuotesPricePageState createState() => _QuotesPricePageState();
}

class _QuotesPricePageState extends State<QuotesPricePage>  with AutomaticKeepAliveClientMixin {

  List<CoinInfo> coinList = [];

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
            Text("24H涨跌幅(¥)",style: MyTextStyle.TEXT_S12_C99,),
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
          _refresh();
          _refreshController.refreshCompleted();
        },
        child: ListView(
          children: coinList.length > 0 ? _buildItem(coinModel) : BaseWidget.getEmptyWidget(),
        ),
      ),
    );
  }

  List<Widget> _buildItem(CoinModel coinModel){
    return List.generate(coinList.length, (index) => Container(
      height: 68,
      child: Column(
        children: [
          Row(
//            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(coinList[index].symbol,style: MyTextStyle.TEXT_S14_C33_W6,),
                    SizedBox(height: 2,),
                    Text("${FormatUtils.formatNumW(coinList[index].availableSupply)}",style: MyTextStyle.TEXT_S12_C99,),
                  ],
                ),
              ),
              Container(
                width: 100,
                margin: EdgeInsets.only(right: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text("${coinList[index].priceUsd}",style: MyTextStyle.TEXT_S14_C33_W6,),
//                  SizedBox(height: 2,),
//                  Text("¥${coinModel.coinList[index].priceUsd}",style: MyTextStyle.TEXT_S12_C99,),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      height: 35,
                      width: 88,
                      decoration: BoxDecoration(
                        color: coinList[index].percentChange24h >=0 ? MyColors.GREEN_UP_A5 : MyColors.RED_DOWN_78,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Center(
                        child: Text(
                          "${coinList[index].percentChange24h}%",
                          style: MyTextStyle.TEXT_S12_WHITE,
                        ),
                      ),
                    ),
                  ],
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

  //市值排序
  _sortPrice()async{
    CoinModel coinModel = Provider.of<CoinModel>(context);
    await coinModel.getCoinList();
    coinList = new List();
    coinList.addAll(coinModel.coinList);
    CoinInfo coinInfo;
    for(int i = 0;i < coinList.length - 1 ; i++){
      for(int j = 0; j < coinList.length - i - 1; j++){
        if(coinList[j].priceUsd < coinList[j + 1].priceUsd){
          coinInfo = coinList[j];
          coinList[j] = coinList[j+1];
          coinList[j+1] = coinInfo;
        }
      }
    }
    setState(() {

    });
  }

  //涨跌排序
  _sortFloat()async{
    CoinModel coinModel = Provider.of<CoinModel>(context);
    await coinModel.getCoinList();
    coinList = new List();
    coinList.addAll(coinModel.coinList);
    CoinInfo coinInfo;
    for(int i = 0;i < coinList.length - 1 ; i++){
      for(int j = 0; j < coinList.length - i - 1; j++){
        if(coinList[j].percentChange24h < coinList[j + 1].percentChange24h){
          coinInfo = coinList[j];
          coinList[j] = coinList[j+1];
          coinList[j+1] = coinInfo;
        }
      }
    }
    setState(() {

    });
  }

  _refresh(){
    Future.delayed(Duration.zero,(){
      if(widget.type == 1) {
        _sortPrice();
      }else if(widget.type == 2){
        _sortFloat();
      }
    });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}
