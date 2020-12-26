import 'package:flutter/material.dart';
import 'package:flutter_aoya_news/http/dio_utils.dart';
import 'package:flutter_aoya_news/http/url.dart';

class BannerModel extends ChangeNotifier{

  List<BannerInfo> bannerInfo = [];

  getBanner()async{
    var result = await DioUtils.getInstance().post(URL.homeBanner,body: <String,dynamic>{
      "id":1,
    });
    try{
      bannerInfo = BannerInfo.formJsonList(result);
    }catch(e){
      print(e);
    }
    notifyListeners();
  }

}

class BannerInfo {
  int id;
  int columnId;
  int type;
  String images;
  String link;
  int order;
  String createdAt;
  String updatedAt;

  BannerInfo({int id, int columnId, int type, String images, String link, int order, String createdAt, String updatedAt}){
    id = id;
    columnId = columnId;
    type = type;
    images = images;
    link = link;
    order = order;
    createdAt = createdAt;
    updatedAt = updatedAt;
  }

  static List<BannerInfo> formJsonList(dynamic jsonList){
    var list = List<BannerInfo>();
    jsonList.forEach((c){
      list.add(BannerInfo.fromJson(c));
    });
    return list;
  }

  BannerInfo.fromJson(dynamic json) {
    id = json["id"];
    columnId = json["columnId"];
    type = json["type"];
    images = json["images"];
    link = json["link"];
    order = json["order"];
    createdAt = json["createdAt"];
    updatedAt = json["updatedAt"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["columnId"] = columnId;
    map["type"] = type;
    map["images"] = images;
    map["link"] = link;
    map["order"] = order;
    map["createdAt"] = createdAt;
    map["updatedAt"] = updatedAt;
    return map;
  }

}