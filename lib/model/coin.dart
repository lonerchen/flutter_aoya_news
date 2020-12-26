
import 'package:flutter/cupertino.dart';
import 'package:flutter_aoya_news/http/dio_utils.dart';
import 'package:flutter_aoya_news/http/url.dart';

class CoinModel extends ChangeNotifier{

  List<CoinInfo> coinList = [];

  getCoinList() async{
    var result = await DioUtils.getInstance().post(URL.coinList,body: <String,dynamic>{
      "limit":50,
      "method":"api/v1/currency/ranks",
    });
    coinList = CoinInfo.formJsonList(result);
    print(result);
    notifyListeners();
  }

}

class CoinInfo {

  String id;//币种id
  String name;//币种名称
  String symbol;//币种简称
  int rank;//排名
  String logo;//logo地址
  String logoPng;//logo地址
  num priceUsd;//价格对比usdt
  num priceBtc;//价格对比比特币
  int volume24hUsd;//
  int marketCapUsd;
  int availableSupply;
  int totalSupply;
  int maxSupply;
  num percentChange1h;//一小时涨跌幅
  num percentChange24h;//24小时涨跌幅
  num percentChange7d;//七天涨跌幅
  int lastUpdated;//最后更新时间

  static List<CoinInfo> formJsonList(dynamic jsonList){
    var list = List<CoinInfo>();
    jsonList.forEach((c){
      list.add(CoinInfo.fromMap(c));
    });
    return list;
  }

  static CoinInfo fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    CoinInfo coinBean = CoinInfo();
    coinBean.id = map['id'];
    coinBean.name = map['name'];
    coinBean.symbol = map['symbol'];
    coinBean.rank = map['rank'];
    coinBean.logo = map['logo'];
    coinBean.logoPng = map['logo_png'];
    coinBean.priceUsd = map['price_usd'];
    coinBean.priceBtc = map['price_btc'];
    coinBean.volume24hUsd = map['volume_24h_usd'];
    coinBean.marketCapUsd = map['market_cap_usd'];
    coinBean.availableSupply = map['available_supply'];
    coinBean.totalSupply = map['total_supply'];
    coinBean.maxSupply = map['max_supply'];
    coinBean.percentChange1h = map['percent_change_1h'];
    coinBean.percentChange24h = map['percent_change_24h'];
    coinBean.percentChange7d = map['percent_change_7d'];
    coinBean.lastUpdated = map['last_updated'];
    return coinBean;
  }

  Map toJson() => {
    "id": id,
    "name": name,
    "symbol": symbol,
    "rank": rank,
    "logo": logo,
    "logo_png": logoPng,
    "price_usd": priceUsd,
    "price_btc": priceBtc,
    "volume_24h_usd": volume24hUsd,
    "market_cap_usd": marketCapUsd,
    "available_supply": availableSupply,
    "total_supply": totalSupply,
    "max_supply": maxSupply,
    "percent_change_1h": percentChange1h,
    "percent_change_24h": percentChange24h,
    "percent_change_7d": percentChange7d,
    "last_updated": lastUpdated,
  };
}

class Coin{
  String icon = "images/eth.png";//icon
  String name = "eth";//名称
  double float = -3.6;//浮动
  double price = 68290.49;//当前价格
  double rmb = 9641.53;//折合人民币 / 美金
  String sum = "1.24万亿";//总市值
  int hot = 3;//热度



}
