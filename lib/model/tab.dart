

import 'package:flutter/cupertino.dart';
import 'package:flutter_aoya_news/http/dio_utils.dart';
import 'package:flutter_aoya_news/http/url.dart';

class TabModel extends ChangeNotifier{

  List<TabInfo> tabInfo = [];

  getTab()async{
    var result = await DioUtils.getInstance().get(
      URL.homeTab,
      params: <String,dynamic>{
        "id":1,
      },
    );
    tabInfo = TabInfo.formJsonList(result);
    notifyListeners();
  }

  

}


class TabInfo {
  int id;
  String title;
  String link;
  int type;
  String summary;
  String image;
  int order;
  int parentId;
  int status;
  String createdAt;
  String updatedAt;

  TabInfo({this.id, this.title, this.link, this.type, this.summary, this.image, this.order, this.parentId, this.status, this.createdAt, this.updatedAt});

  static List<TabInfo> formJsonList(dynamic jsonList){
    var list = List<TabInfo>();
    jsonList.forEach((c){
      list.add(TabInfo.fromJson(c));
    });
    return list;
  }

  TabInfo.fromJson(dynamic json) {
    id = json["id"];
    title = json["title"];
    link = json["link"];
    type = json["type"];
    summary = json["summary"];
    image = json["image"];
    order = json["order"];
    parentId = json["parentId"];
    status = json["status"];
    createdAt = json["createdAt"];
    updatedAt = json["updatedAt"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["title"] = title;
    map["link"] = link;
    map["type"] = type;
    map["summary"] = summary;
    map["image"] = image;
    map["order"] = order;
    map["parentId"] = parentId;
    map["status"] = status;
    map["createdAt"] = createdAt;
    map["updatedAt"] = updatedAt;
    return map;
  }

}

class TabContent{

  int id;
  String title;
  String author;
  String thumbnail;
  String summary;
  String resource;
  int watchCounts;
  String createdAt;

  static List<TabContent> formJsonList(dynamic jsonList){
    var list = List<TabContent>();
    jsonList.forEach((c){
      list.add(TabContent.fromJson(c));
    });
    return list;
  }

  TabContent({this.id, this.title, this.author, this.thumbnail, this.summary, this.resource, this.watchCounts, this.createdAt});

  TabContent.fromJson(dynamic json) {
    id = json["id"];
    title = json["title"];
    author = json["author"];
    thumbnail = json["thumbnail"];
    summary = json["summary"];
    resource = json["resource"];
    watchCounts = json["watch_counts"];
    createdAt = json["created_at"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["title"] = title;
    map["author"] = author;
    map["thumbnail"] = thumbnail;
    map["summary"] = summary;
    map["resource"] = resource;
    map["watch_counts"] = watchCounts;
    map["created_at"] = createdAt;
    return map;
  }

}

class TabContentDetails {
  int id;
  int columnId;
  String author;
  String title;
  Null keyWord;
  String resource;
  String resourceUrl;
  String summary;
  String content;
  String thumbnail;
  int watchCounts;
  int upCounts;
  int resourceId;
  int isShow;
  String createdAt;
  String updatedAt;

  TabContentDetails(
      {this.id, this.columnId, this.author, this.title, this.keyWord, this.resource, this.resourceUrl, this.summary, this.content, this.thumbnail, this.watchCounts, this.upCounts, this.resourceId, this.isShow, this.createdAt, this.updatedAt});

  TabContentDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    columnId = json['column_id'];
    author = json['author'];
    title = json['title'];
//    keyWord = json['key_word'];
    resource = json['resource'];
    resourceUrl = json['resource_url'];
    summary = json['summary'];
    content = json['content'];
    thumbnail = json['thumbnail'];
    watchCounts = json['watch_counts'];
    upCounts = json['up_counts'];
    resourceId = json['resource_id'];
    isShow = json['is_show'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['column_id'] = this.columnId;
    data['author'] = this.author;
    data['title'] = this.title;
    data['key_word'] = this.keyWord;
    data['resource'] = this.resource;
    data['resource_url'] = this.resourceUrl;
    data['summary'] = this.summary;
    data['content'] = this.content;
    data['thumbnail'] = this.thumbnail;
    data['watch_counts'] = this.watchCounts;
    data['up_counts'] = this.upCounts;
    data['resource_id'] = this.resourceId;
    data['is_show'] = this.isShow;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}