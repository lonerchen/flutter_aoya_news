/// id : 90444
/// title : "老曹论币 11.9  ETH  晚间行情分析"
/// author : "老曹论币"
/// thumbnail : "https://img.jinse.com/3803754_image1.png"
/// summary : "ETH  行情分析"
/// resource : "金色财经"
/// watch_counts : 0
/// created_at : "2020-11-09 18:36:44"

class Test {
  int id;
  String title;
  String author;
  String thumbnail;
  String summary;
  String resource;
  int watchCounts;
  String createdAt;

  Test({
      this.id, 
      this.title, 
      this.author, 
      this.thumbnail, 
      this.summary, 
      this.resource, 
      this.watchCounts, 
      this.createdAt});

  Test.fromJson(dynamic json) {
    id = json["id"];
    title = json["title"];
    author = json["author"];
    thumbnail = json["thumbnail"];
    summary = json["summary"];
    resource = json["resource"];
    watchCounts = json["watchCounts"];
    createdAt = json["createdAt"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["title"] = title;
    map["author"] = author;
    map["thumbnail"] = thumbnail;
    map["summary"] = summary;
    map["resource"] = resource;
    map["watchCounts"] = watchCounts;
    map["createdAt"] = createdAt;
    return map;
  }

}