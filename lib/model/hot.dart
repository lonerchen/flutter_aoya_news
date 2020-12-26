class HotBean {
  int id;
  int columnId;
  String author;
  String title;
  List<String> keyWord;
  String resource;
  String resourceUrl;
  String summary;
  String thumbnail;
  int watchCounts;
  int upCounts;
  String resourceId;
  int isShow;
  String createdAt;
  String updatedAt;

  HotBean(
      {this.id,
        this.columnId,
        this.author,
        this.title,
        this.keyWord,
        this.resource,
        this.resourceUrl,
        this.summary,
        this.thumbnail,
        this.watchCounts,
        this.upCounts,
        this.resourceId,
        this.isShow,
        this.createdAt,
        this.updatedAt});

  static List<HotBean> formJsonList(dynamic jsonList){
    var list = List<HotBean>();
    jsonList.forEach((c){
      list.add(HotBean.fromJson(c));
    });
    return list;
  }

  HotBean.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    columnId = json['column_id'];
    author = json['author'];
    title = json['title'];
//    keyWord = json['key_word'].cast<String>();
    resource = json['resource'];
    resourceUrl = json['resource_url'];
    summary = json['summary'];
    thumbnail = json['thumbnail'];
    watchCounts = json['watch_counts'];
    upCounts = json['up_counts'];
//    resourceId = json['resource_id'];
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
